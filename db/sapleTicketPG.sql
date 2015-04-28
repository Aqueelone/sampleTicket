--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.1
-- Dumped by pg_dump version 9.4.1
-- Started on 2015-04-28 15:17:41 EEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2074 (class 1262 OID 12145)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'uk_UA.UTF-8' LC_CTYPE = 'uk_UA.UTF-8';


\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2075 (class 1262 OID 12145)
-- Dependencies: 2074
-- Name: postgres; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 181 (class 3079 OID 11865)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2077 (class 0 OID 0)
-- Dependencies: 181
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 195 (class 1255 OID 16605)
-- Name: upd_sign_in_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION upd_sign_in_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (NEW != OLD) THEN
	NEW.last_sign_in_at = OLD.current_sign_in_at;
        NEW.current_sign_in_at = CURRENT_TIMESTAMP;
        NEW.updated_at = CURRENT_TIMESTAMP;
        RETURN NEW;
    END IF;
    RETURN OLD;
END;
$$;


--
-- TOC entry 196 (class 1255 OID 16607)
-- Name: upd_sign_in_ip(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION upd_sign_in_ip() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (NEW != OLD) THEN
	NEW.last_sign_in_ip = OLD.current_sign_in_ip;
	NEW.updated_at = CURRENT_TIMESTAMP;
        RETURN NEW;
    END IF;
    RETURN OLD;
END;
$$;


--
-- TOC entry 194 (class 1255 OID 16477)
-- Name: upd_timestamp(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION upd_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (NEW != OLD) THEN
	NEW.updated_at = CURRENT_TIMESTAMP;
        RETURN NEW;
    END IF;
    RETURN OLD;
END;
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 173 (class 1259 OID 16402)
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    name character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    category_id integer NOT NULL
);


--
-- TOC entry 176 (class 1259 OID 16426)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2078 (class 0 OID 0)
-- Dependencies: 176
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_category_id_seq OWNED BY categories.category_id;


--
-- TOC entry 180 (class 1259 OID 16610)
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- TOC entry 174 (class 1259 OID 16410)
-- Name: ticket_statuses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ticket_statuses (
    name character varying NOT NULL,
    "position" integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    ticket_status_id integer NOT NULL
);


--
-- TOC entry 177 (class 1259 OID 16437)
-- Name: ticket_statuses_ticket_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ticket_statuses_ticket_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2079 (class 0 OID 0)
-- Dependencies: 177
-- Name: ticket_statuses_ticket_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ticket_statuses_ticket_status_id_seq OWNED BY ticket_statuses.ticket_status_id;


--
-- TOC entry 175 (class 1259 OID 16418)
-- Name: tickets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tickets (
    title character varying,
    description text,
    user_id integer,
    category_id integer,
    ticket_status_id integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    ticket_id integer NOT NULL
);


--
-- TOC entry 178 (class 1259 OID 16449)
-- Name: tickets_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tickets_ticket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2080 (class 0 OID 0)
-- Dependencies: 178
-- Name: tickets_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tickets_ticket_id_seq OWNED BY tickets.ticket_id;


--
-- TOC entry 172 (class 1259 OID 16385)
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    name character varying(128) COLLATE pg_catalog."C.UTF-8" NOT NULL,
    is_admin boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    email character varying(128) NOT NULL,
    encrypted_password character varying(128),
    reset_password_token character varying(256),
    reset_password_sent_at timestamp with time zone,
    remember_created_at timestamp with time zone,
    sign_in_count integer,
    current_sign_in_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    current_sign_in_ip character varying(128),
    last_sign_in_ip character varying(128),
    user_id integer NOT NULL
);


--
-- TOC entry 179 (class 1259 OID 16461)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2081 (class 0 OID 0)
-- Dependencies: 179
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- TOC entry 1921 (class 2604 OID 16428)
-- Name: category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN category_id SET DEFAULT nextval('categories_category_id_seq'::regclass);


