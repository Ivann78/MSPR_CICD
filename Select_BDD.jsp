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
        String annee = "2000";

        if (request.getParameter("annee") != null) {
            annee = request.getParameter("annee");
        }
    %>

    <form method="get">
        <input name="annee" type="text" value="<% out.println(annee); %>">
        <input type="submit">
    </form>
    <br>

    <%
        String url = "jdbc:mariadb://localhost:3306/films";
        String user = "mysql";
        String password = "mysql";

        Class.forName("org.mariadb.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT idFilm, titre, année FROM Film WHERE année >= " + annee + " ORDER BY année ASC";
        out.println(sql);
        PreparedStatement pstmt = conn.prepareStatement(sql);
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