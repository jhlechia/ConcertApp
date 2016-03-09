// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// Renders the map
var neighborhoods = [
  {lat: 26.138, lng: -80.187},
  {lat: 26.108, lng: -80.157},
  {lat: 26.158, lng: -80.147},
  {lat: 26.168, lng: -80.167},
  {lat: 26.115, lng: -80.127},
  {lat: 26.148, lng: -80.137}
];

var markers = [];
var map;

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 26.128, lng: -80.147},
    zoom: 13
  });


// Geolocation. Sets map to user's geolocation
var infoWindow = new google.maps.InfoWindow({map: map});

if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      console.log((pos['lat']));
      console.log((pos['lng']));
      window.pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      infoWindow.setPosition(pos);
      infoWindow.setContent('Location found.');
      map.setCenter(pos);
    }, function() {
      handleLocationError(true, infoWindow, map.getCenter());
    });
  } else {
    // Browser doesn't support Geolocation
    handleLocationError(false, infoWindow, map.getCenter());
  }

  var geocoder = new google.maps.Geocoder;

  document.getElementById('submit').addEventListener('click', function() {
  geocodeAddress(geocoder, map);
});
  // Reverse Geocode
  // var infowindow = new google.maps.InfoWindow;

// Reverse Geocode
  // document.getElementById('submit').addEventListener('click', function() {
  //   geocodeLatLng(geocoder, map, infowindow);
  // });
}

function geocodeAddress(geocoder, resultsMap) {
  var address = document.getElementById('address').value;
  geocoder.geocode({'address': address}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
      resultsMap.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
        map: resultsMap,
        position: results[0].geometry.location
      });
      console.log("hi")
      console.log(marker['position'].lat());
      console.log(marker['position'].lng());

      // $("#location_lat").val(marker['position'].lat());
      // $("#location_lng").val(marker['position'].lng());

      $("#event_location").val(marker['position'].lat()+ ","+ marker['position'].lng());

      var input = document.getElementById('event_location').value;
      var latlngStr = input.split(',', 2);
      console.log(latlngStr);
      var latlng = {lat: parseFloat(latlngStr[0]), lng: parseFloat(latlngStr[1])};
      console.log(latlng);
      geocoder.geocode({'location': latlng}, function(results) {
        console.log(results[1].formatted_address);
      });

      window.marker = new google.maps.Marker({
        map: resultsMap,
        position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

function drop() {
  clearMarkers();
  for (var i = 0; i < neighborhoods.length; i++) {
    addMarkerWithTimeout(neighborhoods[i], i * 200);
  }
}

function addMarkerWithTimeout(position, timeout) {
  window.setTimeout(function() {
    markers.push(new google.maps.Marker({
      position: position,
      map: map,
      animation: google.maps.Animation.DROP
    }));
  }, timeout);
}

function clearMarkers() {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(null);
  }
  markers = [];
}

function geocodeLatLng(geocoder, map, infowindow) {
  var input = document.getElementById('latlng').value;
  var latlngStr = input.split(',', 2);
  var latlng = {lat: parseFloat(latlngStr[0]), lng: parseFloat(latlngStr[1])};
  geocoder.geocode({'location': latlng}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
      if (results[1]) {
        map.setZoom(11);
        var marker = new google.maps.Marker({
          position: latlng,
          map: map
        });
        infowindow.setContent(results[1].formatted_address);
        infowindow.open(map, marker);
      } else {
        window.alert('No results found');
      }
    } else {
      window.alert('Geocoder failed due to: ' + status);
    }
  });
}

// Reverse Geocode (take lat long, convert to)
// function geocodeLatLng(geocoder, map, infowindow) {
//   var input = document.getElementById('latlng').value;
//   var latlngStr = input.split(',', 2);
//   var latlng = {lat: parseFloat(latlngStr[0]), lng: parseFloat(latlngStr[1])};
//   geocoder.geocode({'location': latlng}, function(results, status) {
//     if (status === google.maps.GeocoderStatus.OK) {
//       if (results[1]) {
//         map.setZoom(11);
//         var marker = new google.maps.Marker({
//           position: latlng,
//           map: map
//         });
//         infowindow.setContent(results[1].formatted_address);
//         infowindow.open(map, marker);
//       } else {
//         window.alert('No results found');
//       }
//     } else {
//       window.alert('Geocoder failed due to: ' + status);
//     }
//   });
// }

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  infoWindow.setContent(browserHasGeolocation ?
                        'Error: The Geolocation service failed.' :
                        'Error: Your browser doesn\'t support geolocation.');
}
