package fr.iut2.gueguenajavaweb.data;


import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

public class NoteDAO {

    public static Note create(Etudiant etudiant, float valeur, Module module) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        // create
        em.getTransaction().begin();

        // create new note
        Note note = new Note();
        note.setEtudiant(etudiant);
        note.setValeur(valeur);
        note.setModule(module);
        em.persist(note);

        // Commit
        em.getTransaction().commit();

        // Close the entity manager
        em.close();

        return note;
    }

    public static void remove(Note note) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        //
        em.getTransaction().begin();

        // La note passé en paramètre doit être associé à l'EM
        if (!em.contains(note)) {
            note = em.merge(note);
        }

        // Supprime l'entité courante mais aussi les entités (module et étudiant) liées
        // grâce à l'annotation cascade = {CascadeType.REMOVE}
        em.remove(note);

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
        int deletedCount = em.createQuery("DELETE FROM Note").executeUpdate();

        // Commit
        em.getTransaction().commit();

        // Close the entity manager
        em.close();

        return deletedCount;
    }


    public static List<Note> getAll() {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        // Recherche 
        Query q = em.createQuery("SELECT n FROM Note n");

        @SuppressWarnings("unchecked")
        List<Note> listeNote = q.getResultList();

        return listeNote;
    }

    public static Note update(Note note) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        //
        em.getTransaction().begin();

        // Attacher une entité persistante (note) à l’EntityManager courant  pour réaliser la modification
        em.merge(note);

        // Commit
        em.getTransaction().commit();

        // Close the entity manager
        em.close();

        return note;
    }

    //findNoteById
    public static Note findNoteById(int id) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        // Recherche
        Query q = em.createQuery("SELECT n FROM Note n WHERE n.id = :id");
        q.setParameter("id", id);

        @SuppressWarnings("unchecked")
        List<Note> listeNote = q.getResultList();

        if (listeNote.size() == 0) {
            return null;
        } else {
            return listeNote.get(0);
        }
    }
}
