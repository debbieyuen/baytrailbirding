// ESLINT:
/* global L, moment, $ */


// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

// Const channels = require.context('.', true, /_channel\.js$/)
// Channels.keys().forEach(channels)

'use strict';

window.addEventListener('load', () => {
	const greenIcon = new L.Icon({
		iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png',
		shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
		iconSize: [25, 41],
		iconAnchor: [12, 41],
		popupAnchor: [1, -34],
		shadowSize: [41, 41]
	});
	const blueIcon = new L.Icon({
		iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-blue.png',
		shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
		iconSize: [25, 41],
		iconAnchor: [12, 41],
		popupAnchor: [1, -34],
		shadowSize: [41, 41]
	});
	const yellowIcon = new L.Icon({
		iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-yellow.png',
		shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
		iconSize: [25, 41],
		iconAnchor: [12, 41],
		popupAnchor: [1, -34],
		shadowSize: [41, 41]
	});

	let birdData = null;
	let birdImages = null;
	const mymap = L.map('mapid').setView([37.42, -121.91], 13);
	L.tileLayer('https://a.tiles.mapbox.com/styles/v1/lohneswright/ciocejooj006obdnjhmd2x9qp/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibG9obmVzd3JpZ2h0IiwiYSI6IngzbVlqNnMifQ.OwxjrBKoGXc60NB5x6GKzw', {
		maxZoom: 22
	}).addTo(mymap);

	const legend = L.control({
		position: 'topright'
	});
	legend.onAdd = function(map) {
		const div = L.DomUtil.create('div', 'legend');
		div.innerHTML += '<img src="https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png" height=41 width=25>Your Location<br>';
		div.innerHTML += '<img src="https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-gold.png" height=41 width=25>Bird-Watching Park<br>';
		div.innerHTML += '<img src="https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-blue.png" height=41 width=25>Recent Bird Sighting';
		div.style.background = 'silver';
		return div;
	};
	legend.addTo(mymap);

	function setContent(birddata, imgsrc, elem) {
		$(elem).empty();
		$(elem).append(
			`
      <img class="card-img-top" src="${imgsrc}">
      <div class="card-body">
        <h5 class="card-title">${birddata.comName}</h5>
        <h6 class="card-subtitle mb-2 text-muted">${birddata.sciName}</h6>
        <p class="card-text">${birddata.distTo} miles away, at ${birddata.locName}</p>
        <p class="card-text">reported ${moment(birddata.obsDt).fromNow()}</p>
      </div>
      <a href="https://ebird.org/species/${birddata.speciesCode}" class="btn btn-primary">View On Ebird</a>
      `
		);
	}


	function setContentLoc(i, birddata, imgsrc, elem) {
		$(elem)[i].innerHTML
      += `
        <center>
        <img class="card-img-top" src="${imgsrc}" style="width: 10rem; height: 10rem;">
        </center>
        <div class="card-body" style="padding: 0">
          <a href="https://ebird.org/species/${birddata.speciesCode}"> <h5 class="card-title">${birddata.comName}</h5> </a>
          <h6 class="card-subtitle mb-2 text-muted">${birddata.sciName}</h6>
          <h6> <p>Last Seen: ${moment(birddata.obsDt).fromNow()}</p></h6>
        </div>
      `;
	}

	function setMarker(birddata, index) {
		const marker = new L.Marker(
			L.latLng(birddata.lat, birddata.lng),
			{
				name: `bird_marker_${index}`,
				icon: blueIcon
			}
		);
		mymap.addLayer(marker);
		marker.bindPopup(`<b>${birddata.comName}</b><br/>${birddata.sciName}.`).openPopup();
		marker.on('click', markerOnClick);
		return marker;
	}

	function setLoc(locData) {
		const marker = new L.Marker(
			L.latLng(locData.latitude, locData.longitude),
			{
				name: locData.name,
				icon: yellowIcon
			}
		);
		mymap.addLayer(marker);
		const urlLoc = locData.name.replace(/ /g, '+');
		marker.bindPopup(`<center><b>${locData.name}</b></center>
                      <br/><img src="${locData.picURL}" width=300 height=200>
                      <br/> ${locData.short_desc}
                      <br/><a href="${locData.websiteURL}">Website</a>
                      <br/> <a href="https://www.google.com/maps/dir/?api=1&destination=${urlLoc}">Get Directions</a>`).openPopup();
		marker.on('click', locMarkerOnClick);
		return marker;
	}

	function getLocation() {
		if (navigator.geolocation) navigator.geolocation.getCurrentPosition(parallelHitEbirdEndpoint);
		else parallelHitEbirdEndpoint(null, new Error('no location'));
	}

	function markerOnClick(e) {
		const i = this.options.name.slice(-1);
		setContent(birdData[i], birdImages[i], $('#js-com_bird_info'));
	}

	function locMarkerOnClick(e) {
		const locName = e.sourceTarget.options.name;
		const lat = e.latlng.lat;
		const lng = e.latlng.lng;
		const settings = {
			url: '/ebird',
			method: 'POST',
			timeout: 0,
			data: {
				authenticity_token: '<%= form_authenticity_token %>',
				lat,
				lng,
				num_req: 100,
				num_ret: 9
			}
		};
		$.ajax(settings).done(response => {
			const birdDataLoc = response.birddata;
			const birdImagesLoc = response.imgsrc;
			const arrayLength = birdDataLoc.length;
			$('#RecentBirdList #header').html(`<center>Birds To Look Out For At ${locName}:</center>`);
			$('#RecentBirdList .scrolling-wrapper').html(
				`<div class="card"></div>
				<div class="card"></div>
				<div class="card"></div>
				<div class="card"></div>
				<div class="card"></div>
				<div class="card"></div>
				<div class="card"></div>
				<div class="card"></div>
				<div class="card"></div>`
			);
			for (let i = 0; i < arrayLength; i++) {
				setContentLoc(
					i,
					birdDataLoc[i],
					birdImagesLoc[i],
					$('#RecentBirdList .scrolling-wrapper .card')
				);
			}
		});
	}

	function createPos(form) {
		const pos = {
			coords: {
				latitude: parseFloat(form.lat.value),
				longitude: parseFloat(form.lng.value)
			}
		};
		parallelHitEbirdEndpoint(pos);
	}


	async function parallelHitEbirdEndpoint(pos, err) {
		if (err) {
			console.error(err);
			pos = {
				coords: {
					latitude: 37.8039,
					longitude: -122.2591
				}
			};
		}
		const curPos = new L.LatLng(pos.coords.latitude, pos.coords.longitude);
		mymap.panTo(curPos);
		const marker = new L.Marker(curPos, {
			icon: greenIcon
		});
		mymap.addLayer(marker);
		marker.bindPopup('<b>You are here</b>').openPopup();
		hitEbirdEndpoint(pos, false);
	}
	function hitEbirdEndpoint(pos) {
		const settings = {
			url: '/ebird',
			method: 'POST',
			timeout: 0,
			data: {
				authenticity_token: '<%= form_authenticity_token %>',
				lat: pos.coords.latitude,
				lng: pos.coords.longitude,
				num_req: 100,
				num_ret: 10
			}
		};
		$.ajax(settings).done(response => {
			const markers = [];
			birdData = response.birddata;
			birdImages = response.imgsrc;
			const arrayLength = birdData.length;
			for (let i = 0; i < arrayLength; i++) {
				setContent(birdData[i], birdImages[i], $('#js-com_bird_info'));
				markers.push(setMarker(birdData[i], i));
			}
			const group = new L.featureGroup(markers);
			mymap.fitBounds(group.getBounds().pad(0.2));
		});
	}

	getLocation();
	$('.j-location_info').each(function() {
		setLoc($(this).data('loc'));
	});
});
