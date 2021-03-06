CREATE TABLE IF NOT EXISTS students (
    id                  SERIAL PRIMARY KEY,
    version             INT4 NOT NULL DEFAULT(0),
    name                VARCHAR NOT NULL,
    address             VARCHAR,
    phone               VARCHAR NOT NULL,
    email               VARCHAR NOT NULL,
    record_book_number  INT4 NOT NULL,
    avg_performance     REAL
);

CREATE TABLE IF NOT EXISTS courses (
    id                  SERIAL PRIMARY KEY,
    version             INT4 NOT NULL DEFAULT(0),
    title               VARCHAR NOT NULL,
    number              INT4 NOT NULL,
    price               REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS students_courses (
    id                  SERIAL PRIMARY KEY,
    student_id          INT4 NOT NULL,
    course_id           INT4 NOT NULL,
    final_mark          REAL
);

CREATE TABLE IF NOT EXISTS professors (
    id                  SERIAL PRIMARY KEY,
    version             INT4 NOT NULL DEFAULT(0),
    name                VARCHAR NOT NULL,
    address             VARCHAR,
    phone               VARCHAR,
    payment             REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS professors_courses (
    professor_id        INT4 NOT NULL,
    course_id           INT4 NOT NULL
);

CREATE TABLE IF NOT EXISTS completing_courses (
    id                  SERIAL PRIMARY KEY,
    version             INT4 NOT NULL DEFAULT(0),
    student_id          INT4 NOT NULL,
    course_id           INT4 NOT NULL,
    mark                INT4 NOT NULL
);

ALTER TABLE students            ADD CONSTRAINT student_phone_unique         UNIQUE (phone);
ALTER TABLE students            ADD CONSTRAINT email_unique                 UNIQUE (email);
ALTER TABLE students            ADD CONSTRAINT record_book_number_unique    UNIQUE (record_book_number);
ALTER TABLE courses             ADD CONSTRAINT number_unique                UNIQUE (number);
ALTER TABLE students_courses    ADD CONSTRAINT students_courses_unique      UNIQUE (student_id, course_id);
ALTER TABLE professors          ADD CONSTRAINT professor_phone_unique       UNIQUE (phone);
ALTER TABLE professors_courses  ADD CONSTRAINT professors_courses_unique    UNIQUE (professor_id, course_id);

ALTER TABLE students_courses    ADD CONSTRAINT fk_sc_student_id             FOREIGN KEY (student_id)        REFERENCES students (id);
ALTER TABLE students_courses    ADD CONSTRAINT fk_sc_course_id              FOREIGN KEY (course_id)         REFERENCES courses (id);
ALTER TABLE professors_courses  ADD CONSTRAINT fk_pc_student_id             FOREIGN KEY (professor_id)      REFERENCES professors (id);
ALTER TABLE professors_courses  ADD CONSTRAINT fk_pc_course_id              FOREIGN KEY (course_id)         REFERENCES courses (id);
ALTER TABLE completing_courses  ADD CONSTRAINT fk_cc_student_id             FOREIGN KEY (student_id)        REFERENCES students (id);
ALTER TABLE completing_courses  ADD CONSTRAINT fk_cc_course_id              FOREIGN KEY (course_id)         REFERENCES courses (id);
