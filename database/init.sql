DROP TABLE IF EXISTS "Zoo" CASCADE;
DROP TABLE IF EXISTS "Gehege_Personal" CASCADE;
DROP TABLE IF EXISTS "Gehege" CASCADE;
DROP TABLE IF EXISTS "Beruf" CASCADE;
DROP TABLE IF EXISTS "Tier" CASCADE;
DROP TABLE IF EXISTS "Verkaufsstand" CASCADE;
DROP TABLE IF EXISTS "Personal" CASCADE;
DROP TABLE IF EXISTS "Umsatz" CASCADE;
DROP TABLE IF EXISTS "Spende" CASCADE;

-- lower CASE
DROP TABLE IF EXISTS "zoo" CASCADE;
DROP TABLE IF EXISTS "gehege_personal" CASCADE;
DROP TABLE IF EXISTS "gehege" CASCADE;
DROP TABLE IF EXISTS "beruf" CASCADE;
DROP TABLE IF EXISTS "tier" CASCADE;
DROP TABLE IF EXISTS "umsatz" CASCADE;
DROP TABLE IF EXISTS "verkaufsstand" CASCADE;
DROP TABLE IF EXISTS "personal" CASCADE;
DROP TABLE IF EXISTS "spende" CASCADE;


CREATE TYPE "standart" AS ENUM (
  'Eis',
  'Regenschirm',
  'Infokarte',
  'Burger'
);

CREATE TABLE "gehege" (
  "id" serial PRIMARY KEY,
  "groesse" decimal,
  "instandhaltungskosten" decimal,
  "name" text
);

CREATE TABLE "tier" (
  "id" serial PRIMARY KEY,
  "name" text,
  "gehege_id" integer NOT NULL,
  "tierarzt_id" integer NOT NULL
);

CREATE TABLE "zoo" (
  "kontostand" decimal,
  "eintritt" decimal
);

CREATE TABLE "umsatz" (
  "id" serial PRIMARY KEY,
  "tagessumme" decimal,
  "datum" date,
  "stand_id" integer,
  "spende_id" integer,
  "is_eintritt" boolean
);

CREATE TABLE "spende" (
  "id" serial PRIMARY KEY,
  "spender_name" text,
  "datum" date,
  "betrag" decimal,
  "beleg_url" text
);

CREATE TABLE "verkaufsstand" (
  "id" serial PRIMARY KEY,
  "stand_art" standart,
  "verkaeufer_id" integer
);

CREATE TABLE "personal" (
  "id" serial PRIMARY KEY,
  "beruf_id" integer NOT NULL
);

CREATE TABLE "gehege_personal" (
  "pfleger_id" integer NOT NULL,
  "gehege_id" integer NOT NULL
);

CREATE TABLE "beruf" (
  "id" serial PRIMARY KEY,
  "bezeichnung" text
);

ALTER TABLE "tier" ADD FOREIGN KEY ("gehege_id") REFERENCES "gehege" ("id");

ALTER TABLE "tier" ADD FOREIGN KEY ("tierarzt_id") REFERENCES "personal" ("id");

ALTER TABLE "umsatz" ADD FOREIGN KEY ("stand_id") REFERENCES "verkaufsstand" ("id");

ALTER TABLE "umsatz" ADD FOREIGN KEY ("spende_id") REFERENCES "spende" ("id");

ALTER TABLE "verkaufsstand" ADD FOREIGN KEY ("verkaeufer_id") REFERENCES "personal" ("id");

ALTER TABLE "personal" ADD FOREIGN KEY ("beruf_id") REFERENCES "beruf" ("id");

ALTER TABLE "gehege_personal" ADD FOREIGN KEY ("pfleger_id") REFERENCES "personal" ("id");

ALTER TABLE "gehege_personal" ADD FOREIGN KEY ("gehege_id") REFERENCES "gehege" ("id");


-- Zoo Kontostand & Eintritt
INSERT INTO "zoo" VALUES (50000, 39.99);

-- Berufe
INSERT INTO "beruf" VALUES (DEFAULT, 'Pfleger');
INSERT INTO "beruf" VALUES (DEFAULT, 'Tierarzt');
INSERT INTO "beruf" VALUES (DEFAULT, 'Kassierer');
INSERT INTO "beruf" VALUES (DEFAULT, 'Verkäufer');

-- Personal
INSERT INTO "personal" VALUES (DEFAULT, 2); -- Tierarzt
INSERT INTO "personal" VALUES (DEFAULT, 2); -- Tierarzt
INSERT INTO "personal" VALUES (DEFAULT, 1); -- Tierpfleger
INSERT INTO "personal" VALUES (DEFAULT, 1); -- Tierpfleger
INSERT INTO "personal" VALUES (DEFAULT, 1); -- Tierpfleger
INSERT INTO "personal" VALUES (DEFAULT, 3); -- Kassierer
INSERT INTO "personal" VALUES (DEFAULT, 4); -- Verkäufer
INSERT INTO "personal" VALUES (DEFAULT, 4); -- Verkäufer

