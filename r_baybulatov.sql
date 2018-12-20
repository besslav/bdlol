--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS "r.baybulatov";
--
-- Name: r.baybulatov; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "r.baybulatov" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';


ALTER DATABASE "r.baybulatov" OWNER TO postgres;

\connect "r.baybulatov"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: auctions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auctions (
    id integer NOT NULL,
    number_of_the_auction_order character varying(20),
    number_of_bidders integer NOT NULL,
    number_of_lots integer NOT NULL,
    profit integer,
    CONSTRAINT number_of_bidders_check CHECK ((number_of_bidders >= 0)),
    CONSTRAINT number_of_lots_check CHECK ((number_of_lots > 0)),
    CONSTRAINT profit_check CHECK ((profit >= 0))
);


ALTER TABLE public.auctions OWNER TO postgres;

--
-- Name: auctions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auctions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auctions_id_seq OWNER TO postgres;

--
-- Name: auctions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auctions_id_seq OWNED BY public.auctions.id;


--
-- Name: buyers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buyers (
    id integer NOT NULL,
    first_name character varying(80) NOT NULL,
    last_name character varying(80) NOT NULL,
    patronymic character varying(80),
    citizenship character varying(160),
    CONSTRAINT first_name_check CHECK (((first_name)::text <> ''::text)),
    CONSTRAINT last_name_name_check CHECK (((last_name)::text <> ''::text))
);


ALTER TABLE public.buyers OWNER TO postgres;

--
-- Name: buyers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.buyers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buyers_id_seq OWNER TO postgres;

--
-- Name: buyers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.buyers_id_seq OWNED BY public.buyers.id;


--
-- Name: contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contracts (
    id integer NOT NULL,
    contract_number character varying(20),
    id_forest_type integer NOT NULL,
    id_purpose integer NOT NULL,
    id_buyer integer NOT NULL,
    volume integer,
    CONSTRAINT contract_number_check CHECK (((contract_number)::text <> ''::text))
);


ALTER TABLE public.contracts OWNER TO postgres;

--
-- Name: contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contracts_id_seq OWNER TO postgres;

--
-- Name: contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contracts_id_seq OWNED BY public.contracts.id;


--
-- Name: forest_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forest_type (
    id integer NOT NULL,
    forest_type character varying(20) NOT NULL,
    class character varying(20) NOT NULL,
    wood_reserve integer,
    for_sale integer,
    sanitary_logging integer,
    reforestation integer,
    CONSTRAINT for_sale_max_check CHECK ((for_sale < wood_reserve)),
    CONSTRAINT for_sale_min_check CHECK ((for_sale >= 0)),
    CONSTRAINT sanitary_logging_max_check CHECK ((sanitary_logging < wood_reserve)),
    CONSTRAINT sanitary_logging_min_check CHECK ((sanitary_logging >= 0))
);


ALTER TABLE public.forest_type OWNER TO postgres;

--
-- Name: forest_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forest_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forest_type_id_seq OWNER TO postgres;

--
-- Name: forest_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forest_type_id_seq OWNED BY public.forest_type.id;


--
-- Name: purpose_buying; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purpose_buying (
    id integer NOT NULL,
    purpose character varying(80) NOT NULL
);


ALTER TABLE public.purpose_buying OWNER TO postgres;

--
-- Name: purpose_buying_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purpose_buying_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purpose_buying_id_seq OWNER TO postgres;

--
-- Name: purpose_buying_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purpose_buying_id_seq OWNED BY public.purpose_buying.id;


--
-- Name: table_connector; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.table_connector (
    id_buyer integer NOT NULL,
    id_auctions integer NOT NULL
);


ALTER TABLE public.table_connector OWNER TO postgres;

--
-- Name: auctions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auctions ALTER COLUMN id SET DEFAULT nextval('public.auctions_id_seq'::regclass);


--
-- Name: buyers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buyers ALTER COLUMN id SET DEFAULT nextval('public.buyers_id_seq'::regclass);


--
-- Name: contracts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts ALTER COLUMN id SET DEFAULT nextval('public.contracts_id_seq'::regclass);


