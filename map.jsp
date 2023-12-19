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
  <%@ page import="java.util.List" %>
  <%@ page import="java.util.ArrayList" %>


  <% 
    String url = "jdbc:mariadb://localhost:3306/equipements";
    String user = "mysql";
    String password = "mysql";

    List<List<String>> coords = new ArrayList<>();

    // Charger le pilote JDBC
    Class.forName("org.mariadb.jdbc.Driver");

    // Établir la connexion
    Connection conn = DriverManager.getConnection(url, user, password);
    // Exemple de requête SQL
    String sql = "SELECT equi_id, equi_libelle, equi_lat, equi_long, get_distance_metres('48.858205', '2.294359', equi_lat, equi_long) AS proximite FROM equipement HAVING proximite < 1000 ORDER BY proximite ASC LIMIT 10;";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    // Afficher les résultats (à adapter selon vos besoins)
    while (rs.next()) {
        String colonne1 = rs.getString("equi_libelle");
        String colonne2 = rs.getString("equi_lat");
        String colonne3 = rs.getString("equi_long");

        List<String> data = new ArrayList<>();
        data.add(colonne1);
        data.add(colonne2);
        data.add(colonne3);

        coords.add(data);

        // out.println("Batiment : " + colonne1 + ", latitude : " + colonne2 + ", Longitude : " + colonne3 + "</br>");
    }

    // Fermer les ressources 
    rs.close();
    pstmt.close();
    conn.close();
  %>

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



<%
                    for (int i = 0; i < coords.size(); i++) {
                      List<String> data = coords.get(i);
                      out.print(data.get(0)); %><br><%
                      out.print(data.get(1)); %><br><%
                      out.print(data.get(2)); %><br><%
                    } 
                    
                    %>


    <div id="map"></div>

    <script>
	    mapboxgl.accessToken = 'pk.eyJ1IjoiaXZhbm5tIiwiYSI6ImNscWM1ZHdwZzAxa3gyanBobGs4cDlndmQifQ.hOGfE1JWAq_vuiBHa5STxQ';
      const map = new mapboxgl.Map({
        container: 'map', // container ID
        style: 'mapbox://styles/mapbox/streets-v12', // style URL
        center: [2.298376597261021, 48.855868203242444], // starting position
        zoom: 13 // starting zoom
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
                  <%
                    for (int i = 0; i < coords.size(); i++) {
                      List<String> data = coords.get(i);
                  %>
                    {
                      'type': 'Feature',
                      'geometry': {
                        'type': 'Point',
                        'coordinates': [
                          <% out.print(Float.parseFloat(data.get(2))); %>, <% out.print(Float.parseFloat(data.get(1))); %>
                        ]
                      },
                      'properties': {
                        'title': "<% out.print(data.get(0)); %>"
                      }
                    },
                  <% } %>
                  {
                    // feature for Mapbox DC
                    'type': 'Feature',
                    'geometry': {
                      'type': 'Point',
                      'coordinates': [
                        2.298376597261021, 48.855868203242444
                      ]
                    },
                    'properties': {
                      'title': 'Vous êtes ici'
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