-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.address
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    customer_id integer NOT NULL,
    city_id integer NOT NULL,
    county_id integer NOT NULL,
    postal_code character varying COLLATE pg_catalog."default" NOT NULL,
    address_detail character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT addresses_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.bills
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    customer_id integer NOT NULL,
    address_id integer NOT NULL,
    order_id integer NOT NULL,
    total_price double precision NOT NULL,
    bill_date date NOT NULL,
    CONSTRAINT bills_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.brands
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT brands_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.cars
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    brand_id integer NOT NULL,
    model_year integer NOT NULL,
    model_name character varying COLLATE pg_catalog."default" NOT NULL,
    color character varying COLLATE pg_catalog."default" NOT NULL,
    fuel_type character varying COLLATE pg_catalog."default" NOT NULL,
    shift_type character varying COLLATE pg_catalog."default" NOT NULL,
    price double precision NOT NULL,
    order_id integer NOT NULL,
    CONSTRAINT cars_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.cities
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT cities_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.counties
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    city_id integer NOT NULL,
    CONSTRAINT counties_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.customers
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    surname character varying COLLATE pg_catalog."default" NOT NULL,
    tc_no character varying COLLATE pg_catalog."default" NOT NULL,
    gender character varying COLLATE pg_catalog."default" NOT NULL,
    phone character varying COLLATE pg_catalog."default" NOT NULL,
    email character varying COLLATE pg_catalog."default" NOT NULL,
    age integer NOT NULL,
    CONSTRAINT customers_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.orders
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    customer_id integer NOT NULL,
    order_date date NOT NULL,
    start_date date NOT NULL,
    finish_date date NOT NULL,
    total_price double precision NOT NULL,
    payment_type character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT orders_pkey PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.address
    ADD CONSTRAINT "FK_CITIES_ADDRESS" FOREIGN KEY (city_id)
    REFERENCES public.cities (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.address
    ADD CONSTRAINT "FK_COUNTIES_ADDRESS" FOREIGN KEY (county_id)
    REFERENCES public.counties (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.address
    ADD CONSTRAINT "FK_CUSTOMERS_ADDRESS" FOREIGN KEY (customer_id)
    REFERENCES public.customers (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.bills
    ADD CONSTRAINT "FK_ADDRESS_BILLS" FOREIGN KEY (address_id)
    REFERENCES public.address (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.bills
    ADD CONSTRAINT "FK_CUSTOMERS_BILLS" FOREIGN KEY (customer_id)
    REFERENCES public.customers (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.bills
    ADD CONSTRAINT "FK_ORDERS_BILLS" FOREIGN KEY (order_id)
    REFERENCES public.orders (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.cars
    ADD CONSTRAINT "FK_BRANDS_CARS" FOREIGN KEY (brand_id)
    REFERENCES public.brands (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.cars
    ADD CONSTRAINT "FK_ORDERS_CARS" FOREIGN KEY (order_id)
    REFERENCES public.orders (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.counties
    ADD CONSTRAINT "FK_CITIES_COUNTIES" FOREIGN KEY (city_id)
    REFERENCES public.cities (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.orders
    ADD CONSTRAINT "FK_CUSTOMERS_ORDERS" FOREIGN KEY (customer_id)
    REFERENCES public.customers (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;