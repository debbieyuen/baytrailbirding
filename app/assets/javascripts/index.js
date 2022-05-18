// ESLINT:
/* global L, moment, $ */


const MAX_RADIUS = 50;	// Radius distance in KM

/**
 * Unit conversions
 */
const Unit = {
  mi2km: mi => mi * 1.609,
  mi2m: mi => Unit.mi2km(mi) * 1000,
  km2mi: km => km / 1.609,
  m2mi: m => Unit.km2mi(m / 1000)
};

/**
 * AJAX Wrapper Class
 */
class API {
  /**
	 * Sends a GET request to url with data
	 * @param {string} url
	 * @param {Object} data
	 * @returns {Promise<Object>} response data
	 */
  static get(url, data) {
    const request = {
      method: 'GET',
      url,
      data
    };

    return new Promise(resolve => {
      $.ajax(request).done(data => resolve(data));
    });
  }
}

/**
 * Wrapper class to help distinguish locations
 */
class Location {
  /**
	 * Formatted location data
	 * @param {Object} location - Raw location data
	 */
  constructor(location) {
    Object.assign(this, JSON.parse(JSON.stringify(location)));
    this.latLng = L.latLng(this.latitude, this.longitude);
  }

  /**
	 * Converts raw location data into a formatted one
	 * @param {Object} location - Raw location data
	 * @returns {Location} Formatted location data
	 */
  static from(location) {
    return new Location(location);
  }
}

/**
 * Wrapper class to help distinguish hotspots
 * @property {Object} loc			- Location object
 * @property {string} loc.id		- Location ID
 * @property {string} loc.name		- Location Name
 * @property {number} loc.lat		- Location latitude
 * @property {number} loc.lng		- Location longitude
 * @property {L.LatLng} loc.latLng	- Location Leaflet position
 * @property {Object} code			- Code object
 * @property {string} code.country	- Country code
 * @property {string} code.subnat1	- Sub National Level 1 code
 * @property {string} code.subnat2	- Sub National Level 2 code
 * @property {Object} obs			- Observation object
 * @property {Date} obs.date		- Observation date
 * @property {number} cnt			- Number of birds at this hotspot
 */
class Hotspot {
  /**
	 * Formatted hotspot data
	 * @param {Object} hotspot - Raw hotspot data
	 */
  constructor(hotspot) {
    Object.assign(this, JSON.parse(JSON.stringify(hotspot)));
    this.obs.date = new Date(this.obs.date);
    this.loc.latLng = L.latLng(this.loc.lat, this.loc.lng);
  }

  /**
	 * Converts raw hotspot data into a formatted one
	 * @param {Object} hotspot - Raw hotspot data
	 * @returns {Hotspot} Formatted hotspot data
	 */
  static from(hotspot) {
    return new Hotspot(hotspot);
  }
}

/**
 * Wrapper class to help distinguish birds
 * @property {string} speciesCode	- Code of the species; can contain multiple subspecies
 * @property {string} subId			- ID of the bird observation; use this as the ID
 * @property {Object} name			- Name object of the bird
 * @property {string} name.sci		- Scientific name
 * @property {string} name.com		- Common name
 * @property {Object} loc			- Location object
 * @property {string} loc.id		- Location ID
 * @property {string} loc.name		- Location Name
 * @property {number} loc.lat		- Location latitude
 * @property {number} loc.lng		- Location longitude
 * @property {L.LatLng} loc.latLng	- Location Leaflet position
 * @property {boolean} loc.private	- Whether or not the location is private
 * @property {number} loc.dist		- Location distance from queried lat, long
 * @property {Object} obs			- Observation object
 * @property {Date} obs.date		- Observation date
 * @property {number} obs.cnt		- Observation count
 * @property {boolean} obs.valid	- Whether or not the observation is valid
 * @property {boolean} obs.reviewed	- Whether or not the observation has been reviewed
 * @property {null} img				- NOT CURRENTLY USED
 */
class Bird {
  /**
	 * Formatted bird data
	 * @param {Object} bird - Raw bird data
	 */
  constructor(bird) {
    Object.assign(this, JSON.parse(JSON.stringify(bird)));
    this.obs.date = new Date(this.obs.date);
    this.loc.latLng = L.latLng(this.loc.lat, this.loc.lng);
  }

