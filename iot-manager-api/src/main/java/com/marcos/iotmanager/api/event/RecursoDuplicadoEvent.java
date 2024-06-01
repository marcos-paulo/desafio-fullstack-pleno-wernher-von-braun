package com.marcos.iotmanager.api.event;

import org.springframework.context.ApplicationEvent;
import jakarta.servlet.http.HttpServletResponse;
import lombok.Getter;

public class RecursoDuplicadoEvent extends ApplicationEvent {

  private static final long serialVersionUID = 1L;
  @Getter()
  private HttpServletResponse response;

  public RecursoDuplicadoEvent(Object source, HttpServletResponse response) {
    super(source);
    this.response = response;
  }

}
