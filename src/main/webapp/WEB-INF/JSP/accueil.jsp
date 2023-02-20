<%@ page import="fr.iut2.gueguenajavaweb.data.Groupe" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="groupes" type="java.util.List<fr.iut2.gueguenajavaweb.data.Groupe>" scope="request"/>
<jsp:useBean id="nbTotalEtudiant" type="java.lang.Integer" scope="request"/>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <title>Accueil</title>
</head>
<body>
<jsp:include page="commun/entetedepage.jsp"/>
<jsp:include page="commun/menu.jsp"/>
<!-- tableau de groupes  -->
<h1>Affichages des Groupes</h1>
<table>
    <thead>
    <tr>
        <th>Nom du groupe</th>
        <th>Nombre d'étudiants</th>
    </tr>
    </thead>
    <tbody>
    <% for (Groupe groupe : groupes) {%>
    <tr>
        <td>
            <%=groupe.getNom()%>

        </td>
        <td><%=groupe.getEtudiants().size()%>
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
    </tr>
    </tbody>
</table>
</body>
<footer>
    <jsp:include page="commun/pieddepage.jsp"/>
</footer>
</html>
