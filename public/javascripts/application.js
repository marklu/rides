var geocoder;
    
function initialize() {
  geocoder = new google.maps.Geocoder();
}

$(document).ready(function() { 
 initialize();

  $(function() {
    $("#trip_location_attributes_address, #person_location_attributes_address").autocomplete({
      source: function(request, response) {
        geocoder.geocode( {'address': request.term }, function(results, status) {
          response($.map(results, function(item) {
            return {
              label: item.formatted_address,
              value: item.formatted_address,
            }
          }));
        })
      }
    });
  });
});