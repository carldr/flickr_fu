class Flickr::Collections::Collection
  attr_accessor :id,:title,:description,:iconlarge,:iconsmall
  
  def initialize(flickr, attributes)
    @flickr = flickr
    attributes.each do |k,v|
      send("#{k}=", v)
    end
  end
end
