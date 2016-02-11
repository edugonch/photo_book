# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class PhotoBook.Views.Home
	@map = null
	constructor: (map, markers)->
		map_options = {
			geolocation: false
			infowindow: {
				borderBottomSpacing: 0,
				height: 120,
				width: 424,
				offsetX: 48,
				offsetY: -87
			}
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
