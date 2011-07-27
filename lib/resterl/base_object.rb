require 'hashie'

# Idee: If-Match wäre bei .delete_object und .put_object ein interessantes
#       Feature.

class Resterl::BaseObject #< Hashie::Mash

  include ClassLevelInheritableAttributes
  cattr_inheritable :resterl_client, :parser, :composer, :complete_mime_type,
                    :mapper
  attr_reader :response

  #self.resterl_client = nil
  #self.complete_mime_type = 'text/plain'

  def initialize data = {}, response = nil
    @data = Hashie::Mash.new data
    @response = response
  end

  def method_missing sym, *args, &block
    # Vielleicht lassen sich auch feste Attribute delegieren, das wäre als
    # method_missing.
    @data.send sym, *args, &block
  end

  protected

  def self.get_object url, params = {}
    headers = { 'Accept' => complete_mime_type }
    response = resterl_client.get(url, params, headers)
    doc = response.body
    doc = parser.call(doc)
    doc = mapper.map(doc) if @mapper
    new(doc, response)
  end
  
  def self.post_to_object url, params = {}, data = {}
    # TODO: Refactoring

    headers = {
      'Accept' => complete_mime_type,
      'Content-Type' => complete_mime_type
    }
    data = composer.call(data)
    response = resterl_client.post(url, params, data, headers)
    
    doc = response.body
    doc = parser.call(doc)
    doc = mapper.map(doc) if @mapper
    new(doc, response)
  end
  
  def self.delete_object url
    headers = {
      'Accept' => complete_mime_type,
    }
    resterl_client.delete(url, {}, headers, {})
    # TODO: Antwort parsen?
  end
  
  def self.put_object url, params = {}, data
    # TODO: Refactoring
    
    headers = {
      'Accept' => complete_mime_type,
      'Content-Type' => complete_mime_type
    }
    data = composer.call(data)
    response = resterl_client.put(url, params, data, headers)
    
    doc = response.body
    doc = parser.call(doc)
    doc = mapper.map(doc) if @mapper
    
    # TODO: In Ordnung?
    new(doc, response)
  end
  

  def self.mime_type= t
    self.parser, self.composer, self.complete_mime_type = case t
    when :json
      # TODO prio 2: Only works when Rails is loaded?
      [ proc {|str| JSON.parse(str)},
        proc(&:to_json),
        'application/json'
      ]
    when :xml
      # TODO prio 2: Only works when Rails is loaded?
      [ proc {|str| Hash.from_xml(str)},
        proc(&:to_xml),
        'application/xml'
      ]
    end
  end

end
