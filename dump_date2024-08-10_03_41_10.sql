--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    country character varying(100) NOT NULL,
    street_address character varying(255) NOT NULL,
    town_city character varying(100) NOT NULL,
    state character varying(100) NOT NULL,
    pin_code character varying(20) NOT NULL,
    mobile_number character varying(20) NOT NULL,
    email character varying(255) NOT NULL,
    order_notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    cart_id uuid NOT NULL,
    product_id uuid NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT cart_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    phone character varying(20) NOT NULL,
    subject character varying(200) NOT NULL,
    message text NOT NULL,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    replied boolean DEFAULT false NOT NULL
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id uuid NOT NULL,
    order_id uuid,
    product_id uuid,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id uuid NOT NULL,
    user_id uuid,
    total numeric(10,2) NOT NULL,
    status character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: product_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_images (
    id uuid NOT NULL,
    product_id uuid,
    image_url text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.product_images OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id uuid NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    category_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    dirty boolean NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp without time zone NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    user_status integer NOT NULL,
    user_role character varying(25) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (id, user_id, first_name, last_name, country, street_address, town_city, state, pin_code, mobile_number, email, order_notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_items (id, cart_id, product_id, quantity, price, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, description) FROM stdin;
090ab787-4943-4e30-a56e-5186e73fa3c4	Modern Art	Modern art is a term that encompasses many different movements and ideas in art that reject traditional techniques and mainstream values.
973e82c1-ac3b-4094-a688-31c938b1afae	Talapatra	Also known as palm leaf painting, this ancient and sacred art form from Odisha, India involves treating palm leaves with turmeric, etching stories with an iron tool, and coloring with natural dyes.
1c5bf6d2-2004-4d5a-9159-d5163b34144b	Pattachitra	Pattachitra is a traditional style of painting from the eastern Indian states of Odisha and West Bengal that originated centuries ago.
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, first_name, last_name, email, phone, subject, message, submitted_at, replied) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, quantity, price, created_at) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, user_id, total, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_images (id, product_id, image_url, created_at) FROM stdin;
cb90fe59-7c2a-4879-a414-7de7c276aca0	4423499b-c56e-4983-8369-ba6cfd4c90a6	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723185039/paintings_image/pivxjnesz11wdcvtheew.webp	2024-08-09 06:30:40.002156
c15f3f6d-7fee-4c80-b790-d8a509e536e9	4423499b-c56e-4983-8369-ba6cfd4c90a6	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723185040/paintings_image/clz8tosubnpyrxsyrhuy.webp	2024-08-09 06:30:40.748701
18d8e687-5abc-41e5-9765-472557f32614	c3e22e81-fc53-4c77-b0b4-d66e1473a5d6	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723185235/paintings_image/kf9mdzarwb0t63ndvfvr.jpg	2024-08-09 06:33:55.489163
37e1b77b-ecb9-4884-bad7-0f44bbf923f1	c3e22e81-fc53-4c77-b0b4-d66e1473a5d6	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723185235/paintings_image/i4kbciri8hbx55b0mr1g.webp	2024-08-09 06:33:56.162304
00022bed-9f55-4254-952b-fef625ffb3f5	8916fcca-f166-4fcf-80b5-0e4e3c768dbc	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723213316/paintings_image/o69msxvbgtkzppxb6z2d.webp	2024-08-09 14:21:57.365884
5d494326-d67f-4692-a6e6-c1657d0d3993	8916fcca-f166-4fcf-80b5-0e4e3c768dbc	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723213317/paintings_image/ehzdmcidbwpctewmouun.webp	2024-08-09 14:21:58.465878
720d850e-52f4-4712-b46d-87011291e2ff	2d41e4e5-08bc-45a7-a436-7e19dd4b0ed8	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723213431/paintings_image/b66ozfabieawlanpivkf.webp	2024-08-09 14:23:52.258253
614721b2-daa8-44aa-853b-e3d7298dace4	2d41e4e5-08bc-45a7-a436-7e19dd4b0ed8	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723213432/paintings_image/vqvovp5tnjbvnnhsf7ei.jpg	2024-08-09 14:23:53.080755
89e59004-60ab-40d4-b648-63c025ab5150	e0d3fa6e-c10b-4eff-a4e5-54bad8da9398	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723213493/paintings_image/l0f2yex1xs1ludipzt5b.webp	2024-08-09 14:24:54.396931
65d40fe7-77d7-4168-82a2-8d30e5170f09	e0d3fa6e-c10b-4eff-a4e5-54bad8da9398	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723213494/paintings_image/h2iyfwrdtlondvar7zaq.webp	2024-08-09 14:24:55.148082
bd3d2d3a-f710-4dd2-838b-3b9661eb9cba	6c80ff92-3af4-4fc5-88d4-d3659a116463	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723213555/paintings_image/riwo1hlg5g6pzfugwpla.webp	2024-08-09 14:25:56.043846
19b461ae-2342-4f77-9efd-684962c927e3	6c80ff92-3af4-4fc5-88d4-d3659a116463	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723213556/paintings_image/pkni7jbwc0wn5ise9ma0.webp	2024-08-09 14:25:56.804175
acffa079-945e-4703-ad06-53a5daf796cd	c433a4dc-55ff-4a71-9247-cf5c3ee67461	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723213624/paintings_image/pnsjm4jqvanu07us6vcw.webp	2024-08-09 14:27:04.966334
6872a379-3a44-4e53-a8ec-555b1b15a810	c433a4dc-55ff-4a71-9247-cf5c3ee67461	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723213625/paintings_image/thult9ozljfyx7uimkqe.webp	2024-08-09 14:27:05.832632
8c1a1f19-26b7-4e18-bed3-54b5cf72ef1a	a96e0d12-3e68-4a0d-871a-ed5e5a2d7a70	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723213785/paintings_image/uoaimlo5imdeys77wnnw.png	2024-08-09 14:29:46.336122
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, title, description, price, category_id, created_at, updated_at) FROM stdin;
4423499b-c56e-4983-8369-ba6cfd4c90a6	Decor Painting	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	4497.00	973e82c1-ac3b-4094-a688-31c938b1afae	2024-08-09 06:30:38.678261	2024-08-09 06:30:38.678262
c3e22e81-fc53-4c77-b0b4-d66e1473a5d6	Ganesha	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	2500.00	973e82c1-ac3b-4094-a688-31c938b1afae	2024-08-09 06:33:54.261665	2024-08-09 06:33:54.261665
8916fcca-f166-4fcf-80b5-0e4e3c768dbc	Govardhana Krishna	The art goes back to the time when there was no Pen or Paper and people recorded everything on palm leaves. The history of writing in India found its true meaning in Palm Leaves. Many tales and epics like Ramayana, Mahabharata, Krishna Leela were originally registered on palm leaves and were passed on for Generations.	1648.00	973e82c1-ac3b-4094-a688-31c938b1afae	2024-08-09 14:21:55.859659	2024-08-09 14:21:55.859659
2d41e4e5-08bc-45a7-a436-7e19dd4b0ed8	Buddha Painting 	The art goes back to the time when there was no Pen or Paper and people recorded everything on palm leaves. The history of writing in India found its true meaning in Palm Leaves. Many tales and epics like Ramayana, Mahabharata, Krishna Leela were originally registered on palm leaves and were passed on for Generations.	4556.00	1c5bf6d2-2004-4d5a-9159-d5163b34144b	2024-08-09 14:23:50.967677	2024-08-09 14:23:50.967677
e0d3fa6e-c10b-4eff-a4e5-54bad8da9398	Tree of Life	The art goes back to the time when there was no Pen or Paper and people recorded everything on palm leaves. The history of writing in India found its true meaning in Palm Leaves. Many tales and epics like Ramayana, Mahabharata, Krishna Leela were originally registered on palm leaves and were passed on for Generations.	4556.00	1c5bf6d2-2004-4d5a-9159-d5163b34144b	2024-08-09 14:24:53.527747	2024-08-09 14:24:53.527747
6c80ff92-3af4-4fc5-88d4-d3659a116463	Ganesha Nritya 	The art goes back to the time when there was no Pen or Paper and people recorded everything on palm leaves. The history of writing in India found its true meaning in Palm Leaves. Many tales and epics like Ramayana, Mahabharata, Krishna Leela were originally registered on palm leaves and were passed on for Generations.	4095.00	1c5bf6d2-2004-4d5a-9159-d5163b34144b	2024-08-09 14:25:55.286726	2024-08-09 14:25:55.286726
c433a4dc-55ff-4a71-9247-cf5c3ee67461	Tree of Life Ardha Narishwara Painting	The art goes back to the time when there was no Pen or Paper and people recorded everything on palm leaves. The history of writing in India found its true meaning in Palm Leaves. Many tales and epics like Ramayana, Mahabharata, Krishna Leela were originally registered on palm leaves and were passed on for Generations.	4556.00	1c5bf6d2-2004-4d5a-9159-d5163b34144b	2024-08-09 14:27:04.024361	2024-08-09 14:27:04.024361
a96e0d12-3e68-4a0d-871a-ed5e5a2d7a70	Just in Time	The art goes back to the time when there was no Pen or Paper and people recorded everything on palm leaves. The history of writing in India found its true meaning in Palm Leaves. Many tales and epics like Ramayana, Mahabharata, Krishna Leela were originally registered on palm leaves and were passed on for Generations.	3200.00	090ab787-4943-4e30-a56e-5186e73fa3c4	2024-08-09 14:29:44.934338	2024-08-09 14:29:44.934338
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version, dirty) FROM stdin;
1	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, created_at, updated_at, email, password_hash, user_status, user_role) FROM stdin;
e36cee52-b844-4f37-a5ca-db035aad3f49	2024-08-09 06:26:31.601099+00	0001-01-01 00:00:00	admin@admin.com	$2a$04$CIVG/iP0/wxTJ94ZtOyc0OHRr2LyhYx7vZJW8FSkKk0m1gLP.rDyC	1	admin
560800bc-920f-467b-94f3-fca34fef28bd	2024-08-09 16:19:06.318523+00	0001-01-01 00:00:00	arnabpal@gov.in	$2a$04$j8.9Wwqvc/g2hGqKDk/iv.JrnueuqOy/SGF1LEJ/1JMkNMaOL/ad6	1	user
27955b94-710c-4b9c-a093-5bee369abe13	2024-08-09 18:28:32.338309+00	0001-01-01 00:00:00	abhishek@gov.in	$2a$04$52zc8k3Ui7b3pYMrM44icesdx.iQOl7/qgt/HyCRKnKsBacJOW9BW	1	user
50fde808-97a4-40c0-8393-704c080b976c	2024-08-09 18:33:42.102724+00	0001-01-01 00:00:00	abhisheksantra28@gmail.com	$2a$04$ktJ5SSyUU8CrPHeQEAwt6OsFjQ0qOJa.vMI9lTjzCgZpX/1ruKQXO	1	user
\.


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_images product_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: cart_items cart_items_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.carts(id) ON DELETE CASCADE;


--
-- Name: cart_items cart_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: carts carts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: product_images product_images_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

