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
        if (request.getParameter("edit_id") != null && request.getParameter("edit_name") != null && !request.getParameter("edit_name").equals("")) {
            try {
                PreparedStatement pstmt = conn.prepareStatement("UPDATE Film SET titre = ? WHERE idFilm = ?;");
                pstmt.setString(1, request.getParameter("edit_name"));
                pstmt.setString(2, request.getParameter("edit_id"));
                int rowUpdate = pstmt.executeUpdate();
            } catch (SQLException e) {
                out.println("Error: " + e.getMessage());
                e.printStackTrace();
            }
        }

        if (request.getParameter("add_name") != null && !request.getParameter("add_name").equals("") && request.getParameter("add_annee") != null && !request.getParameter("add_annee").equals("")) {
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT max(idFilm) AS maxId FROM Film");
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    String maxId = rs.getString("maxId");
                }

                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO Film (idFilm, titre, année) VALUES (?, ?, ?);");
                pstmt.setString(1, maxId+1);
                pstmt.setString(2, request.getParameter("add_name"));
                pstmt.setString(3, request.getParameter("add_annee"));
                ResultSet rowInsert = pstmt.executeQuery();
            } catch (SQLException e) {
                out.println("Error: " + e.getMessage());
                e.printStackTrace();
            }
        }

        String annee = "2000";
        if (request.getParameter("annee") != null) {
            annee = request.getParameter("annee");
        }
    %>

    Recherche par année:
    <form method="get">
        <input name="annee" type="text" value="<% out.println(annee); %>">
        <input type="submit">
    </form>
    <br>

    Modifier un titre:
    <form name="edit_name" method="post">
        <input name="edit_id" type="number" placeholder="id">
        <input name="edit_name" type="text" placeholder="Nouveau nom">
        <input type="submit">
    </form>
    <br>

    Ajouter un titre:
    <form name="add_title" method="post">
        <input name="add_name" type="text" placeholder="Nom">
        <input name="add_annee" type="text" placeholder="Année">
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