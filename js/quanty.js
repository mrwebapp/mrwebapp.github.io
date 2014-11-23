// ----------------------------------
// General
// ----------------------------------

function toggle_visibility(id) {
       var e = document.getElementById(id);
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
    }

var x = document.getElementById("error");

function plz_gdenr(plz) {
    content=document.getElementById('content');
    $.getJSON( "./data/json/plz_gdenr.json" )
        .done(function( json ) {
            content.innerHTML=json[2].4500;
        })
        .fail(function( jqxhr, textStatus, error ) {
            var err = textStatus + ", " + error;
        content.innerHTML= "Request Failed: " + err;
});
    
}

// ----------------------------------
// Maps API related Functions
// ----------------------------------

function getLocation()
  {
  if (navigator.geolocation)
	{
	navigator.geolocation.getCurrentPosition(showPosition,showError);
	}
  else{x.innerHTML="Geolocation is not supported by this browser.";}
  }

function showPosition(position)
  {
  lat=position.coords.latitude;
  lon=position.coords.longitude;
  latlon=new google.maps.LatLng(lat, lon);
  mapholder=document.getElementById('mapholder');
  address=document.getElementById('address');

  var myOptions={
  center:latlon,zoom:13,
  mapTypeId:google.maps.MapTypeId.ROADMAP,
  mapTypeControl:false,
   disableDefaultUI: true,
	  //navigationControlOptions:{style:google.maps.NavigationControlStyle.SMALL}
  };
  var map=new google.maps.Map(mapholder,myOptions);
  var marker=new google.maps.Marker({position:latlon,map:map,title:"You are here!"});
	 geocoder = new google.maps.Geocoder();
	 geocoder.geocode({'latLng': latlon}, function(results, status) {
     if (status == google.maps.GeocoderStatus.OK) {
      	if (results[1]) {
      	address.innerHTML=results[0].formatted_address;
//      address.innerHTML=results[1].address_components[0].long_name;


   			//var zip = '4103';
	 		var zip = results[0].address_components[8].long_name;
	 		//$('div#content').text(zip);
		  	if($.trim(zip) != ''){
			  	$.post( "ajax/return.php", { zip: zip}, function(data) {
		 	//$.post('ajax/return.php', 'zip: zip', function(data) {
			 		$('div#content').text(data)});
	  			} else {
        			alert('No results found');
	  			}
    		} else {
      			alert('Geocoder failed due to: ' + status);
    		}
	 }});
  }

function showError(error)
  {
  toggle_visibility('error');
  switch(error.code)
	{
	case error.PERMISSION_DENIED:
	  x.innerHTML="User denied the request for Geolocation."
	  break;
	case error.POSITION_UNAVAILABLE:
	  x.innerHTML="Location information is unavailable."
	  break;
	case error.TIMEOUT:
	  x.innerHTML="The request to get user location timed out."
	  break;
	case error.UNKNOWN_ERROR:
	  x.innerHTML="An unknown error occurred."
	  break;
	}
  }

// ----------------------------------
// Data
// ----------------------------------

// Get Data
 $('#getloc').click(function() {
	 //alert('hello');

 });