  /**
	 * Converts raw bird data into a formatted one
	 * @param {Object} bird - Raw bird data
	 * @returns {Bird} Formatted bird data
	 */
  static from(bird) {
    return new Bird(bird);
  }
}

/**
 * Class to access our API
 */
class Ebird {
  /**
	 * Returns a list of birds from the ebird API through our API
	 * @example
	 * // Gets a list of birds WITHOUT hotspot
	 * await getBirds(37.8039, -122.2591, 15);
	 * @example
	 * // Gets a list of birds WITH hotspot
	 * await getBirds(0, 0, 0, 'L6530472');
	 * @param {number} lat - Latitude
	 * @param {number} lng - Longitude
	 * @param {number} radius - Radius/Distance from lat, lng in KM
	 * @param {hotspot} [hotspot] - OPTIONAL, ID of the hotspot
	 * @returns {Promise<Bird[]>} A promise to a list of formatted birds
	 */
  static async getBirds(lat, lng, radius, hotspot) {
    const url = '/ebird/birds';
    const data = {
      lat,
      lng,
      radius,
      hotspot
    };

    const birds = await API.get(url, data);

    return birds.map(Bird.from);
  }

  /**
	 * Returns a list of hotspots from the ebird API through our API
	 * @param {number} lat - Latitude
	 * @param {number} lng - Longitude
	 * @param {number} radius - Radius/Distance from lat, lng in KM
	 * @returns {Promise<Hotspot[]>} A promise to a list of formatted hotspots
	 */
  static async getHotspots(lat, lng, radius) {
    const url = '/ebird/hotspots';
    const data = {
      lat,
      lng,
      radius
    };

    const hotspots = await API.get(url, data);

    return hotspots.map(Hotspot.from);
  }

  /**
	 * Returns a list of locations from our API. Even though this is labeled in ebird,
	 * we keep it together to prevent creating another class
	 * @returns {Promise<Location[]>} A promise to a list of formatted locations
	 */
  static async getLocations(lat, lng) {
    const url = '/ebird/locations';
    const data = {};


    const locations = await API.get(url, data);
    return locations.map(Location.from);
  }
}

/**
 * The general map
 * @property {L.Map} map - Leaflet map instance
 * @property {L.Marker} position - Current user position marker
 * @property {L.Marker} selected - Currently selected marker
 * @property {L.MarkerClusterGroup} birds - Marker cluster representing a list of bird markers
 * @property {L.MarkerClusterGroup} hotspots - Marker cluster representing a list of hotspot markers
 * @property {L.MarkerClusterGroup} locations - Marker cluster representing a list of location markers
 * @property {L.LayerGroup} markers - Group of all markers (includes the birds, hotspots, and locations)
 */
