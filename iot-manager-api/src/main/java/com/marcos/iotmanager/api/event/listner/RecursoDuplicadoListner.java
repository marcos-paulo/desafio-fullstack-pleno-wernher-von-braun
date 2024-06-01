package com.marcos.iotmanager.api.event.listner;

import java.io.IOException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import com.marcos.iotmanager.api.event.RecursoDuplicadoEvent;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class RecursoDuplicadoListner implements ApplicationListener<RecursoDuplicadoEvent> {

  @Autowired
  private MessageSource messageSource;

  @Override
  public void onApplicationEvent(RecursoDuplicadoEvent event) {
    HttpServletResponse response = event.getResponse();

    String mensagem = messageSource.getMessage("mensagem.recurso.duplicado", null,
        LocaleContextHolder.getLocale());

    try {
      response.setContentType("text/plain");
      response.setCharacterEncoding("UTF-8");
      response.setStatus(HttpServletResponse.SC_CONFLICT);
      response.getWriter().write(mensagem);
      response.getWriter().flush();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }


}
