# FROM openjdk-21-jre
FROM eclipse-temurin:21-jre
ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar trend.jar
ENTRYPOINT [ "java", "-jar", "trend.jar" ]