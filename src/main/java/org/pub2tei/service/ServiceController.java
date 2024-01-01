package org.pub2tei.service;

import com.google.inject.Inject;
import com.google.inject.Singleton;

import org.pub2tei.document.XSLTProcessor;

import org.grobid.core.utilities.GrobidProperties;
import org.grobid.core.main.GrobidHomeFinder;
import org.grobid.core.factory.AbstractEngineFactory;

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

    private static final String SEGMENT = "segmentSentences";

    private static final String REFINE_GROBID = "grobidRefine";
    private static final String REFINE_AUTHORS = "authorRefine";
    private static final String REFINE_AFFILIATIONS = "affiliationRefine";
    private static final String REFINE_REFERENCES = "referenceRefine";
    private static final String REFINE_FUNDERS = "funderRefine";
    
    private static final String CONSOLIDATE_REFERENCES = "consolidateReferences";
    private static final String CONSOLIDATE_HEADER = "consolidateHeader";
    private static final String CONSOLIDATE_FUNDERS = "consolidateFunders";

    private ServiceConfiguration configuration;

    @Inject
    public ServiceController(ServiceConfiguration serviceConfiguration) {
        this.configuration = serviceConfiguration;
        // compile stylesheets at start
        XSLTProcessor.getInstance(this.configuration);
        String grobidHomePath = this.configuration.getGrobidHome();
        final GrobidHomeFinder grobidHomeFinder = new GrobidHomeFinder(Arrays.asList(grobidHomePath));
        grobidHomeFinder.findGrobidHomeOrFail();
        GrobidProperties.getInstance(grobidHomeFinder);
        GrobidProperties.setContextExecutionServer(true);
        AbstractEngineFactory.init();

        /*Engine engine = null;
        try {
            // this will init or not all the models in memory
            engine = Engine.getEngine(true);
        } catch (NoSuchElementException nseExp) {
            LOGGER.error("Could not get an engine from the pool within configured time.");
        } catch (Exception exp) {
            LOGGER.error("An unexpected exception occurs when initiating the grobid engine. ", exp);
        } finally {
            if (engine != null) {
                GrobidPoolingFactory.returnEngine(engine);
            }
        }*/
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
    public Response processText_post(
        @FormParam(TEXT) String text,
        @FormParam(SEGMENT) String segmentSentences,
        @FormParam(REFINE_GROBID) String refineGrobid) {
        boolean segment = validateGenerateIdParam(segmentSentences);
        boolean refine = validateGenerateIdParam(refineGrobid);
        return ProcessString.processText(text, segment, refine, this.configuration);
    }

    @Path(PATH_TEXT)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    @GET
    public Response processText_get(
            @QueryParam(TEXT) String text,
            @QueryParam(SEGMENT) String segmentSentences,
            @QueryParam(REFINE_GROBID) String refineGrobid) {
        boolean segment = validateGenerateIdParam(segmentSentences);
        boolean refine = validateGenerateIdParam(refineGrobid);
        return ProcessString.processText(text, segment, refine, this.configuration);
    }

    @Path(PATH_XML)
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces("application/json")
    @POST
    public Response processXML(
            @FormDataParam(INPUT) InputStream inputStream,
            @FormDataParam(SEGMENT) String segmentSentences,
            @FormDataParam(REFINE_GROBID) String refineGrobid) {
        boolean segment = validateGenerateIdParam(segmentSentences);
        boolean refine = validateGenerateIdParam(refineGrobid);
        return ProcessFile.processXML(inputStream, segment, refine, this.configuration);
    }

    private static boolean validateGenerateIdParam(String generateIDs) {
        boolean generate = false;
        if ((generateIDs != null) && (generateIDs.equals("1") || generateIDs.equals("true") || generateIDs.equals("True"))) {
            generate = true;
        }
        return generate;
    }

}
