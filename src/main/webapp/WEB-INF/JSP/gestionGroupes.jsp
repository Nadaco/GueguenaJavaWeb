<%@page import="fr.iut2.gueguenajavaweb.data.Etudiant" %>
<%@ page import="fr.iut2.gueguenajavaweb.data.Groupe" %>
<%@ page import="fr.iut2.gueguenajavaweb.data.Module" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="groupes" type="java.util.List<fr.iut2.gueguenajavaweb.data.Groupe>" scope="request"/>
<jsp:useBean id="nbTotalEtudiant" type="java.lang.Integer" scope="request"/>
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

<h1>Affichages des Groupes</h1>

<!-- tableau de groupe  -->
<table border 1>

    <tr>
        <th>Nom du groupe</th>
        <th>Nombre d'étudiants</th>
        <th>Ajouter Modules</th>
    </tr>

    <% for (Groupe groupe : groupes) {%>
    <tr>
        <td>
            <%=groupe.getNom()%>
        </td>
        <td><%=groupe.getEtudiants().size()%>
        </td>
        <td>
            <% if (groupe.getModules().size() != modules.size()) {%>
            <form action="<%= application.getContextPath()%>/do/gestiongroupes" method="post">
                <select name="idModule" require>
                    <% for (Module module : modules) {%>
                    <% if (groupe.getModuleById(module.getId()) == null) {%>
                    </h1>
                    <option value="<%=module.getId()%>">
                        <%=module.getNom()%>
                    </option>
                    <% } %>
                    <% } %>

                </select>
                <input type="hidden" name="idGroupe" value="<%=groupe.getId()%>"/>
                <input type="submit" name="action" value="Ajouter"/>
            </form>
            <% } %>
        </td>

    </tr>
    <% } %>
    <tr>
        <td>
            Tous les groupes
        </td>
        <td>
            <%=nbTotalEtudiant%>
        </td>
        <td></td>
    </tr>
</table>
<br>
<form action="<%= application.getContextPath()%>/do/gestiongroupes" method="post">
    <input type="text" name="nomGroupe" placeholder="Nom du groupe" required/>
    <input type="submit" name="action" value="Ajouter un groupe"/>
</form>
</body>
<footer>
    <jsp:include page="commun/pieddepage.jsp"/>
</footer>
</html>
