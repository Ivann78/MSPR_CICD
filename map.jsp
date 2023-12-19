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

    <%-- <div id='map' style='width: 1000px; height: 1000px;'></div> --%>
    <div id="map"></div>

    <%-- <script>
      mapboxgl.accessToken = 'pk.eyJ1IjoiaXZhbm5tIiwiYSI6ImNscWM1ZHdwZzAxa3gyanBobGs4cDlndmQifQ.hOGfE1JWAq_vuiBHa5STxQ';
      var map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v11'
      });
    </script> --%>

    <script>
	    mapboxgl.accessToken = 'pk.eyJ1IjoiaXZhbm5tIiwiYSI6ImNscWM1ZHdwZzAxa3gyanBobGs4cDlndmQifQ.hOGfE1JWAq_vuiBHa5STxQ';
      const map = new mapboxgl.Map({
        container: 'map', // container ID
        style: 'mapbox://styles/mapbox/streets-v12', // style URL
        //center: [-74.5, 40], // starting position
        center: [2.0164672695160633, 48.774297748558794],
        zoom: 15 // starting zoom
      });
 
      // Add zoom and rotation controls to the map.
      map.addControl(new mapboxgl.NavigationControl());
    </script>

  </body>

</html>