class BirdMap {
  /**
	 * Creates the map
	 * @param {Element} elementId - Element for the map
	 * @param {L.LatLng} currentPosition - Leaflet LatLng object that contains the current position
	 */
  constructor(elementId, currentPosition) {
    const tileLayerSource = 'https://a.tiles.mapbox.com/styles/v1/lohneswright/ciocejooj006obdnjhmd2x9qp/tiles/{z}/{x}/{y}?access_token={accessToken}';

    const map = L.map(elementId).setView([37.42, -121.91], 13);

    L.tileLayer(tileLayerSource, {
      maxZoom: 22,
      accessToken: 'pk.eyJ1IjoibG9obmVzd3JpZ2h0IiwiYSI6IngzbVlqNnMifQ.OwxjrBKoGXc60NB5x6GKzw',
      attribution: '<a href="http://jawg.io" title="Tiles Courtesy of Jawg Maps" target="_blank">&copy; <b>Jawg</b>Maps</a> &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    this.map = map;

    this.setUserPosition(currentPosition);

    this.map.panTo(currentPosition);

    const km = MAX_RADIUS * 1000;

    const m = Math.floor(km * Math.sqrt(2));

    const bounds = currentPosition.toBounds(m);

    this.map.once('moveend', () => {
      this.map.setMinZoom(this.map.getZoom());

      this.birds = L.markerClusterGroup();
      this.hotspots = L.markerClusterGroup();
      this.locations = L.layerGroup();

      this.markers = L.layerGroup([this.birds, this.hotspots, this.locations]);

      this.markers.on('clusterclick', () => {
        if (this.selected) this.selected.setIcon(this.selected.defaultIcon);
        $('.overlay').attr('hidden', '');
      });

      this.selected = null;

      this.map.on('moveend', () => {
        this.load();
      });

      this.map.addLayer(this.markers);

      this.load();
    });

    this.map.fitBounds(bounds);
  }

  /**
	 * Generates a list of bird markers using the current position of the user.
	 * Keeps only birds that fit within the current boundaries.
	 * Keeps only birds that aren't near hotspots.
	 * Keeps only new birds that haven't been added yet.
	 * @returns {Promise<L.Marker[]>} A promise to a list of bird markers
	 */
  async getBirds() {
    const { lat, lng } = this.getCurrPosition();
    const birds = await Ebird.getBirds(lat, lng, this.getRadius());
    const bounds = this.map.getBounds();
    const markers = birds
      .filter(bird => bounds.contains(bird.loc.latLng))
      .map(bird => this.createBird(bird))
      .filter(birdMarker => !this.hotspots.getLayers().find(hotspotMarker => hotspotMarker.getLatLng().equals(birdMarker.getLatLng())));

    return markers;
  }

  /**
	 * Generates a list of hotspot markers using the current position of the user
	 * Keeps only hotspots that fit within the current boundaries.
	 * Keeps only new hotspots that haven't been added yet.
	 * @returns {Promise<L.Marker[]>} A promise to a list of hotspot markers
	 */
  async getHotspots() {
    const { lat, lng } = this.getCurrPosition();
    const hotspots = await Ebird.getHotspots(lat, lng, this.getRadius());
    const bounds = this.map.getBounds();
    const markers = hotspots
      .filter(hotspot => bounds.contains(hotspot.loc.latLng))
      .map(hotspot => this.createHotspot(hotspot));

    return markers;
  }

  /**
	 * Generates a list of location markers using the current position of the user
	 * Keeps only new locations that haven't been added yet.
	 * @returns {Promise<L.Marker[]>} A promise to a list of location markers
	 */
  async getLocations() {
    const { lat, lng } = this.getCurrPosition();
    const locations = await Ebird.getLocations(lat, lng);
    const markers = locations
      .map(location => this.createLocation(location));

    return markers;
  }

  /**
	 * Creates a marker, but DOES NOT add it to the map
	 * @param {L.LatLng} latLng - Location of the marker
	 * @param {string} customId - Marker identifier to prevent duplicate markers
	 * @param {L.Icon} icon - Icon shown on map when the marker is NOT selected
	 * @param {L.Icon} selectedIcon - Icon shown on map when the marker IS selected
	 * @returns {L.Marker} Newly generated marker
	 */
  createMarker(latLng, customId, icon, selectedIcon) {
    /**
		 * @property {L.Icon} defaultIcon - Icon shown on map when the marker is NOT selected
		 * @property {L.Icon} selectedIcon - Icon shown on map when the marker IS selected
		 * @property {string} customId - Marker identifier to prevent duplicate markers
		 */
    const marker = L.marker(latLng, {
      icon,
      riseOnHover: true
    });

    marker.defaultIcon = icon;
    marker.selectedIcon = selectedIcon;
    marker.customId = customId;

    /**
		 * On click:
		 * 		deselect the old marker
		 * 		select the current marker
		 * 		pan to the current marker
		 */
    marker.on('click', () => {
      const position = marker.getLatLng();
      if (this.selected) this.selected.setIcon(this.selected.defaultIcon);
      this.selected = marker;
      this.selected.setIcon(selectedIcon);
      this.setCurrPosition(position);
    });

    return marker;
  }

  /**
	 * Creates a bird marker
	 * @param {Bird} bird - Formatted bird data
	 * @returns {L.Marker} Marker representing a bird
	 */
  createBird(bird) {
    const { latLng } = bird.loc;

    const icon = L.divIcon({
      html: '<i class="fa-solid fa-dove fa-2x"></i>',
      iconSize: [20, 20],
      className: 'bird-icon'
    });

    const selectedIcon = L.divIcon({
      html: '<i class="fa-solid fa-dove fa-2x"></i>',
      iconSize: [20, 20],
      className: 'bird-icon-selected'
    });

    const marker = this.createMarker(latLng, bird.subId, icon, selectedIcon);

    /**
		 * On click:
		 * 		displays the bird
		 */
    marker.on('click', () => {
      $('.overlay')
        .html(`
					<div class="expand-icon"></div>
					<div class="content">
						<div class="bird-name">${bird.name.com}</div>
						<div class="science-name">${bird.name.sci}</div>
						<div class="bird-img-wrapper">
							<img class="bird-img" src="/duck.png">
						</div>
						<div class="location-wrapper">
							<div class="location">Loc</div>
							<div class="separator"><i class="fa-solid fa-circle"></i></div>
							<div class="distance">${Unit.m2mi(marker.getLatLng().distanceTo(this.getUserPosition())).toFixed(2)} mi</div>
						</div>
						<div class="description-wrapper">
							<div class="description-header">Description:</div>
							<div class="description-content">No Description Available</div>
					</div>
					</div>
				`)
        .removeAttr('hidden');
    });

    return marker;
  }

  /**
	 * Creates a hotspot marker
	 * @param {Hotspot} hotspot - Formatted hotspot data
	 * @returns {L.Marker} Marker representing a hotspot
	 */
  createHotspot(hotspot) {
    const { latLng } = hotspot.loc;

    const icon = L.divIcon({
      html: '<i class="fa-solid fa-binoculars fa-2x"></i>',
      iconSize: [20, 20],
      className: 'hotspot-icon'
    });

    const selectedIcon = L.divIcon({
      html: '<i class="fa-solid fa-binoculars fa-2x"></i>',
      iconSize: [20, 20],
      className: 'hotspot-icon-selected'
    });

    const marker = this.createMarker(latLng, hotspot.loc.id, icon, selectedIcon);

    /**
		 * On click:
		 * 		displays the hotspot
		 * 		gets a list of birds at the hotspot
		 * 		displays the birds on a grid with the hotspot data
		 */
    marker.on('click', () => {
      // TODO: See implementation comment above
    });

    return marker;
  }

  /**
	 * Creates a location marker
	 * @param {Location} hotsplocationot - Formatted location data
	 * @returns {L.Marker} Marker representing a location
	 */
  createLocation(location) {
    const { latLng } = location;
    const icon = L.divIcon({
      html: '<i class="fa-solid fa-location-dot fa-2x"></i>',
      iconSize: [80, 80],
      className: 'location-icon'
    });

    const selectedIcon = L.divIcon({
      html: '<i class="fa-solid fa-location-dot fa-2x"></i>',
      iconSize: [80, 80],
      className: 'location-icon-selected'
    });
    const marker = this.createMarker(latLng, location.id, icon, selectedIcon);

    /**
		 * On click:
		 *   displays the bird
		 */
    marker.on('click', () => {
      $('.overlay')
        .html(`
					<div class="expand-icon"></div>
					<div class="content">
						<div class="bird-name">${location.name}</div>
						<div class="bird-img-wrapper">
							<img class="bird-img" src="${location.picURL}" width=50% height=50%>
						</div>
						<div class="location-wrapper">
							<div class="location">Loc</div>
							<div class="separator"><i class="fa-solid fa-circle"></i></div>
							<div class="distance">${Unit.m2mi(marker.getLatLng().distanceTo(this.getUserPosition())).toFixed(2)} mi</div>
						</div>
						<div class="description-wrapper">
							<div class="description-header">Description:</div>
							<div class="description-content">${location.description}</div>
					</div>
					</div>
				`)
        .removeAttr('hidden');
    });

    return marker;
  }

  /**
	 * Loads the markers for the hotspots, then the birds
	 */
  async load() {
    const hotspots = await this.getHotspots();
    this.hotspots.insert(...hotspots);

    const birds = await this.getBirds();
    this.birds.insert(...birds);

    const locations = await this.getLocations();
    this.locations.insert(...locations);
  }

  /**
	 * Offset pans to the marker with the target position
	 * @param {L.LatLng} latLng - The location of the marker to offset pan to
	 */
  setCurrPosition(latLng) {
    this.map.panToOffset(latLng, [window.innerWidth / 4, 0]);
  }

  /**
	 * Gets the center of the map, setCurrPosition and getCurrPosition are NOT the same
	 * @returns {L.LatLng} The location of the center of the map
	 */
  getCurrPosition() {
    return this.map.getCenter();
  }

  /**
	 * Sets the position of the user marker. If no marker exists, create it
	 * @param {L.LatLng} latLng - Position of the user
	 */
  setUserPosition(latLng) {
    if (!this.position) {
      const icon = L.divIcon({
        html: '<i class="fa-solid fa-street-view fa-3x"></i>',
        iconSize: [20, 20],
        className: 'user-icon'
      });

      const marker = L.marker(latLng, {
        icon,
        riseOnHover: true
      });
      this.position = marker;
      this.map.addLayer(this.position);
    }
    this.position.setLatLng(latLng);
  }

  /**
	 * Get the current user position
	 * @returns {L.LatLng} Position of the user
	 */
  getUserPosition() {
    return this.position.getLatLng();
  }

  /**
	 * Calculates the radius given the current map boundaries. This is critical for loading data.
	 * @returns {number} Radius in KM
	 */
  getRadius() {
    const bounds = this.map.getBounds();
    const ne = bounds.getNorthEast();
    const nw = bounds.getNorthWest();
    const m = nw.distanceTo(ne);
    const km = m / 1000;
    const r = Math.min(Math.ceil(km / Math.sqrt(2)), MAX_RADIUS);

    return r;
  }
}

/**
 * Wrapper of geolocation API
 */
class GPS {
  /**
	 * Creates a new GPS. Prevents us from having too many watchers.
	 */
  constructor() {
    this.watchId = null;
  }

  /**
	 * Fetches the current user location
	 * @param {number} defaultLat - Default latitude
	 * @param {number} defaultLng - Default longitude
	 * @returns {Promise<L.LatLng>} A promise to the user's current location
	 */
  getCurrentPosition(defaultLat, defaultLng) {
    const defaultPosition = L.latLng(defaultLat, defaultLng);

    const options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
    };

    return new Promise(resolve => {
      navigator.geolocation.getCurrentPosition(
        position => {
          const {
            coords
          } = position;
          const {
            latitude, longitude
          } = coords;

          resolve(L.latLng(latitude, longitude));
        },
        () => resolve(defaultPosition),
        options
      );
    });
  }

  /**
	 * Watches the current user's position and calls `onPosChange` when the user's position changes
	 * @callback onPosChange
	 * 		@param {L.LatLng} latLng - Contains the position of the user
	 * @returns {number} Watch ID
	 */
  watchCurrentPosition(onPosChange) {
    const defaultPosition = L.latLng(defaultLat, defaultLng);

    const options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
    };

    const watchId = navigator.geolocation.watchPosition(
      position => {
        const {
          coords
        } = position;
        const {
          latitude, longitude
        } = coords;

        onPosChange(L.latLng(latitude, longitude));
      },
      () => onPosChange(defaultPosition),
      options
    );
    this.watchId = watchId;

    return watchId;
  }

