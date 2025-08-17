# Untitled Diagram documentation

https://www.drawdb.app/editor
https://dbdiagram.io/d/68a2000f1d75ee360aed166f

## Summary

- [Untitled Diagram documentation](#untitled-diagram-documentation)
	- [Summary](#summary)
	- [Introduction](#introduction)
	- [Database type](#database-type)
	- [Table structure](#table-structure)
		- [zones](#zones)
		- [zones\_groups](#zones_groups)
		- [users](#users)
		- [permissions\_user](#permissions_user)
		- [permissions\_user\_zone\_groups](#permissions_user_zone_groups)
		- [groups](#groups)
		- [permissions\_group](#permissions_group)
		- [permissions\_group\_zone\_groups](#permissions_group_zone_groups)
		- [credentials\_id](#credentials_id)
		- [facial](#facial)
		- [fingerprint](#fingerprint)
		- [password](#password)
		- [rfid\_cards](#rfid_cards)
		- [devices](#devices)
	- [Relationships](#relationships)
	- [Database Diagram](#database-diagram)


## Introduction

## Database type

- **Database system:** PostgreSQL
## Table structure

### zones

| Name            | Type   | Settings               | References | Note |
| --------------- | ------ | ---------------------- | ---------- | ---- |
| **id**          | SERIAL | 🔑 PK, not null, unique |            |      |
| **name**        | BLOB   | not null               |            |      |
| **description** | BLOB   | not null               |            |      |


### zones_groups

| Name            | Type   | Settings               | References                     | Note |
| --------------- | ------ | ---------------------- | ------------------------------ | ---- |
| **id**          | SERIAL | 🔑 PK, not null, unique |                                |      |
| **zones_id**    | BIGINT | not null               | fk_zones_groups_zones_id_zones |      |
| **name**        | BLOB   | not null               |                                |      |
| **description** | BLOB   | not null               |                                |      |


### users

| Name               | Type   | Settings               | References | Note |
| ------------------ | ------ | ---------------------- | ---------- | ---- |
| **id**             | SERIAL | 🔑 PK, not null, unique |            |      |
| **alias**          | BLOB   | not null               |            |      |
| **name**           | BLOB   | not null               |            |      |
| **email**          | BLOB   | null                   |            |      |
| **phone**          | BLOB   | null                   |            |      |
| **credentials_id** | BIGINT | null                   |            |      |


### permissions_user

| Name        | Type    | Settings               | References                        | Note |
| ----------- | ------- | ---------------------- | --------------------------------- | ---- |
| **id**      | SERIAL  | 🔑 PK, not null, unique |                                   |      |
| **user_id** | BIGINT  | null                   | fk_permissions_user_user_id_users |      |
| **zone_id** | BIGINT  | null                   | fk_permissions_user_zone_id_zones |      |
| **enabled** | BOOLEAN | null                   |                                   |      |


### permissions_user_zone_groups

| Name              | Type    | Settings               | References                                                 | Note |
| ----------------- | ------- | ---------------------- | ---------------------------------------------------------- | ---- |
| **id**            | SERIAL  | 🔑 PK, not null, unique |                                                            |      |
| **user_id**       | BIGINT  | null                   | fk_permissions_user_zone_groups_user_id_users              |      |
| **zone_group_id** | BIGINT  | null                   | fk_permissions_user_zone_groups_zone_group_id_zones_groups |      |
| **enabled**       | BOOLEAN | null                   |                                                            |      |


### groups

| Name        | Type   | Settings               | References              | Note |
| ----------- | ------ | ---------------------- | ----------------------- | ---- |
| **id**      | SERIAL | 🔑 PK, not null, unique |                         |      |
| **user_id** | BIGINT | null                   | fk_groups_user_id_users |      |
| **alias**   | BLOB   | not null               |                         |      |
| **name**    | BLOB   | not null               |                         |      |


### permissions_group

| Name         | Type    | Settings               | References                           | Note |
| ------------ | ------- | ---------------------- | ------------------------------------ | ---- |
| **id**       | SERIAL  | 🔑 PK, not null, unique |                                      |      |
| **group_id** | BIGINT  | null                   | fk_permissions_group_group_id_groups |      |
| **zone_id**  | BIGINT  | null                   | fk_permissions_group_zone_id_zones   |      |
| **enabled**  | BOOLEAN | null                   |                                      |      |


### permissions_group_zone_groups

| Name              | Type    | Settings               | References                                                                                                        | Note |
| ----------------- | ------- | ---------------------- | ----------------------------------------------------------------------------------------------------------------- | ---- |
| **id**            | SERIAL  | 🔑 PK, not null, unique |                                                                                                                   |      |
| **group_id**      | BIGINT  | null                   |                                                                                                                   |      |
| **zone_group_id** | BIGINT  | null                   | fk_permissions_group_zone_groups_zone_group_id_zones_groups,fk_permissions_group_zone_groups_zone_group_id_groups |      |
| **enabled**       | BOOLEAN | null                   |                                                                                                                   |      |


### credentials_id

| Name               | Type   | Settings               | References                                   | Note |
| ------------------ | ------ | ---------------------- | -------------------------------------------- | ---- |
| **id**             | SERIAL | 🔑 PK, not null, unique | fk_credentials_id_id_users                   |      |
| **facial_id**      | BIGINT | null                   | fk_credentials_id_facial_id_facial           |      |
| **rfid_id**        | BIGINT | null                   | fk_credentials_id_rfid_id_rfid_cards         |      |
| **fingerprint_id** | BIGINT | null                   | fk_credentials_id_fingerprint_id_fingerprint |      |
| **password_id**    | BIGINT | null                   | fk_credentials_id_password_id_password       |      |


### facial

| Name            | Type   | Settings               | References | Note |
| --------------- | ------ | ---------------------- | ---------- | ---- |
| **id**          | SERIAL | 🔑 PK, not null, unique |            |      |
| **type**        | BLOB   | not null               |            |      |
| **name**        | BLOB   | not null               |            |      |
| **description** | BLOB   | null                   |            |      |
| **db_name_id**  | BLOB   | not null               |            |      |


### fingerprint

| Name            | Type   | Settings               | References | Note |
| --------------- | ------ | ---------------------- | ---------- | ---- |
| **id**          | SERIAL | 🔑 PK, not null, unique |            |      |
| **type**        | BLOB   | not null               |            |      |
| **name**        | BLOB   | not null               |            |      |
| **description** | BLOB   | null                   |            |      |
| **db_name_id**  | BIGINT | not null               |            |      |


### password

| Name             | Type   | Settings               | References | Note |
| ---------------- | ------ | ---------------------- | ---------- | ---- |
| **id**           | SERIAL | 🔑 PK, not null, unique |            |      |
| **type**         | BLOB   | not null               |            |      |
| **name**         | BLOB   | not null               |            |      |
| **description**  | BLOB   | null                   |            |      |
| **value_sha256** | BLOB   | not null               |            |      |


### rfid_cards

| Name            | Type   | Settings               | References | Note |
| --------------- | ------ | ---------------------- | ---------- | ---- |
| **id**          | SERIAL | 🔑 PK, not null, unique |            |      |
| **rfid_sha256** | BLOB   | not null               |            |      |


### devices

| Name              | Type    | Settings               | References                     | Note |
| ----------------- | ------- | ---------------------- | ------------------------------ | ---- |
| **id**            | SERIAL  | 🔑 PK, not null, unique |                                |      |
| **name**          | BLOB    | not null               |                                |      |
| **description**   | BLOB    | not null               |                                |      |
| **enabled**       | BOOLEAN | not null               |                                |      |
| **type**          | BLOB    | not null               |                                |      |
| **zone_assigned** | BLOB    | not null               | fk_devices_zone_assigned_zones |      |


## Relationships

- **zones_groups to zones**: many_to_one
- **groups to users**: many_to_one
- **permissions_user to users**: many_to_one
- **permissions_user to zones**: many_to_one
- **permissions_user_zone_groups to zones_groups**: many_to_one
- **permissions_user_zone_groups to users**: many_to_one
- **permissions_group to groups**: many_to_one
- **permissions_group to zones**: many_to_one
- **permissions_group_zone_groups to zones_groups**: many_to_one
- **permissions_group_zone_groups to groups**: many_to_one
- **credentials_id to users**: one_to_one
- **credentials_id to facial**: many_to_one
- **credentials_id to fingerprint**: many_to_one
- **credentials_id to rfid_cards**: many_to_one
- **credentials_id to password**: many_to_one
- **devices to zones**: many_to_one

## Database Diagram

```mermaid
erDiagram
	zones_groups }o--|| zones : references
	groups }o--|| users : references
	permissions_user }o--|| users : references
	permissions_user }o--|| zones : references
	permissions_user_zone_groups }o--|| zones_groups : references
	permissions_user_zone_groups }o--|| users : references
	permissions_group }o--|| groups : references
	permissions_group }o--|| zones : references
	permissions_group_zone_groups }o--|| zones_groups : references
	permissions_group_zone_groups }o--|| groups : references
	credentials_id ||--|| users : references
	credentials_id }o--|| facial : references
	credentials_id }o--|| fingerprint : references
	credentials_id }o--|| rfid_cards : references
	credentials_id }o--|| password : references
	devices }o--|| zones : references

	zones {
		SERIAL id
		BLOB name
		BLOB description
	}

	zones_groups {
		SERIAL id
		BIGINT zones_id
		BLOB name
		BLOB description
	}

	users {
		SERIAL id
		BLOB alias
		BLOB name
		BLOB email
		BLOB phone
		BIGINT credentials_id
	}

	permissions_user {
		SERIAL id
		BIGINT user_id
		BIGINT zone_id
		BOOLEAN enabled
	}

	permissions_user_zone_groups {
		SERIAL id
		BIGINT user_id
		BIGINT zone_group_id
		BOOLEAN enabled
	}

	groups {
		SERIAL id
		BIGINT user_id
		BLOB alias
		BLOB name
	}

	permissions_group {
		SERIAL id
		BIGINT group_id
		BIGINT zone_id
		BOOLEAN enabled
	}

	permissions_group_zone_groups {
		SERIAL id
		BIGINT group_id
		BIGINT zone_group_id
		BOOLEAN enabled
	}

	credentials_id {
		SERIAL id
		BIGINT facial_id
		BIGINT rfid_id
		BIGINT fingerprint_id
		BIGINT password_id
	}

	facial {
		SERIAL id
		BLOB type
		BLOB name
		BLOB description
		BLOB db_name_id
	}

	fingerprint {
		SERIAL id
		BLOB type
		BLOB name
		BLOB description
		BIGINT db_name_id
	}

	password {
		SERIAL id
		BLOB type
		BLOB name
		BLOB description
		BLOB value_sha256
	}

	rfid_cards {
		SERIAL id
		BLOB rfid_sha256
	}

	devices {
		SERIAL id
		BLOB name
		BLOB description
		BOOLEAN enabled
		BLOB type
		BLOB zone_assigned
	}
```