-- Gehege
INSERT INTO "gehege" VALUES (DEFAULT, 100, 950, 'Affengehege');
INSERT INTO "gehege" VALUES (DEFAULT, 250, 1500, 'Löwengehege');
INSERT INTO "gehege" VALUES (DEFAULT, 300, 1700, 'Elefantengehege');
INSERT INTO "gehege" VALUES (DEFAULT, 200, 1200, 'Giraffengehege');
INSERT INTO "gehege" VALUES (DEFAULT, 180, 1100, 'Zebra-Gehege');
INSERT INTO "gehege" VALUES (DEFAULT, 90, 800, 'Pinguinbecken');
INSERT INTO "gehege" VALUES (DEFAULT, 70, 600, 'Känguru-Gehege');

-- Gehege-Personal Zuordnung
INSERT INTO "gehege_personal" VALUES (3, 1); -- Tierpfleger für Affen
INSERT INTO "gehege_personal" VALUES (4, 2); -- Tierpfleger für Löwen
INSERT INTO "gehege_personal" VALUES (5, 3); -- Tierpfleger für Elefanten
INSERT INTO "gehege_personal" VALUES (3, 4); -- Tierpfleger für Giraffen
INSERT INTO "gehege_personal" VALUES (4, 5); -- Tierpfleger für Zebras
INSERT INTO "gehege_personal" VALUES (5, 6); -- Tierpfleger für Pinguine
INSERT INTO "gehege_personal" VALUES (3, 7); -- Tierpfleger für Kängurus

-- Tiere
INSERT INTO "tier" VALUES (DEFAULT, 'Bobo der Affe', 1, 1);
INSERT INTO "tier" VALUES (DEFAULT, 'Charlie der Affe', 1, 1);
INSERT INTO "tier" VALUES (DEFAULT, 'Simba der Löwe', 2, 2);
INSERT INTO "tier" VALUES (DEFAULT, 'Nala die Löwin', 2, 2);
INSERT INTO "tier" VALUES (DEFAULT, 'Dumbo der Elefant', 3, 1);
INSERT INTO "tier" VALUES (DEFAULT, 'Elsa die Elefantin', 3, 1);
INSERT INTO "tier" VALUES (DEFAULT, 'Melman die Giraffe', 4, 2);
INSERT INTO "tier" VALUES (DEFAULT, 'Gloria das Zebra', 5, 2);
INSERT INTO "tier" VALUES (DEFAULT, 'Marty das Zebra', 5, 2);
INSERT INTO "tier" VALUES (DEFAULT, 'Pingo der Pinguin', 6, 1);
INSERT INTO "tier" VALUES (DEFAULT, 'Skipper der Pinguin', 6, 1);
INSERT INTO "tier" VALUES (DEFAULT, 'Joey das Känguru', 7, 2);

-- Verkaufsstände
INSERT INTO "verkaufsstand" VALUES (DEFAULT, 'Eis', 7);
INSERT INTO "verkaufsstand" VALUES (DEFAULT, 'Burger', 8);
INSERT INTO "verkaufsstand" VALUES (DEFAULT, 'Infokarte', 7);
INSERT INTO "verkaufsstand" VALUES (DEFAULT, 'Regenschirm', 8);

-- Umsätze
INSERT INTO "umsatz" VALUES (DEFAULT, 2000, '2025-02-01', 1, NULL, TRUE);
INSERT INTO "umsatz" VALUES (DEFAULT, 1500, '2025-02-02', 2, NULL, TRUE);
INSERT INTO "umsatz" VALUES (DEFAULT, 800, '2025-02-02', 3, NULL, FALSE);
INSERT INTO "umsatz" VALUES (DEFAULT, 1200, '2025-02-03', 4, NULL, FALSE);
INSERT INTO "umsatz" VALUES (DEFAULT, 1800, '2025-02-04', 1, NULL, TRUE);
INSERT INTO "umsatz" VALUES (DEFAULT, 1300, '2025-02-05', 2, NULL, FALSE);
INSERT INTO "umsatz" VALUES (DEFAULT, 500, '2025-02-06', 3, NULL, FALSE);

-- Spenden
INSERT INTO "spende" VALUES (DEFAULT, 'Max Mustermann', '2025-02-01', 500, 'beleg1.pdf');
INSERT INTO "spende" VALUES (DEFAULT, 'Lisa Beispiel', '2025-02-02', 300, 'beleg2.pdf');
INSERT INTO "spende" VALUES (DEFAULT, 'Karl Test', '2025-02-03', 750, 'beleg3.pdf');
INSERT INTO "spende" VALUES (DEFAULT, 'Zoe Musterfrau', '2025-02-04', 900, 'beleg4.pdf');
INSERT INTO "spende" VALUES (DEFAULT, 'Ben Experiment', '2025-02-05', 450, 'beleg5.pdf');

