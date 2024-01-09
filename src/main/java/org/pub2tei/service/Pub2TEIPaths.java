package org.pub2tei.service;

/**
 * This interface only contains the path extensions for accessing the Pub2TEI service.
 *
 * @author Patrice
 *
 */
public interface Pub2TEIPaths {
    /**
     * path extension for Pub2TEI service
     */
    public static final String PATH_PUB2TEI = "/";
    
    /**
     * path extension for is alive request.
     */
    String PATH_IS_ALIVE = "isalive";

    /**
     * path extension for procssing an XML text
     */
    public static final String PATH_TEXT = "processText";

    /**
     * path extension for processing an XML file
     */
    public static final String PATH_XML = "processXML";

}