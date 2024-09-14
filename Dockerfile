## Docker Pub2TEI image using Grobid deep learning models and/or CRF models for transformation enhancements

# this is the full GROBID image using NVIDIA Container Toolkit to automatically recognize possible GPU drivers on the host machine
FROM grobid/grobid:0.8.1

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "-s", "--"]

WORKDIR /opt/Pub2TEI
COPY . .
RUN ./gradlew clean install --info --stacktrace

ENV PUB2_TEI_OPTS "--add-opens java.base/java.lang=ALL-UNNAMED -Djava.library.path=$LD_LIBRARY_PATH:../grobid/grobid-home/lib/lin-64:../grobid/grobid-home/lib/lin-64/jep"

CMD ["./script/pub2tei-service.sh", "server", "resources/config/config.yml"]

ARG PUB2TEI_VERSION

LABEL \
    authors="The contributors" \
    org.label-schema.name="Pub2TEI" \
    org.label-schema.description="Image with Pub2TEI service" \
    org.label-schema.url="https://github.com/kermitt2/Pub2TEI" \
    org.label-schema.version=${PUB2TEI_VERSION}