--
-- Name: forest_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forest_type ALTER COLUMN id SET DEFAULT nextval('public.forest_type_id_seq'::regclass);


--
-- Name: purpose_buying id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purpose_buying ALTER COLUMN id SET DEFAULT nextval('public.purpose_buying_id_seq'::regclass);


--
-- Data for Name: auctions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auctions (id, number_of_the_auction_order, number_of_bidders, number_of_lots, profit) FROM stdin;
1	2941-42	6	3	863000
2	2941-83	7	8	764750
3	9643-83	3	9	728500
4	9930-84	8	3	958500
5	5519-36	11	2	1060000
6	9164-86	0	3	0
7	1582-57	3	5	245000
8	7053-54	6	8	624500
9	7011-09	2	8	282000
10	2185-11	4	1	324000
11	5121-49	4	4	420000
12	9718-14	7	6	532500
13	9151-11	7	4	530000
14	4313-21	7	2	315500
15	4501-12	6	3	305000
\.


--
-- Data for Name: buyers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buyers (id, first_name, last_name, patronymic, citizenship) FROM stdin;
1	Ilya	Strelkov	Olegovich	Russia Federation
2	Alexandr	Koshelev	Antonovich	Russia Federation
3	Alexandr	Novikov	Antonovich	Russia Federation
4	Za	Mo	Chy	China
5	Fedor	Davidov	Alexandrovich	Russia Federation
6	Igor	Abraamov	Maximovich	Russia Federation
7	Eduard	Krykov	Sergeevich	Russia Federation
8	Ivan	Kenobaev	\N	Russia Federation
9	Chiang	Kaishek	\N	China
10	Kirill	Fedotov	Gennadevich	Russia Federation
11	Rostislav	Smirnov	Vladislavovich	Russia Federation
12	Alexandr	Veselov	Stepanovich	Russia Federation
13	Vadim	Teterin	\N	Russia Federation
14	Van	Tadashi	\N	Vietnam
15	Polina	Ustinova	Victorovna	Russia Federation
\.


--
-- Data for Name: contracts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contracts (id, contract_number, id_forest_type, id_purpose, id_buyer, volume) FROM stdin;
1	634-7354	1	1	1	9987
2	634-7353	1	9	1	519
3	7362-026	5	3	2	16194
4	4762-666	3	1	2	12836
5	2362-687	8	8	2	18128
6	357-325	10	5	3	5418
7	303-127	1	1	4	8384
8	200-638	8	1	5	5876
9	6457-221	1	1	6	19910
10	910-2424	6	3	7	4705
11	981-111	2	1	8	6385
12	452-195	3	9	9	10151
13	390-9184	10	6	10	8546
15	8376-482	4	4	11	11799
16	917-173	7	2	12	13253
17	892-643	2	7	13	16324
18	746-275	9	6	14	9910
19	225-625	3	2	15	17286
14	390-9185	8	1	10	11398
20	225-626	3	4	15	9861
\.


--
-- Data for Name: forest_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forest_type (id, forest_type, class, wood_reserve, for_sale, sanitary_logging, reforestation) FROM stdin;
1	birch	small-leaved	1960405	87041	23521	101549
2	aspen	small-leaved	1401892	114113	10747	82992
3	alder	small-leaved	279054	28910	3195	33040
4	poplar	small-leaved	37972	4215	443	5058
5	linden	broad-leaved	1371891	71064	20608	91368
6	oak	broad-leaved	965945	42888	18592	78628
7	maple	broad-leaved	465810	24129	3894	58599
9	larch	conifer	164120	161200	14800	99200
8	pine	conifer	288600	288500	4655	461600
10	fir	conifer	221621	182400	16480	194560
\.


--
-- Data for Name: purpose_buying; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purpose_buying (id, purpose) FROM stdin;
1	wood harvesting
2	collection of medicinal plants
3	farming
4	implementation of research activities
5	implementation of recreational activities
6	establishment and operation of forest plantations
7	development of mineral deposits
8	implementation of activities in the field of hunting
9	wood processing
\.


