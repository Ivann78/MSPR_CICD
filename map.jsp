<script src='https://api.mapbox.com/mapbox-gl-js/v2.9.1/mapbox-gl.js'></script>
<link href='https://api.mapbox.com/mapbox-gl-js/v2.9.1/mapbox-gl.css' rel='stylesheet' />


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Carte</title>
</head>
<body>

<div id='map' style='width: screen.width; height: screen.height;'></div>
<script>
  mapboxgl.accessToken = 'pk.eyJ1IjoiaXZhbm5tIiwiYSI6ImNscWM1ZHdwZzAxa3gyanBobGs4cDlndmQifQ.hOGfE1JWAq_vuiBHa5STxQ';
  var map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v11'
  });
</script>












    <% 
//     String url = "jdbc:mariadb://localhost:3306/equipements";
//     String user = "mysql";
//     String password = "mysql";

//         // Charger le pilote JDBC
//         Class.forName("org.mariadb.jdbc.Driver");

//         // Établir la connexion
// Connection conn = DriverManager.getConnection(url, user, password);
//             // Exemple de requête SQL
//         String sql = "SELECT equi_id, equi_libelle, equi_lat, equi_long, get_distance_metres('48.858205', '2.294359', equi_lat, equi_long) AS proximite FROM equipement HAVING proximite < 1000 ORDER BY proximite ASC LIMIT 10;";
//         PreparedStatement pstmt = conn.prepareStatement(sql);
//         ResultSet rs = pstmt.executeQuery();

//         // Afficher les résultats (à adapter selon vos besoins)
//         while (rs.next()) {
//             String colonne1 = rs.getString("equi_libelle");
//             String colonne2 = rs.getString("equi_lat");
//             String colonne3 = rs.getString("equi_long");
//             // Faites ce que vous voulez avec les données...
//             //Exemple d'affichage de 2 colonnes
//             out.println("Batiment : " + colonne1 + ", latitude : " + colonne2 + ", Longitude : " + colonne3 + "</br>");
//         }

//         // Fermer les ressources 
//         rs.close();
//         pstmt.close();
//         conn.close();
    %>
</body>
</html>