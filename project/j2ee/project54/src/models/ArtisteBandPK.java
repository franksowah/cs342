package models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by efb4 on 4/28/2017.
 */


public class ArtisteBandPK implements Serializable {
    private Long artisteId;
    private Long bandId;

    @Column(name = "ARTISTENID")
    @Id
    public long getArtisteid() {
        return artisteId;
    }

    public void setArtisteid(long artisteid) {
        this.artisteId = artisteid;
    }

    @Column(name = "BANDID")
    @Id
    public long getBandid() {
        return bandId;
    }

    public void setBandId(long bandId) {
        this.bandId = bandId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ArtisteBandPK that = (ArtisteBandPK) o;

        if (artisteId != null ? !artisteId.equals(that.artisteId) : that.artisteId != null) return false;
        if (bandId != null ? !bandId.equals(that.bandId) : that.bandId != null) return false;

        return true;
    }
    @Override
    public int hashCode() {
        int result = artisteId != null ? artisteId.hashCode() : 0;
        result = 31 * result + (bandId != null ? bandId.hashCode() : 0);
        return result;
    }
}