--
-- Data for Name: table_connector; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.table_connector (id_buyer, id_auctions) FROM stdin;
1	2
2	13
3	5
4	2
4	10
4	4
5	2
7	10
8	5
8	12
9	8
10	15
11	1
12	8
13	13
14	13
14	10
15	10
7	4
11	3
\.


--
-- Name: auctions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auctions_id_seq', 1, false);


--
-- Name: buyers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buyers_id_seq', 1, false);


--
-- Name: contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contracts_id_seq', 1, false);


--
-- Name: forest_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forest_type_id_seq', 1, false);


--
-- Name: purpose_buying_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purpose_buying_id_seq', 1, false);


--
-- Name: auctions auctions_number_of_the_auction_order_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auctions
    ADD CONSTRAINT auctions_number_of_the_auction_order_key UNIQUE (number_of_the_auction_order);


--
-- Name: auctions auctions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auctions
    ADD CONSTRAINT auctions_pkey PRIMARY KEY (id);


--
-- Name: buyers buyers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buyers
    ADD CONSTRAINT buyers_pkey PRIMARY KEY (id);


--
-- Name: contracts contracts_contract_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_contract_number_key UNIQUE (contract_number);


--
-- Name: contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (id);


--
-- Name: forest_type forest_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forest_type
    ADD CONSTRAINT forest_type_pkey PRIMARY KEY (id);


--
-- Name: forest_type forest_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forest_type
    ADD CONSTRAINT forest_unique UNIQUE (forest_type);


--
-- Name: purpose_buying purpose_buying_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purpose_buying
    ADD CONSTRAINT purpose_buying_pkey PRIMARY KEY (id);


--
-- Name: purpose_buying purpose_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purpose_buying
    ADD CONSTRAINT purpose_unique UNIQUE (purpose);


--
-- Name: table_connector table_connector_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.table_connector
    ADD CONSTRAINT table_connector_pkey PRIMARY KEY (id_buyer, id_auctions);


--
-- Name: auction_order_number_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auction_order_number_index ON public.auctions USING btree (number_of_the_auction_order);


--
-- Name: auctions_profit_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auctions_profit_idx ON public.auctions USING btree (profit DESC NULLS LAST);


--
-- Name: buyer_firsname_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX buyer_firsname_idx ON public.buyers USING btree (lower((first_name)::text));


--
-- Name: buyers_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX buyers_index ON public.buyers USING btree (id);


--
-- Name: contract_number_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX contract_number_index ON public.contracts USING btree (contract_number);


--
-- Name: contracts_privilege; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX contracts_privilege ON public.contracts USING btree (id_purpose, id_forest_type) WHERE (((id_purpose = 2) OR (id_purpose = 3) OR (id_purpose = 5) OR (id_purpose = 6)) AND ((id_forest_type = 1) OR (id_forest_type = 2) OR (id_forest_type = 5) OR (id_forest_type = 7) OR (id_forest_type = 8)));


--
-- Name: forest_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forest_type_idx ON public.forest_type USING btree (wood_reserve);


--
-- Name: forest_type_join_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forest_type_join_index ON public.forest_type USING btree (wood_reserve);


--
-- Name: purpose_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX purpose_index ON public.purpose_buying USING btree (purpose);


--
-- Name: tc_id_buyer_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tc_id_buyer_index ON public.table_connector USING btree (id_buyer);


--
-- Name: contracts id_buyer_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT id_buyer_fk FOREIGN KEY (id_buyer) REFERENCES public.buyers(id);


--
-- Name: contracts id_forest_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT id_forest_type_fk FOREIGN KEY (id_forest_type) REFERENCES public.forest_type(id);


--
-- Name: contracts id_purpose_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT id_purpose_fk FOREIGN KEY (id_purpose) REFERENCES public.purpose_buying(id);


--
-- Name: table_connector id_tc_auctions_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.table_connector
    ADD CONSTRAINT id_tc_auctions_fk FOREIGN KEY (id_auctions) REFERENCES public.auctions(id);


--
-- Name: table_connector id_tc_buyer_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.table_connector
    ADD CONSTRAINT id_tc_buyer_fk FOREIGN KEY (id_buyer) REFERENCES public.buyers(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

