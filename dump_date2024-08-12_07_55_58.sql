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
    set_as_default boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    cart_id uuid NOT NULL,
    product_id uuid NOT NULL,
    product_name character varying(255) NOT NULL,
    quantity integer NOT NULL,
    total_price numeric(10,2) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT cart_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
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
    product_name character varying(255) NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL,
    status character varying(50) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
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
    address_id uuid,
    invoice_url text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: product_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_images (
    id uuid NOT NULL,
    product_id uuid,
    image_url text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
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
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
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
    updated_at timestamp with time zone DEFAULT now(),
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    user_status integer NOT NULL,
    user_role character varying(25) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (id, user_id, first_name, last_name, country, street_address, town_city, state, pin_code, mobile_number, email, order_notes, set_as_default, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_items (id, cart_id, product_id, product_name, quantity, total_price, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (id, user_id, created_at, updated_at) FROM stdin;
e4503033-40f1-4749-800a-0c367467aaca	58d3a42d-ab4e-4133-817f-306dd0f3fdc7	2024-08-12 07:26:48.858237+00	2024-08-12 07:26:48.858237+00
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, description) FROM stdin;
79b8f88e-a237-4b37-8d60-e0948a3e645c	Pattachitra	Pattachitra is a traditional style of painting from the eastern Indian states of Odisha and West Bengal that originated centuries ago.
bbe3288f-d1a6-4902-aa34-07b417200e01	Talapatra	Also known as palm leaf painting, this ancient and sacred art form from Odisha, India involves treating palm leaves with turmeric, etching stories with an iron tool, and coloring with natural dyes.
20b97976-007e-4bfa-91cb-8f2e81629780	Modern Art	Modern art is a term that encompasses many different movements and ideas in art that reject traditional techniques and mainstream values.
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, first_name, last_name, email, phone, subject, message, submitted_at, replied) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, product_name, quantity, price, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, user_id, total, status, address_id, invoice_url, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_images (id, product_id, image_url, created_at) FROM stdin;
c469acf5-a2f4-4778-b6e3-edcff6331110	0e74fee2-2cb5-4887-a8da-93edf3c1fc8c	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444471/paintings_image/li1bnmkqz89f9d2gsy50.webp	2024-08-12 06:34:32.029406+00
f4221778-0c2b-4c77-8b23-d8a5f2c23e6d	0e74fee2-2cb5-4887-a8da-93edf3c1fc8c	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444472/paintings_image/cu6fpvzrh82qomh359om.webp	2024-08-12 06:34:32.626424+00
443332b3-dbdd-4ea3-8124-e53e2625b472	9d442ef4-c7bb-48b5-8357-b5aa639a2fad	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444555/paintings_image/rgl6txdicdv6fe90cn6n.webp	2024-08-12 06:35:55.432123+00
a9261790-2fc4-4554-9c51-b0449b242da9	9d442ef4-c7bb-48b5-8357-b5aa639a2fad	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444555/paintings_image/wbjehn7fo6euqe06ito4.webp	2024-08-12 06:35:56.388131+00
0ea1e8b1-b089-4f44-99d1-aa5611fdaae1	1b8a953e-1c6b-40ef-88ba-dcab9631e26c	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444599/paintings_image/nnejmghcvccql1zclinf.webp	2024-08-12 06:36:40.138671+00
5b33f3b9-7aaa-46cf-99a6-3db0c22fb4e2	1b8a953e-1c6b-40ef-88ba-dcab9631e26c	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444600/paintings_image/gytgjopxk89llkim6flp.webp	2024-08-12 06:36:40.865216+00
85495eaa-22af-44c0-8a35-73b9d3397156	f6f97a8e-7dc2-437d-b49f-79040b69610c	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444658/paintings_image/qnkani11jdk4ouz9yjvs.webp	2024-08-12 06:37:39.017238+00
d6d0786f-2239-4a2e-87ea-4103e639a36a	f6f97a8e-7dc2-437d-b49f-79040b69610c	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444659/paintings_image/xoxt8noozl6fowg9jg6m.webp	2024-08-12 06:37:39.638493+00
4f880112-4bfc-4314-a4bf-1ed50a9101b1	cff5ddd4-a42b-4049-95f5-acd576d2960a	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444721/paintings_image/wjuyq5nyy5br0iihilor.webp	2024-08-12 06:38:42.136006+00
4641185b-2be0-4953-a182-be74323b2bac	cff5ddd4-a42b-4049-95f5-acd576d2960a	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444722/paintings_image/evi2drzuwzkamsxpfwfi.jpg	2024-08-12 06:38:42.918515+00
ecd6db10-7877-4ad0-a9c9-c3dbc9ecb803	082ce175-5de2-4441-afaf-04932694ebb4	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444758/paintings_image/exa0qilj02rq24iozzjh.webp	2024-08-12 06:39:19.11816+00
a5037cda-bf72-441d-bcf0-25bd6d7d5ac7	082ce175-5de2-4441-afaf-04932694ebb4	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444759/paintings_image/zbrk2ajq9dftqynmejqr.jpg	2024-08-12 06:39:19.72131+00
a8f86d6d-0b6e-49fd-86d1-b9fb28251224	cfc47548-6e16-4711-8a21-f4d5ef403d87	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444793/paintings_image/uygfdaveebwnnrchdzpn.webp	2024-08-12 06:39:53.445887+00
873e1df9-6b00-46cb-ad40-75fe9e1e7b7b	cfc47548-6e16-4711-8a21-f4d5ef403d87	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444793/paintings_image/uchtzaonhildiicjdefv.webp	2024-08-12 06:39:54.05485+00
45d40f3f-f4cb-4360-8a6a-57e864e8d6a5	3a319eb4-2ed1-4885-9882-cd1dd60e1927	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444903/paintings_image/i3fxieei1ltjxlwe1kw2.webp	2024-08-12 06:41:44.077389+00
0382c3d4-c878-4a85-8713-e594c897abef	3a319eb4-2ed1-4885-9882-cd1dd60e1927	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723444904/paintings_image/rxgprq80krb2tzpttzo4.webp	2024-08-12 06:41:44.684087+00
3a0fff31-f6c6-46da-b743-9d0ed1f977eb	80f7a2a6-b7c5-4fa7-8d08-eed39fa4e8ba	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723445337/paintings_image/oxz9bygth3pvd1lbw9du.png	2024-08-12 06:48:58.047354+00
d22c20a3-a76b-46d1-89ef-df5ec99ee3d7	80f7a2a6-b7c5-4fa7-8d08-eed39fa4e8ba	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723445338/paintings_image/lvcihuek23f5xp4wlgjk.png	2024-08-12 06:48:58.625744+00
9b4a5278-7285-4c31-8716-08148e8d7c88	cc18385e-61f0-4703-bc6b-103d07c1003e	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723445395/paintings_image/eipa4g2iimksgr9kafk7.png	2024-08-12 06:49:56.400486+00
06bf5c2a-d6b3-4d27-9495-f7158adb5483	cc18385e-61f0-4703-bc6b-103d07c1003e	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723445396/paintings_image/p4ajvicwbfhhovqxldgq.png	2024-08-12 06:49:57.103278+00
b7f61930-07e2-401c-ab78-055b6e721a44	502fac59-e3a7-468c-a7c1-c34cb483582f	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723445457/paintings_image/su5irbcx18pvwfhg0q0b.png	2024-08-12 06:50:57.665233+00
672a32d1-6d9c-43d4-9c29-636359789652	502fac59-e3a7-468c-a7c1-c34cb483582f	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723445457/paintings_image/v8ay7dc2dplzc6l9rbgo.png	2024-08-12 06:50:58.380385+00
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, title, description, price, category_id, created_at, updated_at) FROM stdin;
0e74fee2-2cb5-4887-a8da-93edf3c1fc8c	Radha Krishna	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	2421.00	bbe3288f-d1a6-4902-aa34-07b417200e01	2024-08-12 06:34:30.973813+00	2024-08-12 06:34:30.973813+00
9d442ef4-c7bb-48b5-8357-b5aa639a2fad	Nartaka Ganesha (14*20 Inch)	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	4344.00	bbe3288f-d1a6-4902-aa34-07b417200e01	2024-08-12 06:35:54.531116+00	2024-08-12 06:35:54.531117+00
1b8a953e-1c6b-40ef-88ba-dcab9631e26c	 Puri Jagannath (14*20 Inch)	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	4344.00	bbe3288f-d1a6-4902-aa34-07b417200e01	2024-08-12 06:36:39.176109+00	2024-08-12 06:36:39.176109+00
f6f97a8e-7dc2-437d-b49f-79040b69610c	Nartaka Ganesha (14*20 Inch)	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	5080.00	bbe3288f-d1a6-4902-aa34-07b417200e01	2024-08-12 06:37:38.055757+00	2024-08-12 06:37:38.055757+00
cff5ddd4-a42b-4049-95f5-acd576d2960a	Krishna Painting (18*24) Inches	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	4556.00	79b8f88e-a237-4b37-8d60-e0948a3e645c	2024-08-12 06:38:41.447754+00	2024-08-12 06:38:41.447754+00
082ce175-5de2-4441-afaf-04932694ebb4	Buddha Painting (18*24) Inches	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	4556.00	79b8f88e-a237-4b37-8d60-e0948a3e645c	2024-08-12 06:39:18.417233+00	2024-08-12 06:39:18.417233+00
cfc47548-6e16-4711-8a21-f4d5ef403d87	Ganesha Painting (18*24) Inches	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	4556.00	79b8f88e-a237-4b37-8d60-e0948a3e645c	2024-08-12 06:39:52.77497+00	2024-08-12 06:39:52.77497+00
3a319eb4-2ed1-4885-9882-cd1dd60e1927	Tree of Life Painting (18*24)Inch	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	4556.00	79b8f88e-a237-4b37-8d60-e0948a3e645c	2024-08-12 06:41:43.102539+00	2024-08-12 06:41:43.102539+00
80f7a2a6-b7c5-4fa7-8d08-eed39fa4e8ba	Just in Time	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	3200.00	20b97976-007e-4bfa-91cb-8f2e81629780	2024-08-12 06:48:56.860399+00	2024-08-12 06:48:56.860399+00
cc18385e-61f0-4703-bc6b-103d07c1003e	Lost Laces	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	2500.00	20b97976-007e-4bfa-91cb-8f2e81629780	2024-08-12 06:49:55.430414+00	2024-08-12 06:49:55.430414+00
502fac59-e3a7-468c-a7c1-c34cb483582f	Multifacet	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	3568.00	20b97976-007e-4bfa-91cb-8f2e81629780	2024-08-12 06:50:56.86484+00	2024-08-12 06:50:56.86484+00
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

COPY public.users (id, created_at, updated_at, first_name, last_name, email, password_hash, user_status, user_role) FROM stdin;
e505b0ae-f81a-47d7-9ca8-1606acfefdc2	2024-08-12 06:28:23.256297+00	0001-01-01 00:00:00+00	Niladri	Adak	user@user.com	$2a$04$Lo9kdHJzjpdpaj2a7vli6O6DX55syDBxioW1ffvS4NFXjq3ZmpITS	1	user
9cf22808-36ee-43a8-a300-81e4d3c0caed	2024-08-12 06:28:52.508389+00	0001-01-01 00:00:00+00	Niladri	Adak	admin@admin.com	$2a$04$4s.alQsL2tplFa.WSKJJjej/OEzxRF8Hrjzjo8..EDxpmNYn.3iE.	1	admin
58d3a42d-ab4e-4133-817f-306dd0f3fdc7	2024-08-12 07:22:17.608558+00	0001-01-01 00:00:00+00	Abhsihek	Santra	Abhsihka@gmail.com	$2a$04$jBqMbjFR552/y0W9ssE9gOykDB8D3hrwvKv4TxIjeG68PkJ.Ed9Xq	1	user
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
-- Name: orders orders_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.addresses(id) ON DELETE SET NULL;


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

