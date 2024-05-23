package com.marcos.iotmanager.api.exceptionhandler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@ControllerAdvice
public class IotManagerApiExceptionHandler extends ResponseEntityExceptionHandler {

  @Autowired
  private MessageSource messageSource;

  @Override
  protected ResponseEntity<Object> handleHttpMessageNotReadable(HttpMessageNotReadableException ex,
      HttpHeaders headers, HttpStatusCode status, WebRequest request) {

    String mensagemUsuario =
        messageSource.getMessage("mensagem.invalida", null, LocaleContextHolder.getLocale());

    String mensagemDesenvolvedor = ex.getCause().toString();

    Erro erro = new Erro(mensagemUsuario, mensagemDesenvolvedor);

    return super.handleExceptionInternal(ex, erro, headers, HttpStatus.BAD_REQUEST, request);
  }

  @Data
  @RequiredArgsConstructor
  @AllArgsConstructor
  public static class Erro {
    private String mensagemUsuario;
    private String mensagemDesenvolvedor;
  }

}
