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
import jakarta.persistence.Table;
import lombok.Data;

@Data()
@Entity()
@Table(name = "command")
public class Command {
  @Id()
  @JsonIgnore()
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "command_id")
  private Long commandId;

  private String command;

  @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
  @JoinColumn(name = "fk_command_id")
  private List<Parameter> parameters;
}
