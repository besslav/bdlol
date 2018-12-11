CREATE TABLE "lines" (
	"line_id" serial PRIMARY KEY,
	"line" VARCHAR(30) NOT NULL UNIQUE
) WITH (
  OIDS=FALSE
);



CREATE TABLE "roles" (
	"role_id" serial PRIMARY KEY ,
	"role" VARCHAR(30) NOT NULL UNIQUE
	
) WITH (
  OIDS=FALSE
);

CREATE TABLE "champions" (
	"champ_id" serial primary key,
	"champions" VARCHAR(40) NOT NULL UNIQUE,
	"type" VARCHAR(3) NOT NULL,
	"1lvl dmg" int NOT NULL	CONSTRAINT damage_1lvl_dmg_chk CHECK ("1lvl dmg" > 0),
	"hp"   int NOT NULL	CONSTRAINT survival_hp_chk CHECK ("hp" > 0),
	"armor" int NOT NULL	CONSTRAINT survival_armor_chk     CHECK ("armor" > 0),
	"mag rez" int NOT NULL CONSTRAINT survival_mag_rez_chk  CHECK ("mag rez" > 0)
) WITH (
  OIDS=FALSE
);

CREATE TABLE "regions" (
	"region_id" serial PRIMARY KEY ,
	"region" VARCHAR(30) NOT NULL UNIQUE
) WITH (
  OIDS=FALSE
);

CREATE TABLE "teams" (
	"team_id" serial PRIMARY KEY ,
	"team" VARCHAR(30) NOT NULL UNIQUE
	
) WITH (
  OIDS=FALSE
);