--
-- TOC entry 1923 (class 2604 OID 16439)
-- Name: ticket_status_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ticket_statuses ALTER COLUMN ticket_status_id SET DEFAULT nextval('ticket_statuses_ticket_status_id_seq'::regclass);


--
-- TOC entry 1925 (class 2604 OID 16451)
-- Name: ticket_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tickets ALTER COLUMN ticket_id SET DEFAULT nextval('tickets_ticket_id_seq'::regclass);


--
-- TOC entry 1919 (class 2604 OID 16463)
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- TOC entry 2062 (class 0 OID 16402)
-- Dependencies: 173
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO categories (name, created_at, updated_at, category_id) VALUES ('need-help', '2015-04-14 13:28:48.04749+03', '2015-04-14 17:53:06.383443+03', 1);
INSERT INTO categories (name, created_at, updated_at, category_id) VALUES ('solutions', '2015-04-14 17:54:25.469435+03', '2015-04-14 17:54:25.469435+03', 2);
INSERT INTO categories (name, created_at, updated_at, category_id) VALUES ('invitations', '2015-04-14 17:54:45.180209+03', '2015-04-14 17:54:45.180209+03', 3);


--
-- TOC entry 2082 (class 0 OID 0)
-- Dependencies: 176
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('categories_category_id_seq', 3, true);


--
-- TOC entry 2069 (class 0 OID 16610)
-- Dependencies: 180
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2063 (class 0 OID 16410)
-- Dependencies: 174
-- Data for Name: ticket_statuses; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO ticket_statuses (name, "position", created_at, updated_at, ticket_status_id) VALUES ('pending P0', 1, '2015-04-14 17:21:32.771866+03', '2015-04-14 17:21:32.771866+03', 1);
INSERT INTO ticket_statuses (name, "position", created_at, updated_at, ticket_status_id) VALUES ('pending P1', 2, '2015-04-14 17:21:48.249758+03', '2015-04-14 17:21:48.249758+03', 2);
INSERT INTO ticket_statuses (name, "position", created_at, updated_at, ticket_status_id) VALUES ('approving P0', 3, '2015-04-14 17:22:23.6196+03', '2015-04-14 17:22:23.6196+03', 3);
INSERT INTO ticket_statuses (name, "position", created_at, updated_at, ticket_status_id) VALUES ('approving P1', 4, '2015-04-14 17:22:59.7022+03', '2015-04-14 17:22:59.7022+03', 4);
INSERT INTO ticket_statuses (name, "position", created_at, updated_at, ticket_status_id) VALUES ('closed', 5, '2015-04-14 17:23:22.387692+03', '2015-04-14 17:23:22.387692+03', 5);
INSERT INTO ticket_statuses (name, "position", created_at, updated_at, ticket_status_id) VALUES ('open', 0, '2015-04-17 12:38:37.266474+03', '2015-04-17 12:38:37.266474+03', 6);


--
-- TOC entry 2083 (class 0 OID 0)
-- Dependencies: 177
-- Name: ticket_statuses_ticket_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ticket_statuses_ticket_status_id_seq', 6, true);


