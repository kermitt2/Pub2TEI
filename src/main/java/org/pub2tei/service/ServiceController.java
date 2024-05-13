package org.pub2tei.service;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.grobid.core.factory.AbstractEngineFactory;
import org.grobid.core.main.GrobidHomeFinder;
import org.grobid.core.utilities.GrobidProperties;
import org.pub2tei.document.XSLTProcessor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.InputStream;
import java.util.Arrays;


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

        // update Grobid consolidation settings using service config
        GrobidProperties.getInstance().setConsolidationService(serviceConfiguration.getConsolidationServiceString());
        GrobidProperties.getInstance().setGluttonUrl(serviceConfiguration.getGluttonUrl());
        GrobidProperties.getInstance().setCrossrefMailto(serviceConfiguration.getCrossrefMailto());
        GrobidProperties.getInstance().setCrossrefToken(serviceConfiguration.getCrossrefToken());
    }

    @Path(PATH_PUB2TEI)
    @Produces(MediaType.TEXT_PLAIN)
    @GET
    public Response rootPath() {
        return Response.status(Response.Status.OK).build();
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
    @Produces(MediaType.APPLICATION_XML + ";charset=utf-8")
    @POST
    public Response processText_post(
        @FormParam(TEXT) String text,
        @DefaultValue("0") @FormParam(SEGMENT) String segmentSentences,
        @DefaultValue("0") @FormParam(REFINE_GROBID) String refineGrobid,
        @DefaultValue("0") @FormParam(CONSOLIDATE_REFERENCES) int consolidateReferences
        ) {
        boolean segment = validateGenerateIdParam(segmentSentences);
        boolean refine = validateGenerateIdParam(refineGrobid);
        return ProcessString.processText(text, segment, refine, consolidateReferences, this.configuration);
    }

    @Path(PATH_TEXT)
    @Produces(MediaType.APPLICATION_XML + ";charset=utf-8")
    @GET
    public Response processText_get(
            @QueryParam(TEXT) String text,
            @DefaultValue("0") @QueryParam(SEGMENT) String segmentSentences,
            @DefaultValue("0") @QueryParam(REFINE_GROBID) String refineGrobid,
            @DefaultValue("0") @QueryParam(CONSOLIDATE_REFERENCES) int consolidateReferences) {
        boolean segment = validateGenerateIdParam(segmentSentences);
        boolean refine = validateGenerateIdParam(refineGrobid);
        return ProcessString.processText(text, segment, refine, consolidateReferences, this.configuration);
    }

    @Path(PATH_XML)
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces("application/xml" + ";charset=utf-8")
    @POST
    public Response processXML(
            @FormDataParam(INPUT) InputStream inputStream,
            @DefaultValue("0") @FormDataParam(SEGMENT) String segmentSentences,
            @DefaultValue("0") @FormDataParam(REFINE_GROBID) String refineGrobid, 
            @DefaultValue("0") @FormDataParam(CONSOLIDATE_REFERENCES) int consolidateReferences
        ) {
        boolean segment = validateGenerateIdParam(segmentSentences);
        boolean refine = validateGenerateIdParam(refineGrobid);
        return ProcessFile.processXML(inputStream, segment, refine, consolidateReferences, this.configuration);
    }

    private static boolean validateGenerateIdParam(String generateIDs) {
        boolean generate = false;
        if ((generateIDs != null) && (generateIDs.equals("1") || generateIDs.equals("true") || generateIDs.equals("True"))) {
            generate = true;
        }
        return generate;
    }

}
