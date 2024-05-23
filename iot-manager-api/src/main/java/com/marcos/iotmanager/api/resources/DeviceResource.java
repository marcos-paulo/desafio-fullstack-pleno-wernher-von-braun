package com.marcos.iotmanager.api.resources;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import com.marcos.iotmanager.api.event.RecursoCriadoEvent;
import com.marcos.iotmanager.api.model.Device;
import com.marcos.iotmanager.api.repository.DeviceRepository;
import jakarta.servlet.http.HttpServletResponse;


@RestController
@RequestMapping("/device")
public class DeviceResource {

  @Autowired
  private DeviceRepository deviceRepository;

  @Autowired
  private ApplicationEventPublisher publisher;

  @Autowired
  private MessageSource messageSource;

  @GetMapping
  public ResponseEntity<?> getDevices() {
    List<Device> devices = deviceRepository.findAll();
    System.out.println(devices);
    List<String> deviceName =
        devices.stream().map((device) -> device.getIdentifier()).collect(Collectors.toList());
    return deviceName.isEmpty() ? ResponseEntity.noContent().build()
        : ResponseEntity.ok(deviceName);
  }

  @PostMapping()
  @ResponseStatus(HttpStatus.CREATED)
  public void createDevice(@RequestBody Device entity, HttpServletResponse response) {
    Device device = deviceRepository.save(entity);
    publisher.publishEvent(new RecursoCriadoEvent(this, response, device.getDeviceId()));
  }

  @GetMapping("/{id}")
  public ResponseEntity<?> getDeviceById(@PathVariable Long id) {
    String mensagemUsuario = messageSource.getMessage("mensagem.dispositivo.nao.encontrado", null,
        LocaleContextHolder.getLocale());
    Optional<Device> responseDevice = deviceRepository.findById(id);
    return responseDevice.isPresent() ? ResponseEntity.ok(responseDevice.get())
        : ResponseEntity.status(HttpStatus.NOT_FOUND).body(mensagemUsuario);
  }

  @DeleteMapping("/{id}")
  @ResponseStatus(HttpStatus.NO_CONTENT)
  public void deleteDevice(@PathVariable Long id) {
    deviceRepository.findById(id)
        .orElseThrow(() -> new IllegalArgumentException("Device not found"));
    deviceRepository.deleteById(id);
  }
}
