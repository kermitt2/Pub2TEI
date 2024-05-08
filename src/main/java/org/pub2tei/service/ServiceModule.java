package org.pub2tei.service;

import com.google.inject.Provides;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import ru.vyarus.dropwizard.guice.module.support.DropwizardAwareModule;


public class ServiceModule extends DropwizardAwareModule<ServiceConfiguration> {

    @Override
    public void configure() {
        // Generic modules
        //binder.bind(GrobidEngineInitialiser.class);
        bind(HealthCheck.class);

        // Core components
        bind(ProcessFile.class);
        bind(ProcessString.class);

        // REST
        bind(ServiceController.class);
    }

//    @Provides
//    protected ObjectMapper getObjectMapper() {
//        return getEnvironment().getObjectMapper();
//    }
//
//    @Provides
//    protected MetricRegistry provideMetricRegistry() {
//        return getMetricRegistry();
//    }
//
//    //for unit tests
//    protected MetricRegistry getMetricRegistry() {
//        return getEnvironment().metrics();
//    }
//
    @Provides
    Client provideClient() {
        return ClientBuilder.newClient();
    }

}