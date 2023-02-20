<%@ page import="fr.iut2.gueguenajavaweb.data.Module" %>
<%@ page import="fr.iut2.gueguenajavaweb.data.Note" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<jsp:useBean id="etudiant" class="fr.iut2.gueguenajavaweb.data.Etudiant" scope="request"/>

<div class="card">
    <div class="card-body">
        <jsp:include page="commun/entetedepage.jsp"/>
        <jsp:include page="commun/menu.jsp"/>
        <h3>
            Fiche de <%=etudiant.getNomComplet()%>
        </h3>

        <table border="1">
            <tr>
                <td>Groupe</td>
                <td><%=etudiant.getGroupe().getNom()%>
                </td>
            </tr>
            <tr>
                <td>Moyenne Générale</td>
                <td><%=etudiant.getMoyenne()%>
                </td>
            </tr>
            <tr>
                <td>Absences</td>
                <td><%=etudiant.getNbAbsences()%>
                </td>
            </tr>
        </table>
        <br>
        <button onClick='location="<%= application.getContextPath()%>/do/modifetudiant?id=<%= etudiant.getId() %>&nbAbsence=1"'>
            Ajouter une absence
        </button>
        <button onClick='location="<%= application.getContextPath()%>/do/modifetudiant?id=<%= etudiant.getId() %>&nbAbsence=-1"'>
            Retirer une absence
        </button>
        <br>

        <br>

        <table border="1">
            <tbody>
            <tr>
                <th>Module</th>
                <th>Coef</th>
                <th>Note</th>
                <th></th>
            </tr>
            <% for (Module module : etudiant.getGroupe().getModules()) { %>
            <%
                Note note = module.findNoteByIdEtudiantAndIdModule(etudiant.getId(), module.getId());
            %>
            <tr>
                <td>
                    <%=module.getNom()%>
                </td>
                <td>
                    <%=module.getCoefficient()%>
                </td>
                <td>
                    <b><span><%=note != null ? note.getValeur() : ""%></span></b>
                </td>
                <td>
                    <form method="POST" action="<%= application.getContextPath()%>/do/modifetudiant">
                        <input type="hidden" name="id" value="<%=etudiant.getId()%>"/>
                        <% if (note != null) { %>
                        <input type="hidden" name="idNote" value="<%=note.getId()%>"/>
                        <% } else {%>
                        <input type="hidden" name="newNote" value="<%="true"%>"/>
                        <% } %>
                        <input id="note<%=module.getId()%>" type="number" name="note<%=module.getId()%>" step="0.01"
                               max=20 min=0
                               placeholder="Nombre entre 0 et 20"
                               required/>
                        <button type="submit">Modifier la note</button>
                    </form>
                </td>
            </tr>

            <% } %>
            </tbody>
        </table>
        <footer>
            <jsp:include page="commun/pieddepage.jsp"/>
        </footer>
    </div>
</div>
