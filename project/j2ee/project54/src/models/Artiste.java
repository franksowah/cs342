package models;

import sun.misc.Perf;

import javax.persistence.*;

/**
 * Created by efb4 on 5/13/2017.
 */
@Entity
public class Artiste {
    private long id;
    private String name;
    private String year;
    private String acttype;
    private String instrument;
    private String email;
    private Performances performance;

    @GeneratedValue(generator = "efb4Sequence")
    @SequenceGenerator(name = "efb4Sequence", sequenceName = "efb4_sequence", allocationSize = 1)
    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "YEAR")
    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    @Basic
    @Column(name = "ACTTYPE")
    public String getActtype() {
        return acttype;
    }

    public void setActtype(String acttype) {
        this.acttype = acttype;
    }

    @Basic
    @Column(name = "INSTRUMENT")
    public String getInstrument() {
        return instrument;
    }

    public void setInstrument(String instrument) {
        this.instrument = instrument;
    }

    @Basic
    @Column(name = "EMAIL")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @ManyToOne
    @JoinColumn(name = "PerformanceID", referencedColumnName = "ID")
    public Performances getPerformance() {
        return performance;
    }

    public void setPerformance(Performances performanceId) {
        this.performance = performanceId;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Artiste artiste = (Artiste) o;

        if (id != artiste.id) return false;
        if (name != null ? !name.equals(artiste.name) : artiste.name != null) return false;
        if (year != null ? !year.equals(artiste.year) : artiste.year != null) return false;
        if (acttype != null ? !acttype.equals(artiste.acttype) : artiste.acttype != null) return false;
        if (instrument != null ? !instrument.equals(artiste.instrument) : artiste.instrument != null) return false;
        if (email != null ? !email.equals(artiste.email) : artiste.email != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (year != null ? year.hashCode() : 0);
        result = 31 * result + (acttype != null ? acttype.hashCode() : 0);
        result = 31 * result + (instrument != null ? instrument.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        return result;
    }
}
