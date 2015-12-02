require 'hashie'

module Resterl
  class BaseObject
    include ClassLevelInheritableAttributes
    cattr_inheritable :resterl_client, :parser, :composer, :complete_mime_type,
                      :mapper
    attr_reader :response

    def initialize data = {}, response = nil
      @data = Hashie::Mash.new data
      @response = response
    end

    def method_missing sym, *args, &block
      @data.send sym, *args, &block
    end

    def respond_to? sym
      super || @data.respond_to?(sym)
    end

    class << self
      def get_object url, params = {}
        response = resterl_client.get(url, params, accept_header)
        new_from_response(response)
      end

      def post_to_object url, params = {}, data = {}
        post_put_object(:post, url, params, data)
      end

      def delete_object url
        resterl_client.delete(url, {}, accept_header, {})
      end

      def put_object url, params = {}, data
        post_put_object(:put, url, params, data)
      end

      def mime_type= t
        self.parser, self.composer, self.complete_mime_type =
          case t
          when :json
            [proc { |str| JSON.parse(str) },
             proc(&:to_json),
             'application/json'
            ]
          when :xml
            [proc { |str| Hash.from_xml(str) },
             proc(&:to_xml),
             'application/xml'
            ]
          end
      end

      private

      def post_put_object method, url, params, data
        headers = accept_header.merge(
          'Content-Type' => complete_mime_type
        )
        data = composer.call(data)
        response = resterl_client.send(method, url, params, data, headers)
        new_from_response response
      end

      def new_from_response response
        doc = response.body
        doc = parser.call(doc)
        doc = mapper.map(doc) if @mapper
        new(doc, response)
      end

      def accept_header
        { 'Accept' => complete_mime_type }
      end
    end
  end
end
