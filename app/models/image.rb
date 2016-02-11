class Image < ActiveRecord::Base

	belongs_to :user
	
	has_attached_file :file: {
    	thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
  	}

  	validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
end
