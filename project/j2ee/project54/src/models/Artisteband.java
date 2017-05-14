package models;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * Created by efb4 on 5/13/2017.
 */
@Entity
public class Artisteband {
    private Long artisteid;
    private Long bandid;

    @Id
    @Column(name = "ARTISTEID")
    public Long getArtisteid() {
        return artisteid;
    }

    public void setArtisteid(Long artisteid) {
        this.artisteid = artisteid;
    }

    @Id
    @Column(name = "BANDID")
    public Long getBandid() {
        return bandid;
    }

    public void setBandid(Long bandid) {
        this.bandid = bandid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Artisteband that = (Artisteband) o;

        if (artisteid != null ? !artisteid.equals(that.artisteid) : that.artisteid != null) return false;
        if (bandid != null ? !bandid.equals(that.bandid) : that.bandid != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = artisteid != null ? artisteid.hashCode() : 0;
        result = 31 * result + (bandid != null ? bandid.hashCode() : 0);
        return result;
    }
}
