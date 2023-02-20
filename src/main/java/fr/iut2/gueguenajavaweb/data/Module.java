package fr.iut2.gueguenajavaweb.data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Entity implementation class for Entity: Module
 */
@Entity
public class Module implements Serializable {

    @Id
    @GeneratedValue
    private Integer id;

    @Column(unique = true, nullable = false)
    private String nom;

    @Column(nullable = false)
    private int coefficient;

    @ManyToMany(fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
    private List<Groupe> groupes;

    @OneToMany(targetEntity = Note.class, mappedBy = "module", fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
    private List<Note> notes;

    private static final long serialVersionUID = 1L;

    public Module() {
        super();
    }

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNom() {
        return this.nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setCoefficient(int coefficient) {
        this.coefficient = coefficient;
    }

    public int getCoefficient() {
        return this.coefficient;
    }


    public List<Groupe> getGroupes() {
        return groupes;
    }

    public void addGroupe(Groupe groupe) {
        if (this.groupes.contains(groupe)) {
            return;
        }
        groupe.addModule(this);
        this.groupes.add(groupe);
        ModuleDAO.update(this);
    }

    public void removeGroupe(Groupe groupe) {
        this.groupes.remove(groupe);
    }

    public void setGroupes(List<Groupe> groupes) {
        this.groupes = groupes;
    }

    public List<Note> getNotes() {
        return notes;
    }

    //findNoteByIdEtudiantAndIdModule

    public void setNotes(List<Note> notes) {
        this.notes = notes;
    }

    public void addNote(Note note) {
        if (this.notes.contains(note)) {
            return;
        }
        note.setModule(this);
        this.notes.add(note);
        ModuleDAO.update(this);
    }

    public void removeNote(Note note) {
        this.notes.remove(note);
    }

    public Note findNoteByIdEtudiantAndIdModule(int idEtudiant, int idModule) {
        Note note = ModuleDAO.findNoteByIdEtudiantAndIdModule(idEtudiant, idModule);

        return note != null ? note : null;
    }

}
