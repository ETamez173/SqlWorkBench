


CREATE TABLE employee(emp_id SERIAL PRIMARY  KEY,
name VARCHAR(30),
STATUS text,
phone_num VARCHAR(12),
process_fk INT NOT NULL);

CREATE TABLE process(emp_id SERIAL PRIMARY KEY, SECTION VARCHAR(20));

ALTER TABLE employee ADD FOREIGN KEY (process_fk)
REFERENCES process(emp_id) ON DELETE CASCADE;



INSERT INTO process(SECTION) VALUES ('distribution');
INSERT INTO process(SECTION) VALUES ('curing');
INSERT INTO Process(SECTION) VALUES ('technology');


INSERT INTO employee(name,STATUS,phone_num,process_fk)
VALUES('joemarie','regular','0985959905','1'),
('shakhira','probationary','093948889487','2'),
('hyle','regular','095599093490','1'),
('kobe','probationary','097867556451','3'),
('nasty','regular','094458909099','2'),
('arianne','regular','097746890988','2');

SELECT * FROM employee;


SELECT * FROM process;


DELETE FROM process WHERE SECTION='distribution';







