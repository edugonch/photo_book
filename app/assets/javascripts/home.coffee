# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class PhotoBook.Views.Home
	@map = null
	self = []
	@markers = []
	loadMarkers: ()->
		console.debug self.map.getBounds()
		bounds = self.map.getBounds()
		ne = bounds.getNorthEast()
		sw = bounds.getSouthWest()
		$.ajax
		  url: Routes.home_path() + '.json'
		  data: {"coordinates": sw.lng() + ',' + sw.lat() + ',' + ne.lng() + ',' + ne.lat()}
		  success: (response) ->
        console.debug response
        for mkr in response
          self.map.addMarker(
            lat: mkr.lat
            lng: mkr.lng
            infoWindow:
              content: mkr.html
              domready: ->
                $('#' + mkr.name).flexslider(
                	animation: "slide"
                	animationLoop: false
                	itemWidth: 100
                	itemMargin: 3))
		return
	constructor: (div, markers)->
		self = @
		map_options = {
			geolocation: false
			div: div
			lat: window.helper.LAT,
			lng: window.helper.LNG
			zoom: 6
			styles: window.helper.mapStyle(),
			idle: ->
			  self.loadMarkers()
		}
		@map = new (GMaps)(map_options)
