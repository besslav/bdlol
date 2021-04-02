--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 9.5.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS "d.maksukov";
--
-- Name: d.maksukov; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "d.maksukov" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';


ALTER DATABASE "d.maksukov" OWNER TO postgres;

\connect "d.maksukov"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: champ_line; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.champ_line (
    champ_id integer NOT NULL,
    line_id integer NOT NULL
);


ALTER TABLE public.champ_line OWNER TO postgres;

--
-- Name: champ_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.champ_role (
    champ_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.champ_role OWNER TO postgres;

--
-- Name: champions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.champions (
    champ_id integer NOT NULL,
    champions character varying(30) NOT NULL,
    type character varying(2) NOT NULL,
    "1lvl dmg" integer NOT NULL,
    hp integer NOT NULL,
    armor integer NOT NULL,
    "mag rez" integer NOT NULL,
    "attack speed" double precision NOT NULL,
    CONSTRAINT atspeed_chk CHECK ((("attack speed" > (0.5)::double precision) AND ("attack speed" < (1)::double precision))),
    CONSTRAINT damage_1lvl_dmg_chk CHECK ((("1lvl dmg" > 40) AND ("1lvl dmg" < 100))),
    CONSTRAINT survival_armor_chk CHECK (((armor > 40) AND (armor < 100))),
    CONSTRAINT survival_hp_chk CHECK (((hp > 500) AND (hp < 1000))),
    CONSTRAINT survival_mag_rez_chk CHECK ((("mag rez" > 40) AND ("mag rez" < 100)))
);


ALTER TABLE public.champions OWNER TO postgres;

--
-- Name: champions_champ_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.champions_champ_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.champions_champ_id_seq OWNER TO postgres;

--
-- Name: champions_champ_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.champions_champ_id_seq OWNED BY public.champions.champ_id;


--
-- Name: division; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.division (
    id integer NOT NULL,
    div character varying(15) NOT NULL
);


ALTER TABLE public.division OWNER TO postgres;

--
-- Name: division_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.division_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.division_id_seq OWNER TO postgres;

--
-- Name: division_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.division_id_seq OWNED BY public.division.id;


--
-- Name: ingame; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingame (
    ing_id integer NOT NULL,
    div integer NOT NULL,
    champ integer NOT NULL,
    "ban chance" double precision NOT NULL,
    "win rate" double precision NOT NULL,
    "pick chance" double precision NOT NULL,
    CONSTRAINT ingame_ban_chance_chk CHECK ((("ban chance" > (0)::double precision) AND ("ban chance" < (100)::double precision))),
    CONSTRAINT ingame_pick_chance_chk CHECK ((("pick chance" > (0)::double precision) AND ("pick chance" < (100)::double precision))),
    CONSTRAINT ingame_win_rate_chk CHECK ((("win rate" > (0)::double precision) AND ("win rate" < (100)::double precision)))
);


ALTER TABLE public.ingame OWNER TO postgres;

--
-- Name: ingame_ing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ingame_ing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingame_ing_id_seq OWNER TO postgres;

--
-- Name: ingame_ing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ingame_ing_id_seq OWNED BY public.ingame.ing_id;


--
-- Name: lines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lines (
    line_id integer NOT NULL,
    line character varying(10) NOT NULL
);


ALTER TABLE public.lines OWNER TO postgres;

--
-- Name: lines_line_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lines_line_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lines_line_id_seq OWNER TO postgres;

--
-- Name: lines_line_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lines_line_id_seq OWNED BY public.lines.line_id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    player_id integer NOT NULL,
    player character varying(20) NOT NULL,
    region integer NOT NULL,
    team integer NOT NULL,
    birth_date date,
    favorite_champ integer NOT NULL,
    CONSTRAINT "birth day chk" CHECK (((birth_date > '1970-01-01'::date) AND (birth_date < '2018-12-19'::date)))
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: players_player_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.players_player_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_player_id_seq OWNER TO postgres;

--
-- Name: players_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.players_player_id_seq OWNED BY public.players.player_id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regions (
    region_id integer NOT NULL,
    region character varying(20) NOT NULL
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- Name: regions_region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regions_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regions_region_id_seq OWNER TO postgres;

--
-- Name: regions_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regions_region_id_seq OWNED BY public.regions.region_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role character varying(15) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_role_id_seq OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    team character varying(20) NOT NULL
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teams_team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO postgres;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: champ_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.champions ALTER COLUMN champ_id SET DEFAULT nextval('public.champions_champ_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division ALTER COLUMN id SET DEFAULT nextval('public.division_id_seq'::regclass);


--
-- Name: ing_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingame ALTER COLUMN ing_id SET DEFAULT nextval('public.ingame_ing_id_seq'::regclass);


--
-- Name: line_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lines ALTER COLUMN line_id SET DEFAULT nextval('public.lines_line_id_seq'::regclass);


--
-- Name: player_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players ALTER COLUMN player_id SET DEFAULT nextval('public.players_player_id_seq'::regclass);


--
-- Name: region_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions ALTER COLUMN region_id SET DEFAULT nextval('public.regions_region_id_seq'::regclass);


--
-- Name: role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: team_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Data for Name: champ_line; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.champ_line (champ_id, line_id) FROM stdin;
1	1
9	5
3	1
5	3
4	2
6	2
8	3
7	4
2	5
10	2
11	1
15	3
12	3
13	3
14	2
1	2
2	4
11	5
5	1
12	1
5	6
6	7
7	8
8	9
9	6
1	7
2	8
11	9
\.


--
-- Data for Name: champ_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.champ_role (champ_id, role_id) FROM stdin;
1	1
9	5
3	1
5	6
4	2
6	2
8	3
7	6
2	5
10	2
11	1
12	3
13	3
14	2
15	4
1	2
2	4
11	5
5	5
12	1
11	7
7	8
8	9
1	7
12	8
5	9
\.


--
-- Data for Name: champions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.champions (champ_id, champions, type, "1lvl dmg", hp, armor, "mag rez", "attack speed") FROM stdin;
1	aatrox	ad	91	666	66	66	0.66000000000000003
2	ahri	ap	70	572	52	78	0.94999999999999996
3	dr.mundo	ad	78	834	90	72	0.64000000000000001
4	draven	ad	85	643	64	74	0.85999999999999999
5	fiora	ad	82	715	87	93	0.88
6	akali	ap	73	625	57	81	0.98999999999999999
7	sona	ap	65	537	83	66	0.82999999999999996
8	hecarim	ad	75	804	62	63	0.75
9	fizz	ap	74	746	94	72	0.67000000000000004
10	nautilus	ad	69	819	75	57	0.65000000000000002
11	twitch	ad	86	682	86	62	0.93999999999999995
12	brand	ap	67	698	72	72	0.82999999999999996
13	olaf	ad	82	782	96	51	0.70999999999999996
14	teemo	ap	61	614	55	56	0.64000000000000001
15	irelia	ad	90	759	72	83	0.85999999999999999
\.


--
-- Name: champions_champ_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.champions_champ_id_seq', 15, true);


--
-- Data for Name: division; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.division (id, div) FROM stdin;
1	diamond
2	platinum
3	gold
4	silver
5	bronze
\.


--
-- Name: division_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.division_id_seq', 5, true);


--
-- Data for Name: ingame; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingame (ing_id, div, champ, "ban chance", "win rate", "pick chance") FROM stdin;
1	1	1	0.10000000000000001	49.189999999999998	0.20000000000000001
2	1	2	6.2000000000000002	50.229999999999997	2.5
3	1	3	0.59999999999999998	49.420000000000002	0.69999999999999996
4	1	4	24.199999999999999	52.009999999999998	2.2999999999999998
5	1	5	26.399999999999999	51.189999999999998	1.8999999999999999
6	1	6	7.2999999999999998	50.810000000000002	1.2
7	1	7	3.2999999999999998	54.780000000000001	3.1000000000000001
8	1	8	3.1000000000000001	50.109999999999999	1
9	1	9	21.100000000000001	49.990000000000002	2.1000000000000001
10	1	10	0.40000000000000002	46.189999999999998	0.59999999999999998
11	1	11	33.5	53.100000000000001	5.0999999999999996
12	1	12	5.5	51.439999999999998	2.0099999999999998
13	1	13	1.2	44.789999999999999	0.59999999999999998
14	1	14	8.1999999999999993	51.009999999999998	2.2000000000000002
15	1	15	2.1000000000000001	51.219999999999999	1.3
16	2	1	0.20000000000000001	49.289999999999999	0.19
17	2	2	6.5999999999999996	50.399999999999999	2.7000000000000002
18	2	3	0.59999999999999998	49.270000000000003	0.90000000000000002
19	2	4	26.100000000000001	51.969999999999999	2.3999999999999999
20	2	5	27	51.229999999999997	2
21	2	6	8.0999999999999996	50.850000000000001	1.1000000000000001
22	2	7	3.3999999999999999	54.600000000000001	3.3999999999999999
23	2	8	3.2999999999999998	50.259999999999998	1.2
24	2	9	22.199999999999999	50.299999999999997	2.3999999999999999
25	2	10	0.5	46.340000000000003	0.69999999999999996
26	2	11	35	52.200000000000003	5.2999999999999998
27	2	12	5.5999999999999996	51.549999999999997	1.8999999999999999
28	2	13	1	44.670000000000002	0.80000000000000004
29	2	14	8.9000000000000004	51.240000000000002	2.5
30	2	15	2.2000000000000002	51.399999999999999	1.3999999999999999
31	3	1	0.29999999999999999	49.659999999999997	1.8
32	3	2	6.9000000000000004	51	2.8999999999999999
33	3	3	0.59999999999999998	49.170000000000002	1
34	3	4	26.300000000000001	52.100000000000001	2.5
35	3	5	27.300000000000001	51.340000000000003	1.8
36	3	6	8.4000000000000004	50.880000000000003	1.2
37	3	7	3.5	54.710000000000001	3.2000000000000002
38	3	8	3.2000000000000002	50.299999999999997	1.3
39	3	9	22	50.600000000000001	2.6000000000000001
40	3	10	0.59999999999999998	47	0.59999999999999998
41	3	11	34.100000000000001	51.899999999999999	5.2000000000000002
42	3	12	5.7000000000000002	51.469999999999999	1.7
43	3	13	0.90000000000000002	44.799999999999997	0.90000000000000002
44	3	14	9	51.299999999999997	2.6000000000000001
45	3	15	2.2999999999999998	51	1.5
46	4	1	0.40000000000000002	48.189999999999998	0.20000000000000001
47	4	2	6.0999999999999996	51.229999999999997	2.5
48	4	3	0.69999999999999996	48.420000000000002	0.69999999999999996
49	4	4	25.199999999999999	53.009999999999998	2.2999999999999998
50	4	5	27.399999999999999	50.189999999999998	1.7
51	4	6	7.5999999999999996	51.810000000000002	1.3
52	4	7	3.5	53.780000000000001	3.1000000000000001
53	4	8	3.1000000000000001	50.100000000000001	1.1000000000000001
54	4	9	20.100000000000001	48.899999999999999	2.1000000000000001
55	4	10	0.69999999999999996	47.189999999999998	0.59999999999999998
56	4	11	31.5	54.100000000000001	5.0999999999999996
57	4	12	5.7000000000000002	53.469999999999999	1.8
58	4	13	1.3	43.899999999999999	0.29999999999999999
59	4	14	8.1999999999999993	52.009999999999998	2
60	4	15	2.1000000000000001	52.219999999999999	1.3
61	5	1	0.5	49.460000000000001	1.8
62	5	2	6.7999999999999998	51.32	2.6000000000000001
63	5	3	0.69999999999999996	46.170000000000002	1.5
64	5	4	27.300000000000001	51.100000000000001	2.3999999999999999
65	5	5	27.899999999999999	51.140000000000001	1.7
66	5	6	8.5	50.68	1.2
67	5	7	3.1000000000000001	51.710000000000001	3.5
68	5	8	3.3399999999999999	52.299999999999997	1.3
69	5	9	22.300000000000001	53.600000000000001	2.6000000000000001
70	5	10	0.69999999999999996	47.600000000000001	0.59999999999999998
71	5	11	35.100000000000001	50.899999999999999	5.2000000000000002
72	5	12	5.7999999999999998	51.700000000000003	1.7
73	5	13	0.80000000000000004	44.200000000000003	0.90000000000000002
74	5	14	9.0999999999999996	51.600000000000001	2.6000000000000001
75	5	15	2.5	51.299999999999997	1.5
\.


--
-- Name: ingame_ing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ingame_ing_id_seq', 75, true);


--
-- Data for Name: lines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lines (line_id, line) FROM stdin;
1	top
2	mid
3	jungle
4	adc
5	supp
6	allrand
7	everywhere
8	base
9	enemy
\.


--
-- Name: lines_line_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lines_line_id_seq', 9, true);


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players (player_id, player, region, team, birth_date, favorite_champ) FROM stdin;
1	belka	1	1	1998-05-01	3
2	farik	2	14	1988-11-01	5
3	Kuro	3	5	1987-01-04	10
4	Loli	4	10	1986-01-11	1
5	Spirit	5	15	1998-06-11	13
6	TusiN	6	5	1987-01-02	7
7	Betty	7	2	1996-03-01	4
8	Slon	8	8	1989-04-01	9
9	Herri0n	9	11	1978-05-01	13
10	Maple	1	4	1979-06-01	5
11	Blaber	2	6	1988-07-01	7
12	Licorise	3	2	1973-08-01	3
13	Duke	4	10	1976-01-12	4
14	Ning	5	6	1984-07-01	11
15	Baolan	6	6	1985-06-01	6
16	Rookie	7	3	1986-08-03	2
17	TheShy	8	7	1991-05-09	14
18	Wunder	9	9	1992-07-08	1
19	Perkz	6	12	1993-05-07	12
20	Besslav	3	13	1994-03-07	14
\.


--
-- Name: players_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.players_player_id_seq', 20, true);


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regions (region_id, region) FROM stdin;
1	Russia
2	S.Korea
3	U.S.A.
4	Japan
5	Canada
6	australia
7	Germany
8	France
9	Great Britain
\.


--
-- Name: regions_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regions_region_id_seq', 9, true);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (role_id, role) FROM stdin;
1	assassin
2	fighter
3	mage
4	adc
5	supp
6	tank
7	fidder
8	afkplay
9	ryiner
\.


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 9, true);


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teams (team_id, team) FROM stdin;
1	skt t1
2	brb
3	sumsung
4	Fnatic
5	Cloud9
6	G2
7	G-REX
8	Infinity Esports
9	100 Thieves
10	Flash Wolves
11	Afreeca Freecs
12	MAD Team
13	Team Vitality
14	Gen.G
15	improvisation
\.


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 15, true);


--
-- Name: champ_line_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.champ_line
    ADD CONSTRAINT champ_line_pkey PRIMARY KEY (champ_id, line_id);


--
-- Name: champ_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.champ_role
    ADD CONSTRAINT champ_role_pkey PRIMARY KEY (champ_id, role_id);


--
-- Name: champions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.champions
    ADD CONSTRAINT champions_pkey PRIMARY KEY (champ_id);


--
-- Name: division_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.division
    ADD CONSTRAINT division_pk PRIMARY KEY (id);


--
-- Name: ingame_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingame
    ADD CONSTRAINT ingame_pkey PRIMARY KEY (ing_id);


--
-- Name: lines_line_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_line_key UNIQUE (line);


--
-- Name: lines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_pkey PRIMARY KEY (line_id);


--
-- Name: players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player_id);


