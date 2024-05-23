-- crie uma lista de inserts para popular as tabelas do banco de dados com dispositivos IOT
INSERT INTO device (identifier, description, manufacturer, url) VALUES 
    ('lampada', 'Lâmpada inteligente', 'Philips', 'http://localhost:8080/lampada'), 
    ('ar-condicionado', 'Ar condicionado inteligente', 'Samsung', 'http://localhost:8080/ar-condicionado'),
    ('televisao', 'Televisão inteligente', 'LG', 'http://localhost:8080/televisao'),
    ('aspirador', 'Aspirador de pó inteligente', 'Electrolux', 'http://localhost:8080/aspirador');


INSERT INTO command_description (operation, description, result, format, fk_device_id) VALUES 
    ('ligar', 'Liga o dispositivo', 'Dispositivo ligado', 'boolean', 1),
    ('desligar', 'Desliga o dispositivo', 'Dispositivo desligado', 'boolean', 1),
    ('ligar', 'Liga o dispositivo', 'Dispositivo ligado', 'boolean', 2),
    ('desligar', 'Desliga o dispositivo', 'Dispositivo desligado', 'boolean', 2),
    ('ligar', 'Liga o dispositivo', 'Dispositivo ligado', 'boolean', 3),
    ('desligar', 'Desliga o dispositivo', 'Dispositivo desligado', 'boolean', 3),
    ('ligar', 'Liga o dispositivo', 'Dispositivo ligado', 'boolean', 4),
    ('desligar', 'Desliga o dispositivo', 'Dispositivo desligado', 'boolean', 4);

INSERT INTO command (command, fk_command_description_id) VALUES 
    ('start', 1),
    ('stop', 2),
    ('start', 3),
    ('stop', 4),
    ('start', 5),
    ('stop', 6),
    ('start', 7),
    ('stop', 8);

INSERT INTO parameter (name, description, fk_command_id) VALUES 
    ('t10', 'Atrasa 10 segundos', 1),
    ('t10', 'Atrasa 10 segundos', 2),
    ('t10', 'Atrasa 10 segundos', 3),
    ('t10', 'Atrasa 10 segundos', 4),
    ('t10', 'Atrasa 10 segundos', 5),
    ('t10', 'Atrasa 10 segundos', 6),
    ('t10', 'Atrasa 10 segundos', 7),
    ('t10', 'Atrasa 10 segundos', 8);