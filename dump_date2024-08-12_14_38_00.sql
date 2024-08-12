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
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, description) FROM stdin;
0834ed5e-21f1-480c-aed6-ae90d3a9a83a	Modern Art	Modern art is a term that encompasses many different movements and ideas in art that reject traditional techniques and mainstream values.
3483b9df-9eb2-4839-9524-174722341000	Talapatra	Also known as palm leaf painting, this ancient and sacred art form from Odisha, India involves treating palm leaves with turmeric, etching stories with an iron tool, and coloring with natural dyes.
93467433-6030-420d-bc83-dc3d6e3f50e8	Pattachitra	Pattachitra is a traditional style of painting from the eastern Indian states of Odisha and West Bengal that originated centuries ago.
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
66dd9438-5c23-4cae-b3c1-3cdfa45e96a3	308b642a-4fcb-4bdb-acc4-2139a93f0e5a	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723472971/paintings_image/gozz5jhfqllytcygnjel.png	2024-08-12 14:29:32.295263+00
0975ceaa-1a7e-4f69-afda-1273494ca4f8	308b642a-4fcb-4bdb-acc4-2139a93f0e5a	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723472972/paintings_image/vhl9otuqownnyuk43ite.png	2024-08-12 14:29:33.12582+00
6edee9a5-936a-49b9-a86f-e99e8c30ff52	ec3fabd5-c1d1-4a85-b31f-876238c26897	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473017/paintings_image/wm7mocdkg1o8mrqgytzq.png	2024-08-12 14:30:18.386372+00
637ed5f6-9a10-45ef-9659-7be6c8da54ff	ec3fabd5-c1d1-4a85-b31f-876238c26897	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473018/paintings_image/bs89efnkg6gmbsddn7jp.png	2024-08-12 14:30:19.085175+00
b95517a5-1726-41ea-a6ed-eb782158ae2f	7082ee4b-becf-4ba0-9a40-8024df8257e7	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473057/paintings_image/lf4wjnwwndnpsi3csezu.png	2024-08-12 14:30:58.408169+00
37d66296-89e5-4f6e-aadd-e7b90f1e81a7	7082ee4b-becf-4ba0-9a40-8024df8257e7	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473058/paintings_image/wmjmkrfcqcjhbtwinrrn.png	2024-08-12 14:30:59.263405+00
8b496b0f-474e-47b5-831d-a30c16cbc9ea	8311e5f4-a28a-473d-a5a9-e8f0444b6c21	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473156/paintings_image/hdjxj57gydyv2onux7fk.webp	2024-08-12 14:32:36.78283+00
ef82d699-fc15-4e49-97b9-40715636fa5e	8311e5f4-a28a-473d-a5a9-e8f0444b6c21	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473157/paintings_image/cejlhrxaeuewbvph9aox.webp	2024-08-12 14:32:37.493252+00
be0edca8-f502-4eae-b7fe-38f36239780f	42ba09c6-a1d5-4e7f-b1c8-b833a014c08c	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473207/paintings_image/mhdgwpcthywszi7dqiwx.webp	2024-08-12 14:33:28.238266+00
a8f0214c-2dbe-4335-8599-6925823e5195	42ba09c6-a1d5-4e7f-b1c8-b833a014c08c	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473208/paintings_image/opuj3roho2vzjbfgy5oe.webp	2024-08-12 14:33:29.05042+00
8159fee6-ef6f-4cf2-b072-cde3963794d1	ac90f028-e518-4cb9-87bd-aaebe57735de	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473274/paintings_image/pb0eqqcr9v5h5zy7r1t6.webp	2024-08-12 14:34:34.877255+00
c80a059a-8917-4d42-8ed8-899428bb2f25	ac90f028-e518-4cb9-87bd-aaebe57735de	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473275/paintings_image/smfqpa3wrd48ej3ngjl1.jpg	2024-08-12 14:34:35.725204+00
21bdcb60-a89d-48b8-a542-f71e7c61fc05	66d496ed-ef29-4130-95c0-4a6c8c7dea78	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473314/paintings_image/hahdvqxfebplwer7iypz.webp	2024-08-12 14:35:14.396139+00
dff75b18-4cfa-4ef7-a84c-7381867c2633	66d496ed-ef29-4130-95c0-4a6c8c7dea78	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473314/paintings_image/mopeacvp0nwamqetkhnw.jpg	2024-08-12 14:35:15.367186+00
42de528a-3454-41bf-8580-222daefc2cb0	673dd079-56fd-4498-a162-8a2ba42833e5	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473378/paintings_image/ikec85b8k5yqxpiamueu.webp	2024-08-12 14:36:18.919138+00
1d269f0a-6669-4fa3-b4ee-c3bdedc5c346	673dd079-56fd-4498-a162-8a2ba42833e5	https://res.cloudinary.com/doqoyoxxp/image/upload/v1723473379/paintings_image/ypcmeeeqeiupowmrtqbq.webp	2024-08-12 14:36:19.541769+00
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, title, description, price, category_id, created_at, updated_at) FROM stdin;
308b642a-4fcb-4bdb-acc4-2139a93f0e5a	Multifacet	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	3568.00	0834ed5e-21f1-480c-aed6-ae90d3a9a83a	2024-08-12 14:29:31.164452+00	2024-08-12 14:29:31.164453+00
ec3fabd5-c1d1-4a85-b31f-876238c26897	Lost Laces	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	2500.00	0834ed5e-21f1-480c-aed6-ae90d3a9a83a	2024-08-12 14:30:17.403679+00	2024-08-12 14:30:17.40368+00
7082ee4b-becf-4ba0-9a40-8024df8257e7	Just in Time	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	3450.00	0834ed5e-21f1-480c-aed6-ae90d3a9a83a	2024-08-12 14:30:57.120148+00	2024-08-12 14:30:57.120148+00
8311e5f4-a28a-473d-a5a9-e8f0444b6c21	Tree of Life Painting	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	3200.00	93467433-6030-420d-bc83-dc3d6e3f50e8	2024-08-12 14:32:35.805279+00	2024-08-12 14:32:35.805279+00
42ba09c6-a1d5-4e7f-b1c8-b833a014c08c	Ganesha Painting (18*24)	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	4556.00	93467433-6030-420d-bc83-dc3d6e3f50e8	2024-08-12 14:33:27.223796+00	2024-08-12 14:33:27.223796+00
ac90f028-e518-4cb9-87bd-aaebe57735de	Buddha Painting (18*24) Inches	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	4556.00	93467433-6030-420d-bc83-dc3d6e3f50e8	2024-08-12 14:34:34.129528+00	2024-08-12 14:34:34.129528+00
66d496ed-ef29-4130-95c0-4a6c8c7dea78	Krishna Painting (18*24) Inches	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	4556.00	3483b9df-9eb2-4839-9524-174722341000	2024-08-12 14:35:13.707793+00	2024-08-12 14:35:13.707793+00
673dd079-56fd-4498-a162-8a2ba42833e5	Puri Jagannath (14*20 Inch)	The ancient art innovators at Odisha, refined and devised a new technique of Etching and Painting on Palm leaves	4276.00	3483b9df-9eb2-4839-9524-174722341000	2024-08-12 14:36:17.949349+00	2024-08-12 14:36:17.949349+00
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
712d3722-004a-42f7-98b2-507408b2e274	2024-08-12 14:24:47.699452+00	0001-01-01 00:00:00+00	Niladri	Adak	admin@admin.com	$2a$04$ylpaQD9PfmLw0qmWG38j7.hUK0lEPXWu1899MJrAZ8szk/zv2cAzi	1	admin
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

