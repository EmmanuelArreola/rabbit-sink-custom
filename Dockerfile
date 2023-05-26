FROM maven:3.6.1-jdk-8-alpine AS MAVEN_BUILD
COPY ./ ./
RUN mvn clean package -DskipTests=true

FROM adoptopenjdk:11-jre-hotspot as builder
COPY --from=MAVEN_BUILD /target/*.jar /application.jar

RUN java -Djarmode=layertools -jar application.jar extract

FROM adoptopenjdk:11-jre-hotspot
COPY --from=builder dependencies/ ./
COPY --from=builder snapshot-dependencies/ ./
COPY --from=builder spring-boot-loader/ ./
COPY --from=builder application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]

LABEL org.opencontainers.image.ref.name="ubuntu"
LABEL org.opencontainers.image.title="rabbit-sink"
LABEL org.opencontainers.image.version="0.0.1"
LABEL org.springframework.boot.version="2.6.6"
LABEL org.springframework.boot.spring-configuration-metadata.json="{\"groups\": [{\"name\": \"rabbit\",\"type\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\"}],\"properties\": [{\"name\": \"rabbit.exchange\",\"type\": \"java.lang.String\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.exchangeExpression\",\"type\": \"org.springframework.expression.Expression\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.routingKey\",\"type\": \"java.lang.String\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.routingKeyExpression\",\"type\": \"org.springframework.expression.Expression\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.persistentDeliveryMode\",\"type\": \"java.lang.Boolean\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.mappedRequestHeaders\",\"type\": \"java.lang.String[]\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"{'*'}\"},{\"name\": \"rabbit.converterBeanName\",\"type\": \"java.lang.String\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.ownConnection\",\"type\": \"java.lang.Boolean\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.headersMappedLast\",\"type\": \"java.lang.Boolean\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.exchange\",\"type\": \"java.lang.String\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"}]}"
LABEL org.springframework.cloud.dataflow.spring-configuration-metadata.json="{\"groups\": [{\"name\": \"rabbit\",\"type\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\"}],\"properties\": [{\"name\": \"rabbit.exchange\",\"type\": \"java.lang.String\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.exchangeExpression\",\"type\": \"org.springframework.expression.Expression\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.routingKey\",\"type\": \"java.lang.String\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.routingKeyExpression\",\"type\": \"org.springframework.expression.Expression\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.persistentDeliveryMode\",\"type\": \"java.lang.Boolean\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.mappedRequestHeaders\",\"type\": \"java.lang.String[]\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"{'*'}\"},{\"name\": \"rabbit.converterBeanName\",\"type\": \"java.lang.String\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.ownConnection\",\"type\": \"java.lang.Boolean\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.headersMappedLast\",\"type\": \"java.lang.Boolean\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.exchange\",\"type\": \"java.lang.String\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitsink.bean.RabbitConsumerProperties\",\"defaultValue\": \"\"}]}"