class AddIndexToImageCoordinates < ActiveRecord::Migration
  def up
    execute %{
      create index index_on_images_location ON images using gist (
        ST_GeographyFromText(
          'SRID=4326;POINT(' || images.lat || ' ' || images.lng || ')'
        )
      )
    }
  end

  def down
    execute %{drop index index_on_images_location}
  end
end
