package com.marcos.iotmanager.api.resources;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/teste")
public class TesteResource {

  @GetMapping("/path")
  public String getMethodName() {
    return "teste";
  }

}
