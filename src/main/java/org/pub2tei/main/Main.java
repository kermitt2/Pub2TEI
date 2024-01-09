package org.pub2tei.main;

import org.pub2tei.service.ServiceConfiguration;
import org.pub2tei.document.DocumentProcessor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory;

import static org.apache.commons.lang3.StringUtils.isNotEmpty;

/**
 * An executable class to launch Pub2TEI with command lines
 * 
 * @author Patrice
 */
public class Main {
    private static Logger LOGGER = LoggerFactory.getLogger(Main.class);

    //private static final String COMMAND_PROCESS_TEXT = "processText";
    private static final String COMMAND_PROCESS_XML = "processXML";

    private static List<String> availableCommands = Arrays.asList(
            COMMAND_PROCESS_XML
    );

    /**
     * Arguments of the batch.
     */
    private static MainArgs gbdArgs;

    /**
     * @return String to display for help.
     */
    protected static String getHelp() {
        final StringBuffer help = new StringBuffer();
        help.append("HELP Pub2TEI\n");
        help.append("-h: displays help\n");
        help.append("-dIn: gives the path to the directory where the files to be processed are located, to be used only when the called method needs it.\n");
        help.append("-dOut: gives the path to the directory where the result files will be saved. The default output directory is the curent directory.\n");
        help.append("-r: recursive directory processing, default processing is not recursive.\n");
        help.append("-exe: gives the command to execute. The value should be one of these:\n");
        help.append("\t" + availableCommands + "\n");
        return help.toString();
    }

    /**
     * Process batch given the args.
     *
     * @param pArgs The arguments given to the batch.
     */
    protected static boolean processArgs(final String[] pArgs) {
        boolean result = true;
        if (pArgs.length == 0) {
            System.out.println(getHelp());
            result = false;
        } else {
            String currArg;
            for (int i = 0; i < pArgs.length; i++) {
                currArg = pArgs[i];
                if (currArg.equals("-h")) {
                    System.out.println(getHelp());
                    result = false;
                    break;
                }
                if (currArg.equals("-dIn")) {
                    if (pArgs[i + 1] != null) {
                        gbdArgs.setPath2Input(pArgs[i + 1]);
                    }
                    i++;
                    continue;
                }
                if (currArg.equals("-dOut")) {
                    if (pArgs[i + 1] != null) {
                        gbdArgs.setPath2Output(pArgs[i + 1]);
                    }
                    i++;
                    continue;
                }
                if (currArg.equals("-exe")) {
                    final String command = pArgs[i + 1];
                    if (availableCommands.contains(command)) {
                        gbdArgs.setProcessMethodName(command);
                        i++;
                        continue;
                    } else {
                        System.err.println("-exe value should be one value from this list: " + availableCommands);
                        result = false;
                        break;
                    }
                }
                if (currArg.equals("-r")) {
                    gbdArgs.setRecursive(true);
                    continue;
                }
            }
        }
        return result;
    }

    public static void main(final String[] args) throws Exception {
        gbdArgs = new MainArgs();

        ObjectMapper mapper = new ObjectMapper(new YAMLFactory());
        File yamlFile = new File("resources/config/config.yml");
        yamlFile = new File(yamlFile.getAbsolutePath());
        ServiceConfiguration conf = mapper.readValue(yamlFile, ServiceConfiguration.class);

        if (processArgs(args) && (gbdArgs.getProcessMethodName() != null)) {    
            int nb = 0;
            DocumentProcessor documentProcessor = new DocumentProcessor(conf);
            long time = System.currentTimeMillis();
                
            if (gbdArgs.getProcessMethodName().equals(COMMAND_PROCESS_XML)) {
                nb = documentProcessor.processDirectory(gbdArgs);
            } else {
                throw new RuntimeException("Command not yet implemented.");
            }
            LOGGER.info(nb + " files processed in " + (System.currentTimeMillis() - time) + " milliseconds");
        }

    }

}
