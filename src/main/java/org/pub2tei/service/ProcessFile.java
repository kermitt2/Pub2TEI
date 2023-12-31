package org.pub2tei.service;

import com.google.inject.Inject;
import com.google.inject.Singleton;

import org.apache.commons.lang3.StringUtils;

import org.pub2tei.document.DocumentProcessor;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.core.StreamingOutput;

/*import jakarta.ws.rs.core.HttpHeaders;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.Response.Status;*/

import java.io.*;
import java.nio.charset.Charset;
import java.util.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Patrice
 */
@Singleton
public class ProcessFile {

    /**
     * The class Logger.
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(ProcessFile.class);

    @Inject
    public ProcessFile() {
    }

    /**
     * Uploads the origin XML, process it and return the extracted software mention objects in JSON.
     *
     * @param inputStream the data of origin XML
     * @return a response object containing the converted/refined TEI XML
     */
    public static Response processXML(final InputStream inputStream, ServiceConfiguration serviceConfiguration) {
        LOGGER.debug(methodLogIn()); 
        Response response = null;
        try {
            DocumentProcessor documentProcessor = new DocumentProcessor(serviceConfiguration);
            String result = documentProcessor.processXML(inputStream);

            if (result == null | result.length() == 0) {
                response = Response.status(Response.Status.NO_CONTENT).build();
            } else {
                response = Response.status(Response.Status.OK)
                        .entity(result)
                        .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_XML + "; charset=UTF-8")
                        .build();
            }
            
        } catch(Exception exp) {
            LOGGER.error("An unexpected exception occurs. ", exp);
            response = Response.status(Status.INTERNAL_SERVER_ERROR).entity(exp.getMessage()).build();
        }

        LOGGER.debug(methodLogOut());
        return response;
    }


    /**
     * Check whether the result is null or empty.
     */
    public static boolean isResultOK(String result) {
        return StringUtils.isBlank(result) ? false : true;
    }

    public static String methodLogIn() {
        return ">> " + ProcessFile.class.getName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName();
    }

    public static String methodLogOut() {
        return "<< " + ProcessFile.class.getName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName();
    }
}