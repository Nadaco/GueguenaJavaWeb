package fr.iut2.gueguenajavaweb.data;


import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

public class ModuleDAO {

    public static Module create(String nom, int coefficient) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        // create
        em.getTransaction().begin();

        // create new module
        Module module = new Module();
        module.setNom(nom);
        module.setCoefficient(coefficient);
        em.persist(module);

        // Commit
        em.getTransaction().commit();

        // Close the entity manager
        em.close();

        return module;
    }

    public static Note findNoteByIdEtudiantAndIdModule(int idEtudiant, int idModule) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();


        try {
            Note note = em.createQuery("SELECT n FROM Note n WHERE n.etudiant.id = :idEtudiant AND n.module.id = :idModule", Note.class)
                    .setParameter("idEtudiant", idEtudiant)
                    .setParameter("idModule", idModule)
                    .getSingleResult();

            // Close the entity manager
            em.close();
            return note;
        } catch (Exception e) {
            // Close the entity manager
            em.close();
            return null;
        }


    }


    public static void remove(Module module) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        //
        em.getTransaction().begin();

        // Le module passé en paramètre doit être associé à l'EM
        if (!em.contains(module)) {
            module = em.merge(module);
        }

        // Supprime l'entité courante mais aussi les entités (groupe et note) liées
        // grâce à l'annotation cascade = {CascadeType.REMOVE}
        em.remove(module);

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
        int deletedCount = em.createQuery("DELETE FROM Module").executeUpdate();

        // Commit
        em.getTransaction().commit();

        // Close the entity manager
        em.close();

        return deletedCount;
    }


    public static List<Module> getAll() {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        // Recherche 
        Query q = em.createQuery("SELECT m FROM Module m");

        @SuppressWarnings("unchecked")
        List<Module> listModules = q.getResultList();

        return listModules;
    }

    public static Module update(Module module) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        //
        em.getTransaction().begin();

        // Attacher une entité persistante (module) à l’EntityManager courant  pour réaliser la modification
        em.merge(module);

        // Commit
        em.getTransaction().commit();

        // Close the entity manager
        em.close();

        return module;
    }

    public static Module getById(int id) {

        // Creation de l'entity manager
        EntityManager em = GestionFactory.factory.createEntityManager();

        // Recherche
        Query q = em.createQuery("SELECT m FROM Module m WHERE m.id = :id");
        q.setParameter("id", id);

        Module module = (Module) q.getSingleResult();

        // Close the entity manager
        em.close();

        return module;
    }
}
