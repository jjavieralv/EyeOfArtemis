# Backend

## Index

## Gestion de permisos

La gestion de accesos va a estar basada en un fichero json que va a contener los permisos para cada zona, tipo de dispositivo, usuario, etc.

### Estructura del fichero json

```json
{
  "zones": [
    {
    "id": "zone_1",
    "name": "Entrada Principal",
    "description": "Entrada principal de la vivienda"
    }
  ],
  "zones_groups": [
    {
    "id": "zone_group_1",
    "name": "Casa principal",
    "description": "Grupo de las zonas de la casa principal",
    "zones": ["zone_1", "zone_2"]
    }
  ],
  "devices": [
    {
      "id": "device_1",
      "name": "Lector RFID Entrada",
      "type": "rfid",
      "zone_id": "zone_1",
    }
  ],
  "users": [
    {
      "id": "user_1",
      "name": "Juan Pérez",
      "email": "juan.perez@empresa.com",
      "credentials": {
        "rfid": "A1B2C3D4",
        "facial_id": "facial_juan_123",
        "fingerprint_id": "fp_juan_456"
      },
      "groups": ["it_staff"]
    }
  ],
  "groups": [
    {
      "id": "employees",
      "name": "Empleados",
      "description": "Todos los empleados de la empresa"
    }
  ],
  "schedules": [
    {
      "id": "schedule_1",
      "name": "Horario Laboral",
      "time_ranges": [
        {
          "days": ["monday", "tuesday", "wednesday", "thursday", "friday"],
          "start_time": "08:00",
          "end_time": "18:00"
        }
      ]
    }
  ],
  "access_rules": [
    {
      "id": "rule_1",
      "zone_id": "zone_1",
      "group_id": "employees",
      "schedule_id": "schedule_1",
      "allowed_devices": ["rfid", "facial"]
    }
  ],
  "holidays": [
    {
      "id": "holiday_1",
      "name": "Año Nuevo",
      "date": "2023-01-01",
    }
  ],
  "special_permissions": [
    {
      "id": "special_1",
      "user_id": "user_1",
      "zone_id": "zone_3",
      "valid_from": "2023-01-01",
      "valid_until": "2023-12-31",
      "reason": "Mantenimiento de servidores"
    }
  ]
}


```
