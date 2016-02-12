class MarkersSerializer
  include ActionView::Helpers::OutputSafetyHelper

  def initialize(array)
    @array = array
  end

  def to_json
    @view ||= define_view

    @array.map do |key, images|
      tmp_id = DateTime.now.to_i
      {
        lat: images.first.lat,
        lng: images.first.lng,
        name: tmp_id,
        html: @view.render(file: 'images/_image_map_marker_content.html.erb', locals: { images: images, name: tmp_id })
      }
    end
  end

private
  def define_view
    view = ActionView::Base.new(Rails.configuration.paths["app/views"])
    view.config = Rails.application.config.action_controller
    view.class_eval do
          include Rails.application.routes.url_helpers
          include ApplicationHelper

          def protect_against_forgery?
            false
          end
      end
      view
  end
end