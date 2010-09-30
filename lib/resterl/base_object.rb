require 'hashie'

class Resterl::BaseObject #< Hashie::Mash

  include ClassLevelInheritableAttributes
  cattr_inheritable :resterl_client, :parser, :complete_mime_type, :mapper

  #self.resterl_client = nil
  #self.complete_mime_type = 'text/plain'

  def initialize data = {}
    @data = Hashie::Mash.new data
  end

  def method_missing sym, *args, &block
    # Vielleicht lassen sich auch feste Attribute delegieren, das wäre als
    # method_missing.
    @data.send sym, *args, &block
  end

  protected

  def self.get_object url, params = {}
    headers = { 'Accept' => complete_mime_type }
    doc = resterl_client.get(url, params, headers).body
    doc = parser.call(doc)
    doc = mapper.map(doc) if @mapper
    new(doc)
  end

  def self.mime_type= t
    self.parser, self.complete_mime_type = case t
    when :json
      [proc {|str| JSON.parse(str)}, 'application/json']
    when :xml
      # TODO: Only works when Rails is loaded?
      [proc {|str| Hash.from_xml(str)}, 'application/xml']
    end
  end

end
