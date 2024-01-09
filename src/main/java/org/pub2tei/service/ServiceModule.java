package org.pub2tei.service;

import com.codahale.metrics.MetricRegistry;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.inject.Binder;
import com.google.inject.Provides;
import com.hubspot.dropwizard.guicier.DropwizardAwareModule;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;

public class ServiceModule extends DropwizardAwareModule<ServiceConfiguration> {

    @Override
    public void configure(Binder binder) {
        // Generic modules
        //binder.bind(GrobidEngineInitialiser.class);
        binder.bind(HealthCheck.class);

        // Core components
        binder.bind(ProcessFile.class);
        binder.bind(ProcessString.class);

        // REST
        binder.bind(ServiceController.class);
    }

    @Provides
    protected ObjectMapper getObjectMapper() {
        return getEnvironment().getObjectMapper();
    }

    @Provides
    protected MetricRegistry provideMetricRegistry() {
        return getMetricRegistry();
    }

    //for unit tests
    protected MetricRegistry getMetricRegistry() {
        return getEnvironment().metrics();
    }

    @Provides
    Client provideClient() {
        return ClientBuilder.newClient();
    }

}