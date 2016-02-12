class HomeController < ApplicationController
	def index
    respond_to do |format|
      format.json do
        @images = Image.in_bounding_box(params[:coordinates]).group_by{|img| "#{img.lat}#{img.lng}"}
        json_format = MarkersSerializer.new(@images).to_json
        render json: json_format, root: false
      end
      format.html do |format|
      end
    end
	end
end
