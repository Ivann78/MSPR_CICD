<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String url = "jdbc:mariadb://localhost:3306/films";
String user = "mysql";
String password = "mysql";

Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection(url, user, password);
%>

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
        if (request.getParameter("id") != null && request.getParameter("name") != null && !request.getParameter("name").equals("")) {
            out.println("True");
            try {
            PreparedStatement pstmt = conn.prepareStatement("UPDATE Film SET titre = ? WHERE id = ?;");
            pstmt.setString(1, request.getParameter("name"));
            pstmt.setString(2, request.getParameter("id"));
            int rowUpdate = pstmt.executeUpdate();
            out.println(rowUpdate + " row(s) updated.");
        } catch (SQLException e) {
            out.println("Error updating the database: " + e.getMessage());
            e.printStackTrace();
        }
        } else {
            out.println("False");
        }

        String annee = "2000";
        if (request.getParameter("annee") != null) {
            annee = request.getParameter("annee");
        }

        out.println(request.getParameter("name"));
        out.println(request.getParameter("id"));
    %>

    <p>Recherche par année</p>
    <form method="get">
        <input name="annee" type="text" value="<% out.println(annee); %>">
        <input type="submit">
    </form>
    <br>

    <p>Modifier un titre</p>
    <form name="edit_name" method="post">
        <input name="id" type="number" placeholder="id">
        <input name="name" type="text" placeholder="Nouveau nom">
        <input type="submit">
    </form>
    <br>

    <%
        PreparedStatement pstmt = conn.prepareStatement("SELECT idFilm, titre, année FROM Film WHERE année >= ? ORDER BY année ASC");
        pstmt.setString(1, annee);
        ResultSet rs = pstmt.executeQuery();

        out.println("<table><tr><th>ID</th><th>Titre</th><th>Année</th></tr>");

        while (rs.next()) {
            String colonne1 = rs.getString("idFilm");
            String colonne2 = rs.getString("titre");
            String colonne3 = rs.getString("année");

            out.println("<tr><td>" + colonne1 + "</td><td>" + colonne2 + "</td><td>" + colonne3 + "</td></tr>");
        }

        out.println("</table>");

        rs.close();
        pstmt.close();
        conn.close();
    %>
    <img src="https://cdn.discordapp.com/attachments/908889456818397267/1168852446634852452/1697550731048120.gif" alt="ryan">
</body>
</html>