<%@page import="fr.iut2.gueguenajavaweb.data.Etudiant" %>
<%@ page import="fr.iut2.gueguenajavaweb.data.Module" %>
<%@ page import="fr.iut2.gueguenajavaweb.data.Note" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="modules" type="java.util.List<fr.iut2.gueguenajavaweb.data.Module>" scope="request"/>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <title><%= application.getInitParameter("title")%>
    </title>
</head>
<body>
<jsp:include page="commun/entetedepage.jsp"/>
<jsp:include page="commun/menu.jsp"/>

<h1>Affichages des Modules</h1>

<!-- tableau de module  -->
<table border 1>

    <tr>
        <th>Nom du Module</th>
        <th>Coef</th>
    </tr>


    <% if (!modules.isEmpty()) {%>
    <% for (Module module : modules) {%>
    <tr>
        <td>
            <%=module.getNom()%>
        </td>
        <td>
            <%=module.getCoefficient()%>
        </td>
    </tr>
    <% } %>
    <% } %>
</table>
<br>
<form action="<%= application.getContextPath()%>/do/gestionmodules" method="post">
    <input type="text" name="nomModule" placeholder="Nom du Module" required/>
    <input type="number" name="coef" placeholder="Coefficient" required/>
    <input type="submit" name="action" value="Ajouter un module"/>
</form>
</body>
<footer>
    <jsp:include page="commun/pieddepage.jsp"/>
</footer>
</html>
