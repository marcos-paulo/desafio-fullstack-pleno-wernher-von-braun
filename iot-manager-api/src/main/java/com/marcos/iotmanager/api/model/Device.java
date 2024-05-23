package com.marcos.iotmanager.api.model;

import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import lombok.Data;

@Data()
@Entity(name = "device")
public class Device {
  @Id()
  @JsonIgnore()
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "device_id")
  private Long deviceId;

  private String identifier;

  private String description;

  private String manufacturer;

  private String url;

  @OneToMany(cascade = CascadeType.ALL)
  @JoinColumn(name = "fk_device_id")
  private List<CommandDescription> commands;
}
