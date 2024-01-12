package org.pub2tei.service;

import io.dropwizard.Configuration;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.util.List;

import org.grobid.core.utilities.GrobidConfig;
import org.grobid.core.utilities.GrobidConfig.ConsolidationParameters;
import org.grobid.core.utilities.Consolidation.GrobidConsolidationService;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ServiceConfiguration extends Configuration {

    private String grobidHome;
    private String tmpPath;
    private String stylesheetsPath;
    private int maxParallelRequests;

    @JsonProperty
    private String corsAllowedOrigins = "*";
    @JsonProperty
    private String corsAllowedMethods = "OPTIONS,GET,PUT,POST,DELETE,HEAD";
    @JsonProperty
    private String corsAllowedHeaders = "X-Requested-With,Content-Type,Accept,Origin";

    public ConsolidationParameters consolidation;

    public String getGrobidHome() {
        return grobidHome;
    }

    public void setGrobidHome(String grobidHome) {
        this.grobidHome = grobidHome;
    }

    public String getTmpPath() {
        return tmpPath;
    }

    public void setTmpPath(String tmpPath) {
        this.tmpPath = tmpPath;
    }

    public String getStylesheetsPath() {
        return this.stylesheetsPath;
    }

    public void setStylesheetsPath(String stylesheetsPath) {
        this.stylesheetsPath = stylesheetsPath;
    }

    public int getMaxParallelRequests() {
        if (this.maxParallelRequests == 0) {
            this.maxParallelRequests = Runtime.getRuntime().availableProcessors();
        }
        return this.maxParallelRequests;
    }

    public String getCorsAllowedOrigins() {
        return corsAllowedOrigins;
    }

    public void setCorsAllowedOrigins(String corsAllowedOrigins) {
        this.corsAllowedOrigins = corsAllowedOrigins;
    }

    public String getCorsAllowedMethods() {
        return corsAllowedMethods;
    }

    public void setCorsAllowedMethods(String corsAllowedMethods) {
        this.corsAllowedMethods = corsAllowedMethods;
    }

    public String getCorsAllowedHeaders() {
        return corsAllowedHeaders;
    }

    public void setCorsAllowedHeaders(String corsAllowedHeaders) {
        this.corsAllowedHeaders = corsAllowedHeaders;
    }

    public GrobidConsolidationService getConsolidationService() {
        if (consolidation.service == null)
            consolidation.service = "crossref";
        return GrobidConsolidationService.get(consolidation.service);
    }

    /**
     * Set which consolidation service to use
     */
    public void setConsolidationService(String service) {
        consolidation.service = service;
    }

    /**
     * Set the "mailto" parameter to be used in the crossref query and in User-Agent
     * header, as recommended by CrossRef REST API documentation.
     *
     * @param mailto email parameter to be used for requesting crossref
     */
    public void setCrossrefMailto(final String mailto) {
        consolidation.crossref.mailto = mailto;
    }

    /**
     * Get the "mailto" parameter to be used in the crossref query and in User-Agent
     * header, as recommended by CrossRef REST API documentation.
     *
     * @return string of the email parameter to be used for requesting crossref
     */
    public String getCrossrefMailto() {
        if (consolidation.crossref.mailto == null || consolidation.crossref.mailto.trim().length() == 0)
            return null;
        else
            return consolidation.crossref.mailto;
    }

    /**
     * Set the Crossref Metadata Plus authorization token to be used for Crossref
     * requests for the subscribers of this service.  This token will ensure that said
     * requests get directed to a pool of machines that are reserved for "Plus" SLA users.
     *
     * @param token authorization token to be used for requesting crossref
     */
    public void setCrossrefToken(final String token) {
        consolidation.crossref.token = token;
    }

    /**
     * Get the Crossref Metadata Plus authorization token to be used for Crossref
     * requests for the subscribers of this service.  This token will ensure that said
     * requests get directed to a pool of machines that are reserved for "Plus" SLA users.
     *
     * @return authorization token to be used for requesting crossref
     */
    public String getCrossrefToken() {
        if (consolidation.crossref.token == null || consolidation.crossref.token.trim().length() == 0)
            return null;
        else
            return consolidation.crossref.token;
    }

    public String getGluttonUrl() {
        if (consolidation.glutton.url == null || consolidation.glutton.url.trim().length() == 0) 
            return null;
        else
            return consolidation.glutton.url;
    }

    public void setGluttonUrl(final String theUrl) {
        consolidation.glutton.url = theUrl;
    }
}
