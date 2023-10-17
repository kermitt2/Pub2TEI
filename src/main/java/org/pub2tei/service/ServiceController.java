package org.pub2tei.service;

import com.google.inject.Inject;
import com.google.inject.Singleton;

import org.glassfish.jersey.media.multipart.FormDataParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import java.io.InputStream;
import java.net.HttpURLConnection;

import java.util.Arrays;
import java.io.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory;

import org.apache.commons.lang3.StringUtils;

/**
 * RESTful service for Pub2TEI.
 *
 * @author Patrice
 */
@Singleton
@Path(Pub2TEIPaths.PATH_PUB2TEI)
public class ServiceController implements Pub2TEIPaths {

    private static final Logger LOGGER = LoggerFactory.getLogger(ServiceController.class);

    private static final String TEXT = "text";
    private static final String INPUT = "input";

    private static final String SENTENCE_SEGMENTATION = "sentence";

    private static final String REFINE_AUTHORS = "refine_authors";
    private static final String REFINE_AFFILIATIONS = "refine_affiliations";
    private static final String REFINE_REFERENCES = "refine_references";
    private static final String REFINE_FUNDERS = "refine_funders";
    
    private static final String CONSOLIDATE_REFERENCES = "consolidate_references";
    private static final String CONSOLIDATE_HEADER = "consolidate_header";
    private static final String CONSOLIDATE_FUNDERS = "consolidate_funders";

    private ServiceConfiguration configuration;

    @Inject
    public ServiceController(ServiceConfiguration serviceConfiguration) {
        this.configuration = serviceConfiguration;
    }

    /**
     * @see org.grobid.service.process.GrobidRestProcessGeneric#isAlive()
     */
    @Path(PATH_IS_ALIVE)
    @Produces(MediaType.TEXT_PLAIN)
    @GET
    public Response isAlive() {
        return Response.status(Response.Status.OK).entity(ProcessString.isAlive()).build();
    }

    @Path(PATH_TEXT)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    @POST
    public Response processText_post(@FormParam(TEXT) String text) {
        //LOGGER.debug(text); 
        return ProcessString.processText(text);
    }

    @Path(PATH_TEXT)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    @GET
    public Response processText_get(@QueryParam(TEXT) String text) {
        //LOGGER.info(text);
        return ProcessString.processText(text);
    }

    @Path(PATH_XML)
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces("application/json")
    @POST
    public Response processXML(@FormDataParam(INPUT) InputStream inputStream) {
        return ProcessFile.processXML(inputStream);
    }

}
