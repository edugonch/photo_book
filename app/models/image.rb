class Image < ActiveRecord::Base

	belongs_to :user

	has_attached_file :file, styles: {
    	thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
  	}

  	validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

    scope :in_bounding_box, ->(coords){
      where(%{
          ST_Contains(
            ST_MakeEnvelope(#{coords}, 4326),
            ST_GeomFromText(
                  'SRID=4326;POINT(' || images.lng || ' ' || images.lat || ')'
            )
          )
        })
    }
end
