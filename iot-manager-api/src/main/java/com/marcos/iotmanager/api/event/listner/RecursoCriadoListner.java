package com.marcos.iotmanager.api.event.listner;

import java.net.URI;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import com.marcos.iotmanager.api.event.RecursoCriadoEvent;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class RecursoCriadoListner implements ApplicationListener<RecursoCriadoEvent> {

  @Override
  public void onApplicationEvent(RecursoCriadoEvent event) {
    HttpServletResponse response = event.getResponse();
    Long id = event.getId();

    URI uri = ServletUriComponentsBuilder.fromCurrentRequestUri().path("/{id}").buildAndExpand(id)
        .toUri();
    response.setHeader("Location", uri.toASCIIString());
    response.setStatus(HttpServletResponse.SC_CREATED);
  }

}
