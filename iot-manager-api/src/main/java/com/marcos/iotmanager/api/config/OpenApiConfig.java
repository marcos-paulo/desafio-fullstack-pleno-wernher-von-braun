package com.marcos.iotmanager.api.config;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.parser.OpenAPIV3Parser;
import io.swagger.v3.parser.core.models.SwaggerParseResult;

@Configuration
public class OpenApiConfig {

  @Bean
  public OpenAPI customOpenAPI() throws IOException {
    ClassPathResource openApiResource = new ClassPathResource("openapi.yaml");
    String openApiSpec =
        new String(Files.readAllBytes(Paths.get(openApiResource.getURI())), StandardCharsets.UTF_8);

    SwaggerParseResult parseResult = new OpenAPIV3Parser().readContents(openApiSpec, null, null);
    return parseResult.getOpenAPI();
  }
}

