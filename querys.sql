ALTER TABLE Device RENAME TO device;
ALTER TABLE Command RENAME TO command;
ALTER TABLE Parameter RENAME TO parameter;
ALTER TABLE CommandDescription RENAME TO command_description;
ALTER TABLE DeviceList RENAME TO device_list;



drop database 'iot-maneger-db' ;
drop database if exists 'iot-maneger-db';

DROP DATABASE "iot-maneger-db";


DROP TABLE if exists parameter;

DROP TABLE if exists command;

DROP TABLE if exists command_description;

DROP TABLE if exists device;

DROP TABLE if exists flyway_schema_history;

INSERT INTO device (identifier, description, manufacturer, url) VALUES 
    ('lampada', 'Lâmpada inteligente', 'Philips', 'http://localhost:8080/lampada'), 
    ('ar-condicionado', 'Ar condicionado inteligente', 'Samsung', 'http://localhost:8080/ar-condicionado');
    
select c1_0.fk_device_id,
  c1_0.command_description_id,
  c2_0.command_id,
  c2_0.command,
  c1_0.description,
  c1_0.format,
  c1_0.operation,
  c1_0.result 
  from command_description c1_0 
  left join command c2_0 
  on c2_0.fk_command_description_id=c1_0.command_description_id
  where c1_0.fk_device_id=17