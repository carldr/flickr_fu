class Flickr::Tags < Flickr::Base
  def initialize(flickr)
    @flickr = flickr
  end
  
  # Get the authorized user's tag list.
  # 
  def get_list_user(options={})
    rsp = @flickr.send_request('flickr.tags.getListUser', options)
    collect_tags(rsp)
  end
    
  protected  
    def collect_tags(rsp)
      tags = []
      return tags if not rsp

      if rsp.who.tags
        rsp.who.tags.tag.each do |tag|
					tags << tag.to_s
        end
      end
      return tags
    end
end