FROM eclipse-temurin:11-jre-alpine

WORKDIR /app

RUN apk update && apk add --no-cache curl

ARG NEXUS_USER
ARG NEXUS_PASS
ARG NEXUS_URL
ARG GROUP_ID
ARG ARTIFACT_ID
ARG VERSION

RUN curl -u ${NEXUS_USER}:${NEXUS_PASS} \
 http://${NEXUS_URL}/repository/maven-releases/\
$(echo ${GROUP_ID} | tr '.' '/')/${ARTIFACT_ID}/${VERSION}/${ARTIFACT_ID}-${VERSION}.jar \
 -o app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