  /**
	 * Clear the current watch
	 */
  clearWatchCurrentPosition() {
    if (!this.watchId) throw new Error('Not currently watching position');

    navigator.geolocation.clearWatch(this.watchId);

    this.watchId = null;
  }
}

// Keep these variables outside, so you can use the console inspection tool to debug
let mymap = null;
let gps = null;

window.addEventListener('load', async () => {
  /**
	 * Pan to location on map with an offset
	 * @param {L.LatLng} latlng - Position to pan to
	 * @param {[xOffset: number, yOffset: number]} offset - Pairing of x and y offsets in PX values
	 * @param {Object} [options] - OPTIONAL, additional pan options
	 * @returns {L.Map} Map
	 */
  L.Map.prototype.panToOffset = function(latlng, offset, options) {
    const x = this.latLngToContainerPoint(latlng).x - offset[0];
    const y = this.latLngToContainerPoint(latlng).y - offset[1];
    const point = this.containerPointToLatLng([x, y]);
    return this.setView(point, this.getZoom(), {
      pan: options
    });
  };

  /**
	 * Inserts layer(s) to a map. Excludes duplicate markers.
	 * @param {...L.Marker} layers - Each argument is processed as a different layer
	 * @returns {L.LayerGroup[]} List of the same layer group. This is really not needed, but is good to have
	 */
  L.LayerGroup.prototype.insert = function(...layers) {
    return layers.map(layer => {
      if (this.getLayers().find(currLayer => currLayer.customId === layer.customId)) return null;
      return this.addLayer(layer);
    });
  };

  // Initialize the GPS
  gps = new GPS();

  // Load the map
  mymap = new BirdMap('leaflet-map', await gps.getCurrentPosition(37.8039, -122.2591));

  $('#navigation').click(() => {
    document.querySelector('nav').toggleAttribute('hidden');
  });
});
