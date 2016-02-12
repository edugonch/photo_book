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
          console.debug(mkr)
          markerLatLng = new (google.maps.LatLng)(mkr.lat, mkr.lng)
          infobox = new InfoBox(
            content: mkr.html
            disableAutoPan: false
            maxWidth: 0
            pixelOffset: new (google.maps.Size)(-140, 0)
            zIndex: null
            boxStyle:
              background: 'url(\'http://google-maps-utility-library-v3.googlecode.com/svn/trunk/infobox/examples/tipbox.gif\') no-repeat'
              width: '200px'
            closeBoxMargin: '12px 4px 2px 2px'
            closeBoxURL: 'http://www.google.com/intl/en_us/mapfiles/close.gif'
            infoBoxClearance: new (google.maps.Size)(1, 1)
            pane: 'floatPane'
            isHidden: false)
          marker = new (google.maps.Marker)(
            position: markerLatLng
            map: self.map
            title: 'Images in this point')
          marker.addListener 'click', ->
            infobox.open self.map, this
          self.markers.push(marker)
		   dataType: 'json'
		return
	constructor: (map, markers)->
		self = @
		map_options = {
			geolocation: false
			center: {
				lat: window.helper.LAT,
				lng: window.helper.LNG
			}
			zoom: 6
			marker: {
				height: 56,
				width: 56
			}
			cluster: {
				height: 40,
				width: 40,
				gridSize: map.data( 'grid-size' )
			}
			styles: window.helper.mapStyle(),
			markers: markers
		}
		@map = new (google.maps.Map)(map[0],map_options)
		google.maps.event.addListener @map, 'idle', ->
			self.loadMarkers()
			$('.infoBox').bxSlider
      	slideWidth: 200
      	minSlides: 2
      	maxSlides: 3
      	slideMargin: 10
