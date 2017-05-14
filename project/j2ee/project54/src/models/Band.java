package models;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * Created by efb4 on 5/13/2017.
 */
@Entity
public class Band {
    private long id;
    private String name;
    private Long noMembers;

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
    @Column(name = "NO_MEMBERS")
    public Long getNoMembers() {
        return noMembers;
    }

    public void setNoMembers(Long noMembers) {
        this.noMembers = noMembers;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Band band = (Band) o;

        if (id != band.id) return false;
        if (name != null ? !name.equals(band.name) : band.name != null) return false;
        if (noMembers != null ? !noMembers.equals(band.noMembers) : band.noMembers != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (noMembers != null ? noMembers.hashCode() : 0);
        return result;
    }
}
