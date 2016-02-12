# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class PhotoBook.Views.NewImage
  @map = null
  self = []
  @marker = null
  constructor: (map)->
    self = @
    self.setPosition = (pos)->
      $('input[data-field="lat"]').val(pos.lat())
      $('input[data-field="lng"]').val(pos.lng())
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
      styles: window.helper.mapStyle()
    }
    @map = new (google.maps.Map)(map[0],map_options)
    pos = new google.maps.LatLng(window.helper.LAT, window.helper.LNG);
    @marker = new (google.maps.Marker)(
      position: pos
      draggable: true
      map: @map)
    google.maps.event.addListener @marker, 'dragend', ->
      self.setPosition self.marker.getPosition()
      return
    $('#images').closest("form").on 'cocoon:before-insert', (e, insertedItem) ->
      console.debug(e)
      $(insertedItem).find('input[data-field="lat"]').val(self.marker.getPosition().lat())
      $(insertedItem).find('input[data-field="lng"]').val(self.marker.getPosition().lng())
      desc = $(insertedItem).find('input[data-field="desc"]')
      rx = /user\[images_attributes\]\[([0-9]+)\]\[description\]/g
      arr = rx.exec(desc.attr('name'))
      $(insertedItem).find('#select_change').attr('name', 'user[images_attributes][' + arr[1] + '][tags][]')
      $(insertedItem).find('#select_change').attr('id', 'user_images_attributes_' + arr[1] + '_tags')
      $(insertedItem).find('select[data-field="tag"]').select2
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
