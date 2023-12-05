<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion à MySQL via JSP</title>
</head>
<body>
    <h1>Exemple de connexion à MySQL via JSP</h1>
    <% 
    String url = "jdbc:mysql://localhost:3306/films";
    String user = "root";
    String password = "root";

        // Charger le pilote JDBC
        Class.forName("com.mysql.jdbc.Driver");

        // Établir la connexion
        Connection conn = DriverManager.getConnection(url, user, password);

        // Exemple de requête SQL
        String sql = "SELECT idFilm, titre, année FROM Film WHERE année > 2000 ORDER BY année ASC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        
    <tr>
        <td></td>
        <td></td>
        <td></td>
    

        out.println("<table>");

        // Afficher les résultats (à adapter selon vos besoins)
        while (rs.next()) {
            String colonne1 = rs.getString("idFilm");
            String colonne2 = rs.getString("titre");
            String colonne3 = rs.getString("année");

            out.println("<tr><td>" + colonne1 + "</td><td>" + colonne2 + "</td><td>" + colonne3 + "</td></tr>");
        }

        out.println("</table>");

        // Fermer les ressources 
        rs.close();
        pstmt.close();
        conn.close();
    
    %>
</body>
</html>