--
-- Name: players_player_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_player_key UNIQUE (player);


--
-- Name: regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (region_id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: roles_role_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_key UNIQUE (role);


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: teams_team_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_team_key UNIQUE (team);


--
-- Name: champ_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX champ_ind ON public.ingame USING btree (champ);


--
-- Name: champions_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX champions_ind ON public.champions USING btree (champions);


--
-- Name: div_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX div_ind ON public.ingame USING btree (div);


--
-- Name: dmg_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dmg_ind ON public.champions USING btree ("1lvl dmg");


--
-- Name: favorite_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX favorite_ind ON public.players USING btree (favorite_champ);


--
-- Name: line_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX line_ind ON public.lines USING btree (line);


--
-- Name: player_region_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_region_ind ON public.players USING btree (region);


--
-- Name: real div_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "real div_ind" ON public.division USING btree (div);


--
-- Name: region_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX region_ind ON public.regions USING btree (region);


--
-- Name: role_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX role_ind ON public.roles USING btree (role);


--
-- Name: team_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX team_ind ON public.teams USING btree (team);


--
-- Name: type_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX type_ind ON public.champions USING btree (type);


--
-- Name: win_rate_ind; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX win_rate_ind ON public.ingame USING btree ("win rate");


--
-- Name: champ_line_champ_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.champ_line
    ADD CONSTRAINT champ_line_champ_id_fkey FOREIGN KEY (champ_id) REFERENCES public.champions(champ_id);


--
-- Name: champ_line_line_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.champ_line
    ADD CONSTRAINT champ_line_line_id_fkey FOREIGN KEY (line_id) REFERENCES public.lines(line_id);


--
-- Name: champ_role_champ_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.champ_role
    ADD CONSTRAINT champ_role_champ_id_fkey FOREIGN KEY (champ_id) REFERENCES public.champions(champ_id);


--
-- Name: champ_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.champ_role
    ADD CONSTRAINT champ_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- Name: ingame_champ_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingame
    ADD CONSTRAINT ingame_champ_fkey FOREIGN KEY (champ) REFERENCES public.champions(champ_id);


--
-- Name: ingame_div_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingame
    ADD CONSTRAINT ingame_div_fkey FOREIGN KEY (div) REFERENCES public.division(id);


--
-- Name: players_favorite_champ_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_favorite_champ_fkey FOREIGN KEY (favorite_champ) REFERENCES public.champions(champ_id);


--
-- Name: players_region_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_region_fkey FOREIGN KEY (region) REFERENCES public.regions(region_id);


--
-- Name: players_team_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_team_fkey FOREIGN KEY (team) REFERENCES public.teams(team_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

