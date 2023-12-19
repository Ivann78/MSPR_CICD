<!DOCTYPE html>
<html lang="fr">

  <head>
    <meta charset="utf-8">
    <title>Carte</title>
    <meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no">

    <link href="https://api.mapbox.com/mapbox-gl-js/v3.0.1/mapbox-gl.css" rel="stylesheet">
    <script src="https://api.mapbox.com/mapbox-gl-js/v3.0.1/mapbox-gl.js"></script>
  </head>

  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="java.sql.*" %>

  <style>
    body {
      margin: 0;
      padding: 0;
    }

    #map {
      position: absolute;
      top: 0;
      bottom: 0;
      width: 100%;
    }
  </style>

  <body>

    <div id="map"></div>

    <script>
	    mapboxgl.accessToken = 'pk.eyJ1IjoiaXZhbm5tIiwiYSI6ImNscWM1ZHdwZzAxa3gyanBobGs4cDlndmQifQ.hOGfE1JWAq_vuiBHa5STxQ';
      const map = new mapboxgl.Map({
        container: 'map', // container ID
        style: 'mapbox://styles/mapbox/streets-v12', // style URL
        center: [2.0164672695160633, 48.774297748558794], // starting position
        zoom: 15 // starting zoom
      });
 
      // Add zoom and rotation controls to the map.
      map.addControl(new mapboxgl.NavigationControl());
      map.addControl(new mapboxgl.ScaleControl());


      map.on('load', () => {
        // Add an image to use as a custom marker
        map.loadImage(
          'https://docs.mapbox.com/mapbox-gl-js/assets/custom_marker.png',
          (error, image) => {
            if (error) throw error;
            map.addImage('custom-marker', image);
            // Add a GeoJSON source with 2 points
            map.addSource('points', {
              'type': 'geojson',
              'data': {
                'type': 'FeatureCollection',
                'features': [
                  {
                    // feature for Mapbox DC
                    'type': 'Feature',
                    'geometry': {
                      'type': 'Point',
                      'coordinates': [
                        2.0164672695160633, 48.774297748558794
                      ]
                    },
                    'properties': {
                      'title': 'CFI'
                    }
                  },
                  {
                    // feature for Mapbox SF
                    'type': 'Feature',
                    'geometry': {
                      'type': 'Point',
                      'coordinates': [-122.414, 37.776]
                    },
                    'properties': {
                      'title': 'Mapbox SF'
                    }
                  }
                ]
              }
            });

            // Add a symbol layer
            map.addLayer({
              'id': 'points',
              'type': 'symbol',
              'source': 'points',
              'layout': {
                'icon-image': 'custom-marker',
                // get the title name from the source's "title" property
                'text-field': ['get', 'title'],
                'text-font': [
                  'Open Sans Semibold',
                  'Arial Unicode MS Bold'
                ],
                'text-offset': [0, 1.25],
                'text-anchor': 'top'
              }
            });
          }
        );
      });
    </script>

  </body>

</html>