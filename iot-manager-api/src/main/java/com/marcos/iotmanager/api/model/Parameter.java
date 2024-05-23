package com.marcos.iotmanager.api.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data()
@Entity()
@Table(name = "parameter")
public class Parameter {
  @Id()
  @JsonIgnore()
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "parameter_id")
  private Long parameterId;

  private String name;

  private String description;

}
