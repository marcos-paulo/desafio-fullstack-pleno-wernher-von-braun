package com.marcos.iotmanager.api.repository.device;

import java.util.Optional;
import com.marcos.iotmanager.api.model.Device;

public interface DeviceRepositoryQuery {
  public Optional<Device> findByIdentifier(String identifier);
}
