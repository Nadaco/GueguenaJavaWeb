package fr.iut2.gueguenajavaweb.data;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

public class EtudiantDAO {

    private static int NB_ABSENCES_MAX = 8;

    public static Etudiant retrieveById(int id) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        //
        Etudiant etu = em.find(Etudiant.class, id);
        // etu est maintenant un objet de la classe Etudiant
        // ou NULL si l'étudiant n'existe pas

        // Close the entity manager
        em.close();

        return etu;
    }


    public static Etudiant create(String prenom, String nom, Groupe groupe) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        //
        em.getTransaction().begin();

        // create new etudiant
        Etudiant etudiant = new Etudiant();
        etudiant.setPrenom(prenom);
        etudiant.setNom(nom);
        etudiant.setGroupe(groupe);
        em.persist(etudiant);

        // Commit
        em.getTransaction().commit();

        // Close the entity manager
        em.close();

        return etudiant;
    }

    public static Etudiant update(Etudiant etudiant) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        //
        em.getTransaction().begin();

        // Attacher une entité persistante (etudiant) à l’EntityManager courant  pour réaliser la modification
        em.merge(etudiant);

        // Commit
        em.getTransaction().commit();

        // Close the entity manager
        em.close();

        return etudiant;
    }

    public static Etudiant addAbsences(int id, int absencesAAjouter) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        // Find
        Etudiant etudiant = em.find(Etudiant.class, id);

        //
        em.getTransaction().begin();

        //
        int absencesInitiales = etudiant.getNbAbsences();
        if (absencesInitiales + absencesAAjouter <= NB_ABSENCES_MAX) {


            etudiant.setNbAbsences(absencesInitiales + absencesAAjouter);

            // Commit
            em.getTransaction().commit();
        }
        // Close the entity manager
        em.close();

        return etudiant;
    }

    public static void addAbsences(Etudiant etudiant, int absences) {

        // Ajouter ou enlever une absence à l'étudiant
        int nbAbsences = etudiant.getNbAbsences();
        if ((nbAbsences + absences) >= 0) {
            nbAbsences = nbAbsences + absences;
        }
        etudiant.setNbAbsences(nbAbsences);

        // Mettre l'étudiant à jour
        EtudiantDAO.update(etudiant);

    }


    public static void remove(Etudiant etudiant) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        //
        em.getTransaction().begin();

        // L'étudiant passé en paramètre doit être associé à l'EM
        if (!em.contains(etudiant)) {
            etudiant = em.merge(etudiant);
        }

        // Remove
        em.remove(etudiant);

        // Commit
        em.getTransaction().commit();

        // Close the entity manager
        em.close();
    }

    public static void remove(int id) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        //
        em.getTransaction().begin();

        // Delete notes
        em.createQuery("DELETE FROM Note AS n WHERE n.etudiant.id = :id")
                .setParameter("id", id)
                .executeUpdate();

        // Remove
        em.createQuery("DELETE FROM Etudiant AS e WHERE e.id = :id")
                .setParameter("id", id)
                .executeUpdate();


        // Commit
        em.getTransaction().commit();

        // Close the entity manager
        em.close();
    }

    public static int removeAll() {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        //
        em.getTransaction().begin();

        // RemoveAll
        int deletedCount = em.createQuery("DELETE FROM Etudiant").executeUpdate();

        // Commit
        em.getTransaction().commit();

        // Close the entity manager
        em.close();

        return deletedCount;
    }

    // Retourne l'ensemble des etudiants
    public static List<Etudiant> getAll() {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        // Recherche 
        Query q = em.createQuery("SELECT e FROM Etudiant e");

        @SuppressWarnings("unchecked")
        List<Etudiant> listEtudiant = q.getResultList();

        return listEtudiant;
    }

    // Retourne l'ensemble des etudiants d'un groupe donné
    public static List<Etudiant> getAllByAbsences() {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        // Recherche 
        Query q = em.createQuery("SELECT e FROM Etudiant e WHERE e.nbAbsences > :nbAbsenceMAx")
                .setParameter("nbAbsenceMAx", NB_ABSENCES_MAX);

        @SuppressWarnings("unchecked")
        List<Etudiant> listEtudiant = q.getResultList();

        return listEtudiant;
    }

    public static List<Etudiant> getAllByIdGroupe(int idGroupe) {
        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        // Recherche
        Query q = em.createQuery("SELECT e FROM Etudiant e WHERE e.groupe.id = :idGroupe").setParameter("idGroupe", idGroupe);

        List<Etudiant> listEtudiant = q.getResultList();

        return listEtudiant;
    }

    public static int getNbEtudiant() {
        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        // Recherche
        Query q = em.createQuery("SELECT count(e) FROM Etudiant e");

        return Integer.parseInt(q.getSingleResult().toString());
    }

}
