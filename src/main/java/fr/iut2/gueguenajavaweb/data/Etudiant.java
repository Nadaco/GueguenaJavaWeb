package fr.iut2.gueguenajavaweb.data;

import javax.persistence.*;
import java.io.Serializable;
import java.text.DecimalFormat;
import java.util.List;

/**
 * Entity implementation class for Entity: Etudiant
 */
@Entity
public class Etudiant implements Serializable {

    @Id
    @GeneratedValue
    private Integer id;

    @Column(nullable = false)
    private String prenom;

    @Column(nullable = false)
    private String nom;

    private int nbAbsences;
    
    @ManyToOne
    private Groupe groupe;

    private static final long serialVersionUID = 1L;

    public Etudiant() {
        super();
        nbAbsences = 0;
    }

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPrenom() {
        return this.prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getNom() {
        return this.nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Groupe getGroupe() {
        return this.groupe;
    }

    public void setGroupe(Groupe groupe) {
        this.groupe = groupe;
        if (!groupe.getEtudiants().contains(this)) {
            groupe.getEtudiants().add(this);
        }
    }

    public int getNbAbsences() {
        return nbAbsences;
    }

    public void setNbAbsences(int nbAbsences) {
        this.nbAbsences = nbAbsences;
    }

    public float getMoyenne() {
        float moyenne = 0;
        int count = 0;
        int coefTotal = 0;
        for (Module module : this.getGroupe().getModules()) {
            for (Note note : module.getNotes()) {
                if (note.getEtudiant().equals(this)) {
                    moyenne += note.getValeur() * module.getCoefficient();
                    count++;
                    coefTotal += module.getCoefficient();
                }
            }
        }
        if (count == 0) {
            return 0;
        }
        return Math.round(moyenne / coefTotal * 100) / 100f;
    }


    public String getNomComplet() {
        return this.prenom + " " + this.nom;
    }

    @Override
    public String toString() {
        return "[" + this.getId() + "] " + this.getNomComplet();
    }


}
