<%@page import="fr.iut2.gueguenajavaweb.data.Etudiant" %>
<%@ page import="fr.iut2.gueguenajavaweb.data.Groupe" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="etudiants" type="java.util.List<fr.iut2.gueguenajavaweb.data.Etudiant>" scope="request"/>
<jsp:useBean id="groupes" type="java.util.List<fr.iut2.gueguenajavaweb.data.Groupe>" scope="request"/>
<jsp:useBean id="isListeComplete" type="java.lang.Boolean" scope="request"/>

<html>
<head>
    <title><%= application.getInitParameter("title")%>
    </title>
</head>
<body>
<jsp:include page="commun/entetedepage.jsp"/>
<jsp:include page="commun/menu.jsp"/>

<h1><%= isListeComplete ? "Les notes de tous les groupes" : "Notes des " + etudiants.get(0).getGroupe().getNom() %>
</h1>

<!-- Lien vers les autres groupes-->
<% for (Groupe groupe : groupes) {%>
<% if (etudiants.get(0).getGroupe().getId() != groupe.getId() || isListeComplete == true) {%>
<a href="<%= application.getContextPath()%>/do/editionnotesetudiants?idGroupe=<%=groupe.getId()%>">
    <%=groupe.getNom()%>
</a> &nbsp;
<% } %>
<% } %>

<% if (isListeComplete == false) {%>
<a href="<%= application.getContextPath()%>/do/editionnotesetudiants">Tous les groupes</a>
<% }%>


<table border="1">
    <tr>
        <th>Etudiant</th>
        <th>Groupe</th>
        <th>Absences</th>
    </tr>
    <% for (Etudiant etudiant : etudiants) {%>
    <tr>

        <td>
            <a href="<%= application.getContextPath()%>/do/ficheetudiant?id=<%=etudiant.getId()%>">
                <%=etudiant.getNomComplet()%>
            </a>
        </td>
        <td>
            <%=etudiant.getGroupe().getNom()%>
        </td>
        <td>
            <input type="text" name="absence" value="<%=etudiant.getNbAbsences()%>"/>
        </td>
    </tr>
    <% } %>
</table>
<button
        onClick='location="<%= application.getContextPath()%>/do/editionabsencesetudiants"'>Modifier les absences
</button>
</body>
<footer>
    <jsp:include page="commun/pieddepage.jsp"/>
</footer>
</html>
