--Vine DDL - v1
CREATE extension tablefunc;

--table: vine_user

--DROP TABLE public.vine_user;

CREATE TABLE public.vine_user (
    vine_user_id serial NOT NULL,
    username varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    vine_password varchar(255) NOT NULL,
    verified_fl int4 DEFAULT 1 NOT NULL,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_vine_user PRIMARY KEY (vine_user_id),
    CONSTRAINT uq_vine_user_email UNIQUE (email)
) WITH (OIDS=FALSE);

ALTER TABLE public.vine_user OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.vine_user TO "V1n3Us3r";

-- table: vine_user_action

--DROP TABLE public.vine_user_action;

CREATE TABLE public.vine_user_action (
    vine_user_action_id serial NOT NULL,
    vine_user_id INT4 NOT NULL,
    user_action varchar(255) NOT NULL,
    user_token varchar(255) NOT NULL,
    datetime_user_token_valid timestamp DEFAULT NULL::timestamp without time zone,
    browser varchar(64),
    os varchar(64),
    os_version varchar(16),
    agent varchar(64),
    device varchar(64),
    --last_login timestamp DEFAULT NULL::timestamp without time zone,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_vine_user_action PRIMARY KEY (vine_user_action_id),
    CONSTRAINT fk_vine_user FOREIGN KEY (vine_user_id) REFERENCES vine_user (vine_user_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

ALTER TABLE public.vine_user_action OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.vine_user_action TO "V1n3Us3r";

-- table: vine_user_parameter

--DROP TABLE public.vine_user_parameter;

CREATE TABLE public.vine_user_parameter (
    parameter_name varchar(255) NOT NULL,
    vine_user_id int4 NOT NULL,
    parameter_type varchar(64) NOT NULL,
    parameter_value varchar(255) NOT NULL,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_vine_user_parameter PRIMARY KEY (parameter_name, vine_user_id),
    CONSTRAINT fk_vine_user_parameter_user FOREIGN KEY (vine_user_id) REFERENCES public.vine_user (vine_user_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

ALTER TABLE public.vine_user_parameter OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.vine_user_parameter TO "V1n3Us3r";

--table: vine_role

--DROP TABLE public.vine_role;

CREATE TABLE public.vine_role (
    vine_role_id serial NOT NULL,
    role_name varchar(255) NOT NULL,
    short_role_name varchar(64) NOT NULL,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_vine_role PRIMARY KEY (vine_role_id),
    CONSTRAINT uq_vine_role_name UNIQUE (role_name)
) WITH (OIDS=FALSE);

ALTER TABLE public.vine_role OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.vine_role TO "V1n3Us3r";

--table: vine_permission

--DROP TABLE public.vine_permission;

CREATE TABLE public.vine_permission (
    vine_permission_id serial NOT NULL,
    permission_name varchar(255) NOT NULL,
    short_permission_name varchar(64) NOT NULL,
    permission_key varchar(100) NOT NULL DEFAULT '-',
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_vine_permission PRIMARY KEY (vine_permission_id),
    CONSTRAINT uq_vine_permission_key UNIQUE (permission_key)
) WITH (OIDS=FALSE);

ALTER TABLE public.vine_permission OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.vine_permission TO "V1n3Us3r";

--table: mtm_role2permission

--DROP TABLE public.mtm_role2permission;

CREATE TABLE public.mtm_role2permission (
    vine_role_id int4 NOT NULL,
    vine_permission_id int4 NOT NULL,
    enabled_fl int4 DEFAULT 0 NOT NULL,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_mtm_role2permission PRIMARY KEY (vine_role_id, vine_permission_id),
    CONSTRAINT fk_mtm_role2permission_role FOREIGN KEY (vine_role_id) REFERENCES public.vine_role (vine_role_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_mtm_role2permission_permission FOREIGN KEY (vine_permission_id) REFERENCES public.vine_permission (vine_permission_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

ALTER TABLE public.mtm_role2permission OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.mtm_role2permission TO "V1n3Us3r";


--table: mtm_user2role

--DROP TABLE public.mtm_user2role;

CREATE TABLE public.mtm_user2role (
    vine_user_id int4 NOT NULL,
    vine_role_id int4 NOT NULL,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_mtm_user2role PRIMARY KEY (vine_user_id, vine_role_id),
    CONSTRAINT fk_mtm_user2role_user FOREIGN KEY (vine_user_id) REFERENCES public.vine_user (vine_user_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_mtm_user2role_role FOREIGN KEY (vine_role_id) REFERENCES public.vine_role (vine_role_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

ALTER TABLE public.mtm_user2role OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.mtm_user2role TO "V1n3Us3r";

--table: account

--DROP TABLE public.account;

CREATE TABLE public.account (
    account_id SERIAL NOT NULL,
    account_address TEXT NOT NULL,
    account_username TEXT NOT NULL,
    account_details JSONB,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_account PRIMARY KEY (account_id)
) WITH (OIDS=FALSE);

ALTER TABLE public.account OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.account TO "V1n3Us3r";

--table: collection

--DROP TABLE public.collection;

CREATE TABLE public.collection (
    collection_id SERIAL NOT NULL,
    slug TEXT NOT NULL,
    collection_name TEXT NOT NULL,
    collection_url TEXT,
    collection_details JSONB,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_collection PRIMARY KEY (collection_id)
) WITH (OIDS=FALSE);

ALTER TABLE public.collection OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.collection TO "V1n3Us3r";


--table: bundle

--DROP TABLE public.bundle;

CREATE TABLE public.bundle (
    bundle_id SERIAL NOT NULL,
    slug TEXT NOT NULL,
    bundle_name TEXT NOT NULL,
    bundle_url TEXT,
    sale_fl INT4 DEFAULT 0 NOT NULL,
    bundle_details JSONB,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_bundle PRIMARY KEY (bundle_id)
) WITH (OIDS=FALSE);

ALTER TABLE public.bundle OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.bundle TO "V1n3Us3r";


--table: asset

--DROP TABLE public.asset;

CREATE TABLE public.asset (
    asset_id SERIAL NOT NULL,
    token_id TEXT NOT NULL,
    token_name TEXT NOT NULL,
    image_url TEXT,
    original_image_url TEXT,
    external_link TEXT,
    background_color INT4,
    contract_address TEXT,
    contract_type TEXT,
    contract_datetime_created timestamp DEFAULT NULL::timestamp without time zone,
    contract_name TEXT,
    contract_nft_version TEXT,
    contract_schema_name TEXT,
    contract_symbol TEXT,
    asset_details JSONB,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_asset PRIMARY KEY (asset_id)
) WITH (OIDS=FALSE);

ALTER TABLE public.asset OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.asset TO "V1n3Us3r";


--table: mtm_asset2collection

--DROP TABLE public.mtm_asset2collection;

CREATE TABLE public.mtm_asset2collection (
    asset_id INT4 NOT NULL,
    collection_id INT4 NOT NULL,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_mtm_asset2collection PRIMARY KEY (asset_id, collection_id),
    CONSTRAINT fk_mtm_asset2collection_asset FOREIGN KEY (asset_id) REFERENCES public.asset (asset_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_mtm_asset2collection_collection FOREIGN KEY (collection_id) REFERENCES public.collection (collection_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

ALTER TABLE public.mtm_asset2collection OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.mtm_asset2collection TO "V1n3Us3r";


--table: mtm_asset2bundle

--DROP TABLE public.mtm_asset2bundle;

CREATE TABLE public.mtm_asset2bundle (
    asset_id INT4 NOT NULL,
    bundle_id INT4 NOT NULL,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_mtm_asset2bundle PRIMARY KEY (asset_id, bundle_id),
    CONSTRAINT fk_mtm_asset2bundle_asset FOREIGN KEY (asset_id) REFERENCES public.asset (asset_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_mtm_asset2bundle_bundle FOREIGN KEY (bundle_id) REFERENCES public.bundle (bundle_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

ALTER TABLE public.mtm_asset2bundle OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.mtm_asset2bundle TO "V1n3Us3r";


--table: asset_event

--DROP TABLE public.asset_event;

CREATE TABLE public.asset_event (
    asset_event_id SERIAL NOT NULL,
    event_type TEXT NOT NULL,
    auction_type TEXT,
    asset_id INT4 NOT NULL,
    bundle_id INT4,
    account_from INT4,
    account_to INT4,
    payment_token TEXT,
    quantity NUMERIC,
    total_price DOUBLE PRECISION,
    datetime_event timestamp DEFAULT NULL::timestamp without time zone,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_asset_event PRIMARY KEY (asset_event_id),
    CONSTRAINT fk_asset_event_asset FOREIGN KEY (asset_id) REFERENCES public.asset (asset_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_asset_event_bundle FOREIGN KEY (bundle_id) REFERENCES public.bundle (bundle_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_asset_event_account_to FOREIGN KEY (account_to) REFERENCES public.account (account_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_asset_event_account_from FOREIGN KEY (account_from) REFERENCES public.account (account_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

ALTER TABLE public.asset_event OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.asset_event TO "V1n3Us3r";

--table: mtm_user2account

--DROP TABLE public.mtm_user2account;

CREATE TABLE public.mtm_user2account (
    vine_user_id INT4 NOT NULL,
    account_id INT4 NOT NULL,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_mtm_user2account PRIMARY KEY (vine_user_id, account_id),
    CONSTRAINT fk_mtm_user2account_user FOREIGN KEY (vine_user_id) REFERENCES public.vine_user (vine_user_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_mtm_user2account_account FOREIGN KEY (account_id) REFERENCES public.account (account_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

ALTER TABLE public.mtm_user2account OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.mtm_user2account TO "V1n3Us3r";

--table: asset_right

--DROP TABLE public.asset_right;

CREATE TABLE public.asset_right (
    asset_right_id SERIAL NOT NULL,
    right_type TEXT NOT NULL,
    asset_id INT4 NOT NULL,
    bundle_id INT4,
    vine_user_id INT4,
    right_formula DOUBLE PRECISION,
    verified_fl INT4 DEFAULT 0 NOT NULL,
    datetime_verified timestamp DEFAULT NULL::timestamp without time zone,
    verified_by INT4,
    note varchar(250) DEFAULT '-' NOT NULL,
    active_fl int4 DEFAULT 1 NOT NULL,
    datetime_added timestamp DEFAULT (now())::timestamp without time zone,
    added_by varchar(255) DEFAULT '0'::character varying,
    datetime_modified timestamp DEFAULT NULL::timestamp without time zone,
    modified_by varchar(255) DEFAULT NULL::character varying,
    datetime_deleted timestamp DEFAULT NULL::timestamp without time zone,
    deleted_by varchar(255) DEFAULT NULL::character varying,
    CONSTRAINT pk_asset_right PRIMARY KEY (asset_right_id),
    CONSTRAINT fk_asset_right_asset FOREIGN KEY (asset_id) REFERENCES public.asset (asset_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_asset_right_bundle FOREIGN KEY (bundle_id) REFERENCES public.bundle (bundle_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_asset_right_user FOREIGN KEY (vine_user_id) REFERENCES public.vine_user (vine_user_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

ALTER TABLE public.asset_right OWNER TO "V1n3Us3r";
GRANT ALL ON TABLE public.asset_right TO "V1n3Us3r";