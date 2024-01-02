## Docker Pub2TEI image using Grobid deep learning models and/or CRF models for transformation enhancements

# this is the full GROBID image using NVIDIA Container Toolkit to automatically recognize possible GPU drivers on the host machine
FROM grobid/grobid:0.8.0

WORKDIR /opt/Pub2TEI
COPY . .
RUN ./gradlew clean --info --stacktrace

ENV GROBID_SERVICE_OPTS "--add-opens java.base/java.lang=ALL-UNNAMED"

CMD ["./gradlew", "run"]

ARG PUB2TEI_VERSION

LABEL \
    authors="The contributors" \
    org.label-schema.name="Pub2TEI" \
    org.label-schema.description="Image with Pub2TEI service" \
    org.label-schema.url="https://github.com/kermitt2/Pub2TEI" \
    org.label-schema.version=${PUB2TEI_VERSION}
