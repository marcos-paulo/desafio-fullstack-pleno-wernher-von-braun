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
@Table(name = "command_description")
public class CommandDescription {
  @Id()
  @JsonIgnore()
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "command_description_id")
  private Long comandDescriptionId;

  private String operation;

  private String description;

  // @OneToOne()
  // @JoinColumn(name = "command_description_id")
  // private Command command;

  private String result;

  private String format;
}
