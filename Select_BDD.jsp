<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion à MySQL via JSP</title>
</head>

<style>
    td {
        padding-left: 0.5rem;
        padding-right: 0.5rem;
    }
</style>

<body>
    <h1>Exemple de connexion à MySQL via JSP</h1>

    <%
        // if (request.getParameter("annee") != null) {
        //     String annee = request.getParameter("annee");
        // } else {
        //     String annee = "";
        // }
    %>

    <%-- <form action="" method="get">
        <input name="annee" type="text" value="<% out.println(annee); %>">
        <input type="submit">
    </form> --%>
    <br>

    <%
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mariadb://localhost:8080/films?user=root&password=root");

            statement = connection.createStatement();
            String sql = "SELECT idFilm, titre, année FROM Film WHERE année >= 2000 ORDER BY année ASC";
            rs = statement.executeQuery(sql);

            out.println("<table><tr><th>ID</th><th>Titre</th><th>Année</th></tr>");

            // Afficher les résultats (à adapter selon vos besoins)
            while (rs.next()) {
                out.println("rs");
                String colonne1 = rs.getString("idFilm");
                String colonne2 = rs.getString("titre");
                String colonne3 = rs.getString("année");

                out.println("<tr><td>" + colonne1 + "</td><td>" + colonne2 + "</td><td>" + colonne3 + "</td></tr>");
            }

            out.println("</table>");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
    <img src="https://cdn.discordapp.com/attachments/908889456818397267/1168852446634852452/1697550731048120.gif" alt="ryan">
</body>
</html>