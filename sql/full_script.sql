DROP TABLE torture_log;
DROP TABLE torture_type;
DROP TABLE case_log;
DROP TABLE accusation_investigative_case;
DROP TABLE violation;
DROP TABLE investigative_case;
DROP TABLE accusation_record;
DROP TABLE accusation;
DROP TABLE inquisition_process;
DROP TABLE church;
DROP TABLE prison;
DROP TABLE bible_commandment;
DROP TABLE bible;
DROP TABLE commandment;
DROP TABLE locality;
DROP TABLE official;
DROP TABLE punishment;
DROP TABLE person;
DROP TYPE gender;
DROP TYPE case_log_result;
DROP TYPE case_log_status;

CREATE TABLE locality(
	id serial PRIMARY KEY,
	name varchar(255) NOT NULL, 
	foundation_date date
);

CREATE TABLE church(
	id serial PRIMARY KEY,
	name varchar(255) NOT NULL,
	foundation_date date,
	locality_id integer REFERENCES locality(id) ON DELETE CASCADE
);

CREATE TABLE prison(
	id serial PRIMARY  KEY,
	name varchar(255) NOT NULL,
	locality_id integer REFERENCES locality(id) ON DELETE CASCADE
);

CREATE TABLE bible(
	version integer PRIMARY KEY,
	publication_date date,
	name varchar(255) NOT NULL
);

CREATE TABLE commandment(
	id serial PRIMARY KEY,
	description text NOT NULL UNIQUE
);

CREATE TABLE bible_commandment(
	bible_id integer REFERENCES bible(version) ON DELETE CASCADE,
	comandment_id integer REFERENCES commandment(id) ON DELETE RESTRICT,
	PRIMARY KEY(bible_id, comandment_id)
);

CREATE TYPE gender as enum ('М', 'Ж');

CREATE TABLE person(
	id serial PRIMARY KEY,
	name varchar(255) NOT NULL,
	birth_date date NOT NULL,
	person_gender gender NOT NULL
);

CREATE TABLE official(
	id serial PRIMARY KEY,
	person_id integer REFERENCES person(id) ON DELETE CASCADE,
	official_name varchar(255) NOT NULL,
	employment_date date NOT NULL,
	fired_date date
);

CREATE TABLE inquisition_process(
	id serial PRIMARY KEY,
	start_data date NOT NULL,
	finish_data date,
	official_id integer REFERENCES official(id) ON DELETE RESTRICT,
	church_id integer REFERENCES church(id) ON DELETE RESTRICT,
	bible_id integer REFERENCES bible(version) ON DELETE RESTRICT,
	CHECK (finish_data IS NULL OR start_data < finish_data)
);

CREATE TABLE accusation(
	id serial PRIMARY KEY,
	informer integer REFERENCES person(id) ON DELETE RESTRICT,
	bishop integer REFERENCES official(id) ON DELETE RESTRICT,
	inquisition_process_id integer REFERENCES inquisition_process(id) ON DELETE CASCADE
);

CREATE TABLE accusation_record(
	id serial PRIMARY KEY,
	violation_place varchar(255),
	accused integer REFERENCES person(id) ON DELETE RESTRICT,
	date_time timestamp NOT NULL,
	description text,
	id_accusation integer REFERENCES accusation(id) ON DELETE CASCADE
);

CREATE TABLE investigative_case(
	id serial PRIMARY KEY,
	creation_date date NOT NULL,
	closed_date date,
	CHECK (closed_date IS NULL OR creation_date < closed_date)
);

CREATE TABLE accusation_investigative_case(
	case_id integer REFERENCES investigative_case(id) ON DELETE CASCADE,
	record_id integer REFERENCES accusation_record(id) ON DELETE RESTRICT,
	PRIMARY KEY(case_id, record_id)
);

CREATE TABLE punishment(
	id serial PRIMARY KEY,
	name varchar(255) NOT NULL,
	description text
);

CREATE TYPE case_log_result as enum ('Признание вины', 'Отрицание вины');
CREATE TYPE case_log_status as enum ('Пыточный процесс', 'Исправительная беседа', 'Наказание');

CREATE TABLE case_log(
	id serial PRIMARY KEY,
	case_id integer REFERENCES investigative_case(id) ON DELETE RESTRICT,
	case_status case_log_status NOT NULL,
	principal integer REFERENCES official(id) ON DELETE RESTRICT,
	start_time timestamp NOT NULL,
	result case_log_result,
	prison_id integer REFERENCES prison(id) ON DELETE RESTRICT,
	finish_time timestamp,
	punishment_id integer REFERENCES punishment(id) ON DELETE RESTRICT,
	description text,
	UNIQUE(case_id, case_status),
	CHECK (finish_time IS NULL OR start_time < finish_time)
);

CREATE TABLE violation(
	commandment_id integer REFERENCES commandment(id) ON DELETE RESTRICT,
	case_id integer REFERENCES investigative_case(id) ON DELETE CASCADE,
	PRIMARY KEY(commandment_id, case_id)
);

CREATE TABLE torture_type(
	id serial PRIMARY KEY,
	name varchar(255) NOT NULL,
	description text
);

CREATE TABLE torture_log(
	case_log_id integer REFERENCES case_log(id) ON DELETE CASCADE,
	type_id integer REFERENCES torture_type(id) ON DELETE RESTRICT,
	executor integer REFERENCES official(id) ON DELETE RESTRICT,
	victim integer REFERENCES person(id) ON DELETE RESTRICT,
	PRIMARY KEY(case_log_id, type_id)
);
