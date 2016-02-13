# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class PhotoBook.Views.Home
	@map = null
	self = []
	@markers = []
	prepareInfoWindow: ->
	    console.log("prepare info")
	    iwOuter = $('.gm-style-iw')
	    iwBackground = iwOuter.prev()
	    iwBackground.children(':nth-child(2)').css 'display': 'none'
	    iwBackground.children(':nth-child(4)').css 'display': 'none'
	    iwOuter.parent().parent().css left: '115px'
	    iwBackground.children(':nth-child(1)').attr 'style', (i, s) ->
	      s + 'left: 76px !important;'
	    iwBackground.children(':nth-child(3)').attr 'style', (i, s) ->
	      s + 'left: 76px !important;'
	    iwBackground.children(':nth-child(3)').find('div').children().css
	      'box-shadow': 'rgba(72, 181, 233, 0.6) 0px 1px 6px'
	      'z-index': '1'
	    iwCloseBtn = iwOuter.next()
	    iwCloseBtn.css
	      opacity: '1'
	      right: '38px'
	      top: '3px'
	      border: '7px solid #48b5e9'
	      'border-radius': '13px'
	      'box-shadow': '0 0 5px #3990B9'
	    if $('.iw-content').height() < 140
	      $('.iw-bottom-gradient').css display: 'none'
	    iwCloseBtn.mouseout ->
	      $(this).css opacity: '1'
	      return
	    return
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
             maxWidth: 350
             domready: self.prepareInfoWindow)
            
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
