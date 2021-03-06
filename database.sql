-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE public.candidates
(
    id integer NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    identity_number character varying(11) NOT NULL,
    birth_year integer NOT NULL,
    user_id integer,
    PRIMARY KEY (id)
);

CREATE TABLE public.employee_confirm_employers
(
    id integer NOT NULL,
    employer_id integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.employee_confirms
(
    id integer NOT NULL,
    employee_id integer NOT NULL,
    is_confirmed boolean NOT NULL,
    confirm_date date,
    PRIMARY KEY (id)
);

CREATE TABLE public.employees
(
    id integer NOT NULL,
    first_name character varying(35) NOT NULL,
    last_name character varying(35) NOT NULL,
    user_id integer,
    PRIMARY KEY (id)
);

CREATE TABLE public.employers
(
    id integer NOT NULL,
    company_name character varying(255) NOT NULL,
    web_site character varying(50) NOT NULL,
    phone_number character varying(12) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.jobs
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    title character varying(255) NOT NULL,
    name character varying(100) NOT NULL,
    user_id integer,
    PRIMARY KEY (id)
);

CREATE TABLE public.users
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    email character varying(320) NOT NULL,
    password character varying(25) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.verification_code_candidates
(
    id integer NOT NULL,
    candidate_id integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.verification_code_employers
(
    id integer NOT NULL,
    employer_id integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.verification_codes
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    code character varying(38) NOT NULL,
    is_verified boolean NOT NULL,
    verified_date date,
    PRIMARY KEY (id)
);

ALTER TABLE public.candidates
    ADD FOREIGN KEY (id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.employee_confirm_employers
    ADD FOREIGN KEY (id)
    REFERENCES public.employee_confirms (id)
    NOT VALID;


ALTER TABLE public.employee_confirm_employers
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employers (id)
    NOT VALID;


ALTER TABLE public.employee_confirms
    ADD FOREIGN KEY (employee_id)
    REFERENCES public.employers (id)
    NOT VALID;


ALTER TABLE public.employees
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.employees
    ADD FOREIGN KEY (id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.employers
    ADD FOREIGN KEY (id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.jobs
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.verification_code_candidates
    ADD FOREIGN KEY (candidate_id)
    REFERENCES public.candidates (id)
    NOT VALID;


ALTER TABLE public.verification_code_candidates
    ADD FOREIGN KEY (id)
    REFERENCES public.verification_codes (id)
    NOT VALID;


ALTER TABLE public.verification_code_employers
    ADD FOREIGN KEY (id)
    REFERENCES public.verification_codes (id)
    NOT VALID;


ALTER TABLE public.verification_code_employers
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employers (id)
    NOT VALID;

END;