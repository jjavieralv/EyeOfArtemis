CREATE TABLE "zones" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "name" "VARCHAR(255)" NOT NULL,
  "description" "VARCHAR(255)" NOT NULL
);

CREATE TABLE "zones_groups" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "zones_id" BIGINT NOT NULL,
  "name" "VARCHAR(255)" NOT NULL,
  "description" "VARCHAR(255)" NOT NULL
);

CREATE TABLE "users" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "alias" "VARCHAR(255)" NOT NULL,
  "name" "VARCHAR(255)" NOT NULL,
  "email" "VARCHAR(255)",
  "phone" "VARCHAR(255)",
  "credentials_id" BIGINT
);

CREATE TABLE "permissions_user" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "user_id" BIGINT,
  "zone_id" BIGINT,
  "enabled" boolean
);

CREATE TABLE "permissions_user_zone_groups" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "user_id" BIGINT,
  "zone_group_id" BIGINT,
  "enabled" boolean
);

CREATE TABLE "groups" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "user_id" BIGINT,
  "alias" "VARCHAR(255)" NOT NULL,
  "name" "VARCHAR(255)" NOT NULL
);

CREATE TABLE "permissions_group" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "group_id" BIGINT,
  "zone_id" BIGINT,
  "enabled" boolean
);

CREATE TABLE "permissions_group_zone_groups" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "group_id" BIGINT,
  "zone_group_id" BIGINT,
  "enabled" boolean
);

CREATE TABLE "credentials_id" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "facial_id" BIGINT,
  "rfid_id" BIGINT,
  "fingerprint_id" BIGINT,
  "password_id" BIGINT
);

CREATE TABLE "facial" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "type" "VARCHAR(255)" NOT NULL,
  "name" "VARCHAR(255)" NOT NULL,
  "description" "VARCHAR(255)",
  "db_name_id" "VARCHAR(255)" NOT NULL
);

CREATE TABLE "fingerprint" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "type" "VARCHAR(255)" NOT NULL,
  "name" "VARCHAR(255)" NOT NULL,
  "description" "VARCHAR(255)",
  "db_name_id" BIGINT NOT NULL
);

CREATE TABLE "password" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "type" "VARCHAR(255)" NOT NULL,
  "name" "VARCHAR(255)" NOT NULL,
  "description" "VARCHAR(255)",
  "value_sha256" "VARCHAR(255)" NOT NULL
);

CREATE TABLE "rfid_cards" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "rfid_sha256" "VARCHAR(255)" NOT NULL
);

CREATE TABLE "devices" (
  "id" SERIAL UNIQUE PRIMARY KEY NOT NULL,
  "name" "VARCHAR(255)" NOT NULL,
  "description" "VARCHAR(255)" NOT NULL,
  "enabled" BOOLEAN NOT NULL,
  "type" "VARCHAR(255)" NOT NULL,
  "zone_assigned" "VARCHAR(255)" NOT NULL
);

ALTER TABLE "zones_groups" ADD FOREIGN KEY ("zones_id") REFERENCES "zones" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "groups" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "permissions_user" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "permissions_user" ADD FOREIGN KEY ("zone_id") REFERENCES "zones" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "permissions_user_zone_groups" ADD FOREIGN KEY ("zone_group_id") REFERENCES "zones_groups" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "permissions_user_zone_groups" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "permissions_group" ADD FOREIGN KEY ("group_id") REFERENCES "groups" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "permissions_group" ADD FOREIGN KEY ("zone_id") REFERENCES "zones" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "permissions_group_zone_groups" ADD FOREIGN KEY ("zone_group_id") REFERENCES "zones_groups" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "permissions_group_zone_groups" ADD FOREIGN KEY ("zone_group_id") REFERENCES "groups" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "credentials_id" ADD FOREIGN KEY ("id") REFERENCES "users" ("credentials_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "credentials_id" ADD FOREIGN KEY ("facial_id") REFERENCES "facial" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "credentials_id" ADD FOREIGN KEY ("fingerprint_id") REFERENCES "fingerprint" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "credentials_id" ADD FOREIGN KEY ("rfid_id") REFERENCES "rfid_cards" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "credentials_id" ADD FOREIGN KEY ("password_id") REFERENCES "password" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "devices" ADD FOREIGN KEY ("zone_assigned") REFERENCES "zones" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
