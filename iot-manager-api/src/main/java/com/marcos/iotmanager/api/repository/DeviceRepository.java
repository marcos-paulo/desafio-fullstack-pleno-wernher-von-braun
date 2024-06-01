package com.marcos.iotmanager.api.repository;

import org.springframework.data.repository.ListCrudRepository;
import com.marcos.iotmanager.api.model.Device;
import com.marcos.iotmanager.api.repository.device.DeviceRepositoryQuery;


public interface DeviceRepository extends ListCrudRepository<Device, Long>, DeviceRepositoryQuery {

}