CREATE TABLE "players" (
	"player_id" serial primary key,
	"player" VARCHAR(40) NOT NULL UNIQUE,
	"region" int NOT NULL REFERENCES "regions"("region_id"),
    "team" int NOT NULL REFERENCES "teams"("team_id"),
    "favorite_champ" int NOT NULL REFERENCES "champions"("champ_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "division" (
	"id" serial NOT NULL ,
	"div" VARCHAR(20) NOT NULL UNIQUE,
	CONSTRAINT division_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "ingame" (
  
	"div" int NOT NULL	REFERENCES "division"("id"),
	"champ" int NOT NULL	REFERENCES "champions"("champ_id"),
	"ban chance" float NOT NULL	CONSTRAINT ingame_ban_chance_chk CHECK ("ban chance" > 0),
	"win rate" float NOT NULL	CONSTRAINT ingame_win_rate_chk CHECK ("win rate" > 0),
	"pick chance" float NOT NULL	CONSTRAINT ingame_pick_chance_chk CHECK ("pick chance" > 0)   
) WITH (
  OIDS=FALSE
);


CREATE TABLE "champ_role" (
	"champ_id" int   REFERENCES "champions",
	"role_id" int  REFERENCES "roles",
     PRIMARY KEY ("champ_id","role_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "champ_line" (
	"champ_id" int   REFERENCES "champions",
	"line_id" int  REFERENCES "lines",
     PRIMARY KEY ("champ_id","line_id")
) WITH (
  OIDS=FALSE
);


INSERT INTO "roles" ("role") VALUES 
	

('assassin'),
('fighter'),
('mage'),
('adc'),
('supp'),
('tank')
;



INSERT INTO "lines" ("line") VALUES 
('top'),
('mid'),
('jungle'),
('adc'),
('supp')
;






INSERT INTO "champions" ("champions","type","1lvl dmg","hp","armor","mag rez") VALUES 
('aatrox',    'ad',91,  666,	66,	66),
('ahri',      'ap',70,  572,	52,	78),
('dr.mundo',  'ad',78,  834,	90,	72),
('draven',    'ad',85,  643,	64,	74),
('fiora',     'ad',82,  715,	87,	93),
('akali',     'ap',73,  625,	57,	81),
('sona',      'ap',65,  537,	83,	66),
('hecarim',   'ad',75,  804,	62,	63),
('fizz',      'ap',74,  746,	94,	72),
('nautilus',  'ad',69,  819,	75,	57),
('twitch',    'ad',86,  682,	86,	62),
('brand',     'ap',67,  698,	72,	72),
('olaf',      'ad',82,  782,	96,	51),
('teemo',     'ap',61,  614,	55,	56),
('irelia',    'ad',90,  759,	72,	83)
;


INSERT INTO "champ_role" ("champ_id","role_id") VALUES
(1,1),
(9,5),
(3,1),
(5,6),
(4,2),
(6,2),
(8,3),
(7,6),
(2,5),
(10,2),
(11,1),
(12,3),
(13,3),
(14,2),
(15,4),
(1,2),
(2,4),
(11,5),
(5,5),
(12,1)
;

INSERT INTO "champ_line" ("champ_id","line_id") VALUES
(1,1),
(9,5),
(3,1),
(5,3),
(4,2),
(6,2),
(8,3),
(7,4),
(2,5),
(10,2),
(11,1),
(15,3),
(12,3),
(13,3),
(14,2),
(1,2),
(2,4),
(11,5),
(5,1),
(12,1)
;

INSERT INTO "regions" ("region") VALUES
('Russia'),
('Europe'),
('N.America'),
('asia'),
('S.America'),
('australia')
;
INSERT INTO "teams" ("team") VALUES
('skt t1'),
('brb'),
('sumsung'),
('Fnatic'),
('Cloud9'),
('G2'),
('G-REX'),
('Infinity Esports'),
('100 Thieves'),
('Flash Wolves'),
('Afreeca Freecs'),
('MAD Team'),
('Team Vitality'),
('Gen.G'),
('improvisation')
;


INSERT INTO "players" ("player","region","team","favorite_champ") VALUES
('belka',1,1,3),
('farik',2,14,5),
('Kuro',3,5,10),
('Loli',4,10,1),
('Spirit',5,15,13),
('TusiN',6,5,7),
('Betty',4,2,4),
('Slon',1,8,9),
('Herri0n',5,11,13),
('Maple',3,4,5),
('Blaber',5,6,7),
('Licorise',1,2,3),
('Duke',2,10,4),
('Ning',5,6,11),
('Baolan',6,6,6),
('Rookie',2,3,2),
('TheShy',3,7,14),
('Wunder',4,9,1),
('Perkz',6,12,12),
('Besslav',3,13,14)
;



INSERT INTO "division" ("div") VALUES 

('diamond'),
('platinum'),
('gold'),
('silver'),
('bronze')
;



	

INSERT INTO "ingame" ("div","champ","ban chance","win rate","pick chance") VALUES 



(1,	1,	0.1,		49.19,	0.2),
(1,	2,	6.2,		50.23	,	2.5),
(1,	3,	0.6,		49.42	,	0.7),
(1,	4,	24.2,		52.01	,	2.3),
(1,	5,	26.4,		51.19	,	1.9),
(1,	6,	7.3,		50.81	,	1.2),
(1,	7,	3.3,		54.78	,	3.1),
(1,	8,	3.1,		50.11	,	1.0),
(1,	9,	21.1,		49.99	,	2.1),
(1,	10,	0.4,		46.19	,	0.6),
(1,	11,	33.5,		53.10	,	5.1),
(1,	12,	5.5,		51.44	,	2.01),
(1,	13,	1.2,		44.79	,	0.6),
(1,	14,	8.2,		51.01	,	2.2),
(1,	15,	2.1,		51.22	,	1.3),
(2,	1,	0.2,		49.29	,	0.19),
(2,	2,	6.6,		50.4	,	2.7),
(2,	3,	0.6,		49.27,	0.9),
(2,	4,	26.1,		51.97,	2.4),
(2,	5,	27,		51.23	,	2  ),
(2,	6,	8.1,		50.85	,	1.1),
(2,	7,	3.4,		54.60	,	3.4),
(2,	8,	3.3,		50.26	,	1.2),
(2,	9,	22.2,		50.3	,	2.4),
(2,	10,	0.5,		46.34	,	0.7),
(2,	11,	35,		52.2	,	5.3),
(2,	12,	5.6,		51.55	,	1.9),
(2,	13,	1,		44.67	,	0.8),
(2,	14,	8.9,		51.24	,	2.5),
(2,	15,	2.2,		51.4	,	1.4),
(3,	1,	0.3,		49.66	,	1.8),
(3,	2,	6.9,		51	,	2.9),
(3,	3,	0.6,		49.17	,	1  ),
(3,	4,	26.3,		52.10	,	2.5),
(3,	5,	27.3,		51.34	,	1.8),
(3,	6,	8.4,		50.88	,	1.2),
(3,	7,	3.5,		54.71	,	3.2),		
(3,	8,	3.2,		50.3	,	1.3),
(3,	9,	22,		50.6	,	2.6),
(3,	10,	0.6,		47	,	0.6),
(3,	11,	34.1,		51.9	,	5.2),
(3,	12,	5.7,		51.47	,	1.7),
(3,	13,	0.9,		44.8	,	0.9),
(3,	14,	9,		51.3	,	2.6),
(3,	15,	2.3,		51	,	1.5),
(4,	1,	0.4,		48.19	,	0.2),
(4,	2,	6.1,		51.23	,	2.5),
(4,	3,	0.7,		48.42	,	0.7),
(4,	4,	25.2,		53.01	,	2.3),
(4,	5,	27.4,		50.19	,	1.7),
(4,	6,	7.6,		51.81	,	1.3),
(4,	7,	3.5,		53.78	,	3.1),
(4,	8,	3.1,		50.1	,	1.1),
(4,	9,	20.1,		48.9	,	2.1),
(4,	10,	0.7,		47.19	,	0.6),
(4,	11,	31.5,		54.10	,	5.1),
(4,	12,	5.7,		53.47	,	1.8),
(4,	13,	1.3,		43.9	,	0.3),
(4,	14,	8.2,		52.01	,	2  ),
(4,	15,	2.1,		52.22	,	1.3),	
(5,	1,	0.5,		49.46	,	1.8),
(5,	2,	6.8,		51.32	,	2.6),
(5,	3,	0.7,		46.17	,	1.5),
(5,	4,	27.3,		51.10	,	2.4),
(5,	5,	27.9,		51.14	,	1.7),
(5,	6,	8.5,		50.68	,	1.2),
(5,	7,	3.1,		51.71	,	3.5),		
(5,	8,	3.34,		52.3	,	1.3),
(5,	9,	22.3,		53.6	,	2.6),
(5,	10,	0.7,		47.6	,	0.6),
(5,	11,	35.1,		50.9	,	5.2),
(5,	12,	5.8,		51.7	,	1.7),
(5,	13,	0.8,		44.2	,	0.9),
(5,	14,	9.1,		51.6	,	2.6),
(5,	15,	2.5,		51.3	,	1.5)	
;