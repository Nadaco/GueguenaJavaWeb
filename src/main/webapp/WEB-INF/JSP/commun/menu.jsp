<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<div>
    <a href="<%= application.getContextPath()%>/do/accueil">Accueil</a>
    <a href="<%= application.getContextPath()%>/do/notesetudiants">Consulter les notes</a>
    <a href="<%= application.getContextPath()%>/do/absencesetudiants">Consulter les absences</a>
    <%--<a href="<%= application.getContextPath()%>/do/editionnotesetudiants">Editer les notes</a>
    <a href="<%= application.getContextPath()%>/do/editionabsencesetudiants">Editer les absences</a>--%>
    <a href="<%= application.getContextPath()%>/do/gestionetudiants">Gestion des étudiants</a>
    <a href="<%= application.getContextPath()%>/do/gestiongroupes">Gestion des groupes</a>
    <a href="<%= application.getContextPath()%>/do/gestionmodules">Gestion des modules</a>
</div>
