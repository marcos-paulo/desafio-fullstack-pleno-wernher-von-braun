package com.marcos.iotmanager.api.repository;

import org.springframework.data.repository.ListCrudRepository;
import com.marcos.iotmanager.api.model.Device;


public interface DeviceRepository extends ListCrudRepository<Device, Long> {

  // @Modifying
  // @Query("DELETE FROM Device d WHERE d.deviceId= :parentId")
  // void deleteByParentId(@Param("parentId") Long parentId);
  // void List<Device> findByIdentifier(String identifier);
}
