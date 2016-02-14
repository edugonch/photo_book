# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class PhotoBook.Views.Tags
	constructor: ->
		$('#search_by_tags').select2
         placeholder: "Search by tags"
         width: '200px'
	        multiple: true
	        ajax:
	          global: false
	          url: Routes.tags_path() + ".json"
	          dataType: 'json'
	          data: (term, page) ->
	            { q: term }
	          results: (data, page) ->
	            { results: data }
	          cache: false
	      return

$(document).on 'ready page:load', ->
	new (PhotoBook.Views.Tags)