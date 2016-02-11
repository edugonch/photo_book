class TagsController < ApplicationController
  def index
    unless params[:q]
      params[:q] = {term: ""}
    end

    @tags = Tag.match_tag(params[:q][:term].downcase).map{|result| result.description}.flatten
    respond_to do |format|
      format.json { render json: {results: @tags.map{|item| {id: item, text: item}} }.to_json }
    end
  end
end