--
-- TOC entry 2064 (class 0 OID 16418)
-- Dependencies: 175
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tickets (title, description, user_id, category_id, ticket_status_id, created_at, updated_at, ticket_id) VALUES ('invitations to testing', 'Hi! Could you test its work or no?', 1, 3, 2, '2015-04-14 17:57:43.301159+03', '2015-04-22 16:25:09.982861+03', 3);
INSERT INTO tickets (title, description, user_id, category_id, ticket_status_id, created_at, updated_at, ticket_id) VALUES ('need help', 'It is should help me. It have to test for new ticket... How I could do this?
More regards,
Aqueelone', 1, 1, 4, '2015-04-14 17:28:56.524516+03', '2015-04-16 16:28:43.582051+03', 1);
INSERT INTO tickets (title, description, user_id, category_id, ticket_status_id, created_at, updated_at, ticket_id) VALUES ('test complied', 'This is test which was complied! YEA! 
It is really good!
More regards,
test', 2, 2, 1, '2015-04-14 17:55:42.904948+03', '2015-04-17 12:38:26.061919+03', 2);
INSERT INTO tickets (title, description, user_id, category_id, ticket_status_id, created_at, updated_at, ticket_id) VALUES ('invitations to testing again', 'tetete', 2, 1, 2, '2015-04-22 19:25:15.426348+03', '2015-04-22 19:25:15.426348+03', 62);
INSERT INTO tickets (title, description, user_id, category_id, ticket_status_id, created_at, updated_at, ticket_id) VALUES ('test_owership', 'test about who is owner of this ticket', 2, 1, 1, '2015-04-27 12:45:13.737696+03', '2015-04-27 12:45:13.737696+03', 64);
INSERT INTO tickets (title, description, user_id, category_id, ticket_status_id, created_at, updated_at, ticket_id) VALUES ('test_owership', 'Is this my ticket?', 3, 1, 1, '2015-04-27 13:25:15.670861+03', '2015-04-27 13:25:15.670861+03', 65);
INSERT INTO tickets (title, description, user_id, category_id, ticket_status_id, created_at, updated_at, ticket_id) VALUES ('test_owership', 'Is it mine?', 3, 1, 4, '2015-04-27 13:30:26.343388+03', '2015-04-27 13:30:26.343388+03', 66);


--
-- TOC entry 2084 (class 0 OID 0)
-- Dependencies: 178
-- Name: tickets_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tickets_ticket_id_seq', 66, true);


--
-- TOC entry 2061 (class 0 OID 16385)
-- Dependencies: 172
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO users (name, is_admin, created_at, updated_at, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, user_id) VALUES ('test', false, '2015-04-14 13:25:24.78831+03', '2015-04-14 13:25:24.78831+03', 'test@test.com', '$2a$10$eNAweopybB.Ih65.uhjuH.p4hmxg.mwRDYkIjKVFlgU5FeGveU75u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO users (name, is_admin, created_at, updated_at, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, user_id) VALUES ('test2', false, '2015-04-27 12:49:22.997635+03', '2015-04-28 14:18:44.252737+03', 'admin@mir-sv.com', '$2a$10$d3//YjjRAUKfBXcrU652UeIG/NJMMFScpO7.qmmPh7aEy.tzozEaK', NULL, NULL, NULL, 3, '2015-04-28 14:18:44.252737+03', '2015-04-27 14:40:28.301741+03', '127.0.0.1', '127.0.0.1', 3);
INSERT INTO users (name, is_admin, created_at, updated_at, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, user_id) VALUES ('admin', true, '2015-04-09 13:20:08.190347+03', '2015-04-28 14:55:40.616876+03', 'admin@sample.ticket.com', '$2a$10$1qVtmtDuDC73IPTOZB5iv.Pii7ysqtpQIIgHYeoxptI/d82vDo.tS', 'CQxi7zfMxu3WCTiJ1yb_', NULL, '2015-04-28 14:55:40.612792+03', 16, '2015-04-28 14:55:40.616876+03', '2015-04-28 14:55:29.552042+03', '127.0.0.1', '127.0.0.1', 1);


--
-- TOC entry 2085 (class 0 OID 0)
-- Dependencies: 179
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('users_user_id_seq', 3, true);


--
-- TOC entry 1932 (class 2606 OID 16436)
-- Name: category_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT category_id PRIMARY KEY (category_id);


--
-- TOC entry 1936 (class 2606 OID 16459)
-- Name: ticket_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT ticket_id PRIMARY KEY (ticket_id);


--
-- TOC entry 1934 (class 2606 OID 16448)
-- Name: ticket_status_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ticket_statuses
    ADD CONSTRAINT ticket_status_id PRIMARY KEY (ticket_status_id);


--
-- TOC entry 1930 (class 2606 OID 16473)
-- Name: user_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT user_id PRIMARY KEY (user_id);


--
-- TOC entry 1927 (class 1259 OID 16401)
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- TOC entry 1928 (class 1259 OID 16400)
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- TOC entry 1937 (class 1259 OID 16613)
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- TOC entry 1944 (class 2620 OID 16588)
-- Name: update_category_name; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_category_name BEFORE UPDATE OF name ON categories FOR EACH ROW EXECUTE PROCEDURE upd_timestamp();


--
-- TOC entry 1949 (class 2620 OID 16594)
-- Name: update_ticket_category_id; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_ticket_category_id BEFORE UPDATE OF category_id ON tickets FOR EACH ROW EXECUTE PROCEDURE upd_timestamp();


--
-- TOC entry 1947 (class 2620 OID 16592)
-- Name: update_ticket_description; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_ticket_description BEFORE UPDATE OF description ON tickets FOR EACH ROW EXECUTE PROCEDURE upd_timestamp();


--
-- TOC entry 1945 (class 2620 OID 16589)
-- Name: update_ticket_statuses_name; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_ticket_statuses_name BEFORE UPDATE ON ticket_statuses FOR EACH ROW EXECUTE PROCEDURE upd_timestamp();


--
-- TOC entry 1946 (class 2620 OID 16590)
-- Name: update_ticket_statuses_position; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_ticket_statuses_position BEFORE UPDATE OF "position" ON ticket_statuses FOR EACH ROW EXECUTE PROCEDURE upd_timestamp();


--
-- TOC entry 1950 (class 2620 OID 16595)
-- Name: update_ticket_ticket_status_id; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_ticket_ticket_status_id BEFORE UPDATE OF ticket_status_id ON tickets FOR EACH ROW EXECUTE PROCEDURE upd_timestamp();


--
-- TOC entry 1951 (class 2620 OID 16591)
-- Name: update_ticket_title; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_ticket_title BEFORE UPDATE OF title ON tickets FOR EACH ROW EXECUTE PROCEDURE upd_timestamp();


--
-- TOC entry 1948 (class 2620 OID 16593)
-- Name: update_ticket_user_id; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_ticket_user_id BEFORE UPDATE OF user_id ON tickets FOR EACH ROW EXECUTE PROCEDURE upd_timestamp();


--
-- TOC entry 1941 (class 2620 OID 16600)
-- Name: update_user_ecrypted_password; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_user_ecrypted_password BEFORE UPDATE OF encrypted_password ON users FOR EACH ROW EXECUTE PROCEDURE upd_timestamp();


--
-- TOC entry 1939 (class 2620 OID 16598)
-- Name: update_user_email; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_user_email BEFORE UPDATE OF email ON users FOR EACH ROW EXECUTE PROCEDURE upd_timestamp();


--
-- TOC entry 1940 (class 2620 OID 16599)
-- Name: update_user_is_admin; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_user_is_admin BEFORE UPDATE OF is_admin ON users FOR EACH ROW EXECUTE PROCEDURE upd_timestamp();


--
-- TOC entry 1938 (class 2620 OID 16596)
-- Name: update_user_name; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_user_name BEFORE UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE upd_timestamp();


--
-- TOC entry 1942 (class 2620 OID 16608)
-- Name: update_user_sign_in_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_user_sign_in_at BEFORE UPDATE OF sign_in_count ON users FOR EACH ROW EXECUTE PROCEDURE upd_sign_in_at();


--
-- TOC entry 1943 (class 2620 OID 16609)
-- Name: update_user_sign_in_ip; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_user_sign_in_ip BEFORE UPDATE OF current_sign_in_ip ON users FOR EACH ROW EXECUTE PROCEDURE upd_sign_in_ip();


-- Completed on 2015-04-28 15:17:41 EEST

--
-- PostgreSQL database dump complete
--

