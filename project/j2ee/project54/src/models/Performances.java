package models;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Time;

/**
 * Created by efb4 on 5/13/2017.
 */
@Entity
public class Performances {
    private long id;
    private String venue;
    private Time pdate;
    private String comments;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "VENUE")
    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    @Basic
    @Column(name = "PDATE")
    public Time getPdate() {
        return pdate;
    }

    public void setPdate(Time pdate) {
        this.pdate = pdate;
    }

    @Basic
    @Column(name = "COMMENTS")
    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Performances that = (Performances) o;

        if (id != that.id) return false;
        if (venue != null ? !venue.equals(that.venue) : that.venue != null) return false;
        if (pdate != null ? !pdate.equals(that.pdate) : that.pdate != null) return false;
        if (comments != null ? !comments.equals(that.comments) : that.comments != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (venue != null ? venue.hashCode() : 0);
        result = 31 * result + (pdate != null ? pdate.hashCode() : 0);
        result = 31 * result + (comments != null ? comments.hashCode() : 0);
        return result;
    }
}
