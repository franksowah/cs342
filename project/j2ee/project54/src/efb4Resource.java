import models.Artiste;
import models.Performances;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */
@Stateless
@Path("efb4")
public class efb4Resource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * GET a default message.
     *
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual Artiste record.
     *
     * @param id the ID of the Artiste to retrieve
     * @return a Artiste record
     */
    @GET
    @Path("artiste/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Artiste getArtiste(@PathParam("id") long id) {
        return em.find(Artiste.class, id);
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all Artiste records
     */
    @GET
    @Path("artistes")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Artiste> getArtistes() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Artiste.class)).getResultList();
    }

    //Homework 12
    /**
     * PUT the given Artiste entity, it it exists, using the values in the JSON-formatted Artiste entity passed with the request.
     */
    @PUT
    @Path("artiste/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response putArtiste(Artiste updateArtiste, @PathParam("id") long id){
        Artiste p = em.find(Artiste.class, id);
        if(updateArtiste.getId() != id || p == null){
            return Response.serverError().entity("Invalid ID").build();
        }
        updateArtiste.setPerformance(em.find(Performances.class, updateArtiste.getPerformance().getId()));
        em.merge(updateArtiste);
        return Response.ok(em.find(Artiste.class,id), MediaType.APPLICATION_JSON).build();
    }

    /**
     * POST a new Artiste
     */
    @POST
    @Path("artistes")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Artiste postArtiste(Artiste newArtiste){
        Artiste p = new Artiste ();
        newArtiste.setId(p.getId());
        newArtiste.setPerformance(em.find(Performances.class, newArtiste.getPerformance().getId()));
        em.persist(newArtiste);
        return newArtiste;
    }

    /**
     * DELETE the Artiste with the given ID, if it exists
     *
     */
    @DELETE
    @Path("artiste/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public String deleteArtiste(@PathParam("id") long id) {
        Artiste p = em.find(Artiste.class, id);
        if(p == null){
            return "ID: " + id + " does not exist";
        }
        else {
            em.remove(p);
        }
        return "Deleted Artiste with ID: " + id;
    }

}
