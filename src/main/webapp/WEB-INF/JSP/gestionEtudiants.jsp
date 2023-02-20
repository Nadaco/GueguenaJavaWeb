<%@page import="fr.iut2.gueguenajavaweb.data.Etudiant" %>
<%@ page import="fr.iut2.gueguenajavaweb.data.Groupe" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="etudiants" type="java.util.List<fr.iut2.gueguenajavaweb.data.Etudiant>" scope="request"/>
<jsp:useBean id="groupes" type="java.util.List<fr.iut2.gueguenajavaweb.data.Groupe>" scope="request"/>
<jsp:useBean id="isListeComplete" type="java.lang.Boolean" scope="request"/>
<jsp:useBean id="nomGroupe" type="java.lang.String" scope="request"/>
<jsp:useBean id="idGroupe" type="java.lang.Integer" scope="request"/>


<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <title><%= application.getInitParameter("title")%>
    </title>
</head>
<body>
<jsp:include page="commun/entetedepage.jsp"/>
<jsp:include page="commun/menu.jsp"/>

<h1><%= isListeComplete ? "Tous les groupes" : nomGroupe != null ? "Groupe " + nomGroupe : null %>
</h1>

<!-- Lien vers les autres groupes-->
<% for (Groupe groupe : groupes) {%>
<% if (groupe.getNom() != nomGroupe || etudiants.get(0).getGroupe().getId() != groupe.getId() || isListeComplete == true) {%>
<a href="<%= application.getContextPath()%>/do/gestionetudiants?idGroupe=<%=groupe.getId()%>">
    <%=groupe.getNom()%>
</a> &nbsp;
<% } %>
<% } %>

<% if (isListeComplete == false) {%>
<a href="<%= application.getContextPath()%>/do/gestionetudiants">Tous les groupes</a>
<% }%>


<!-- tableau d'étudiants  -->
<% if (etudiants.size() != 0) {%>
<table border 1>

    <tr>
        <th>Prénom/nom de l'étudiant</th>
        <th>Son groupe</th>
    <tr
    <% for (Etudiant etudiant : etudiants) {%>
    <tr>
        <td>
            <a href="<%= application.getContextPath()%>/do/ficheetudiant?id=<%=etudiant.getId()%>">
                <%=etudiant.getPrenom()%> <%=etudiant.getNom()%>
            </a>
        </td>
        <td>
            <%=etudiant.getGroupe().getNom()%>
        </td>
        <td>
            <form action="<%= application.getContextPath()%>/do/gestionetudiants" method="post">
                <input type="hidden" name="idEtudiant" value="<%=etudiant.getId()%>"/>
                <input type="hidden" name="delete" value="true"/>
                <input type="hidden" name="idGroupe"
                       value="<%=idGroupe != -1 ? idGroupe : etudiants.get(0).getGroupe().getId()%>"/>
                <input type="submit" name="action" value="Supprimer"/>
            </form>
        </td>
    </tr>
    <% } %>

</table>
<% } %>
<br>
<form action="<%= application.getContextPath()%>/do/gestionetudiants" method="post">
    <input type="text" name="prenom" placeholder="Prénom" required/>
    <input type="text" name="nom" placeholder="Nom" required/>
    <% if (isListeComplete) {%>
    <select name="idGroupe" require>
        <% for (Groupe groupe : groupes) {%>
        <option value="<%=groupe.getId()%>">
            <%=groupe.getNom()%>
        </option>
        <% } %>
    </select>
    <% } else {%>
    <input type="hidden" name="idGroupe" value="<%=idGroupe != -1 ? idGroupe : etudiants.get(0).getGroupe().getId()%>"/>
    <input type="text" name="nomGroupe" readonly
           value="<%=nomGroupe != "" ? nomGroupe : etudiants.get(0).getGroupe().getNom()%>"/>
    <% } %>
    <input type="submit" name="action" value="Ajouter un étudiant"/>
</form>
</body>
<footer>
    <jsp:include page="commun/pieddepage.jsp"/>
</footer>
</html>
