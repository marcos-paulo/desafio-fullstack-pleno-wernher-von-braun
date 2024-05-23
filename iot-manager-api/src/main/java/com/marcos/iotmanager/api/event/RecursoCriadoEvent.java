package com.marcos.iotmanager.api.event;

import org.springframework.context.ApplicationEvent;
import jakarta.servlet.http.HttpServletResponse;
import lombok.Getter;

public class RecursoCriadoEvent extends ApplicationEvent {

  private static final long serialVersionUID = 1L;
  @Getter()
  private HttpServletResponse response;
  @Getter()
  private Long id;

  public RecursoCriadoEvent(Object source, HttpServletResponse response, Long id) {
    super(source);
    this.response = response;
    this.id = id;
  }

}
