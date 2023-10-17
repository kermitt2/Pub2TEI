package org.pub2tei.main;

/**
 * Class containing args of the command 
 */
public class MainArgs {

    private String path2Input;

    private String path2Output;

    private String processMethodName;
    
    private boolean recursive = false; 

    private boolean consolidateHeader = true;

    private boolean consolidateCitation = false;

    private boolean segmentSentences = false;

    /**
     * @return the path2input
     */
    public final String getPath2Input() {
        return path2Input;
    }

    /**
     * @param pPath2input
     *            the path2input to set
     */
    public final void setPath2Input(final String pPath2input) {
        path2Input = pPath2input;
    }

    /**
     * @return the path2Output
     */
    public final String getPath2Output() {
        return path2Output;
    }

    /**
     * @param pPath2Output
     *            the path2Output to set
     */
    public final void setPath2Output(final String pPath2Output) {
        path2Output = pPath2Output;
    }

    /**
     * @return the processMethodName
     */
    public final String getProcessMethodName() {
        return processMethodName;
    }

    /**
     * @param pProcessMethodName
     *            the processMethodName to set
     */
    public final void setProcessMethodName(final String pProcessMethodName) {
        processMethodName = pProcessMethodName;
    }

    /**
     * @return true if recursive file processing
     */
    public final boolean isRecursive() {
        return recursive;
    }

    /**
     * @return true if consolidation of header metadata should be done
     */
    public final boolean isConsolidateHeader() {
        return consolidateHeader;
    }

    /**
     * @return true if consolidation of citation metadata should be done
     */
    public final boolean isConsolidateCitation() {
        return consolidateCitation;
    }

    /**
     * @return true if consolidation of header metadata should be done
     */
    public final boolean getConsolidateHeader() {
        return consolidateHeader;
    }

    /**
     * @return true if consolidation of citation metadata should be done
     */
    public final boolean getConsolidateCitation() {
        return consolidateCitation;
    }

    /**
     * @param pRecursive
     *            recursive file processing parameter to set
     */
    public final void setRecursive(final boolean pRecursive) {
        recursive = pRecursive;
    }

    /**
     * @return true if we add sentence segmentation level structures for paragraphs in the TEI XML result 
     */
    public final boolean getSegmentSentences() {
        return segmentSentences;
    }

    /**
     * @param pSegmentSentences
     *            add sentence segmentation level structures for paragraphs in the TEI XML result 
     */
    public final void setSegmentSentences(final boolean pSegmentSentences) {
        segmentSentences = pSegmentSentences;
    }

}
