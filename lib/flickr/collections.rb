class Flickr::Collections < Flickr::Base
  def initialize(flickr)
    @flickr = flickr
  end
  
  # Get the authorized user's collection tree.
  # 
  def get_tree_user(options={})
    rsp = @flickr.send_request('flickr.collections.getTree', options)
    collect_collections(rsp)
  end
    
  protected  
    def collect_collections(rsp)
      collections = []
      return collections if not rsp

			return collect_tree( rsp.collections )
    end


		def collect_tree( tree )
      collections = []

			if tree.collection
				tree.collection.each do |collection|
					collections << Collection.new( @flickr, create_attributes( collection ) )

					if collection.collection or collection.set
						collections << collect_tree( collection )
					end
				end
			end
			
			if tree.set
				tree.set.each do |set|
					collections << Flickr::Photosets::Photoset.new( @flickr, create_photoset_attributes( set ) )
				end
			end

			return collections
		end


    def create_attributes(collection)
      {
        :id => collection[:id], 
        :title => collection[:title],
        :description => collection[:description],
				:iconlarge => collection[:iconlarge],
				:iconsmall => collection[:iconsmall]
       }
    end

    def create_photoset_attributes(photoset)
      {
        :id => photoset[:id], 
        :num_photos => photoset[:photos],
        :title => photoset[:title],
        :description => photoset[:description]
       }
    end
end