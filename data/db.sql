--
-- ** setting up example tables and data **
-- 
-- 

CREATE TABLE task (
  id BIGSERIAL ,
  name TEXT,
  parent_id BIGINT REFERENCES task(id),
  PRIMARY KEY (id)
);


SELECT pg_catalog.setval('task_id_seq', 1, false);

INSERT INTO task VALUES (1, 'task1', NULL);
INSERT INTO task VALUES (2, 'task2', NULL);
INSERT INTO task VALUES (3, 'task3', NULL);
INSERT INTO task VALUES (4, 'task1-1', 1);
INSERT INTO task VALUES (5, 'task1-2', 1);
INSERT INTO task VALUES (6, 'task1-3', 1);
INSERT INTO task VALUES (7, 'task2-1', 2);
INSERT INTO task VALUES (8, 'task2-2', 2);
INSERT INTO task VALUES (9, 'task2-3', 2);
INSERT INTO task VALUES (10, 'task3-1', 3);
INSERT INTO task VALUES (11, 'task3-2', 3);
INSERT INTO task VALUES (12, 'task3-3', 3);
INSERT INTO task VALUES (13, 'task1-3-1', 6);
INSERT INTO task VALUES (14, 'task1-3-1-1', 13);


CREATE TABLE employees (
  employee_id BIGSERIAL,
  last_name TEXT,
  manager_id BIGINT REFERENCES employees(employee_id),
  PRIMARY KEY (employee_id)  
);

SELECT pg_catalog.setval('employees_employee_id_seq', 1, false);

INSERT INTO employees VALUES (100, 'King', NULL);
INSERT INTO employees VALUES (101, 'Kochhar', 100);

INSERT INTO employees VALUES (108, 'Greenberg', 101);
INSERT INTO employees VALUES (200, 'Whalen', 101);
INSERT INTO employees VALUES (203, 'Mavris', 101);
INSERT INTO employees VALUES (204, 'Baer', 101);
INSERT INTO employees VALUES (205, 'Higgins', 101);

INSERT INTO employees VALUES (109, 'Faviet', 108);
INSERT INTO employees VALUES (110, 'Chen', 108);
INSERT INTO employees VALUES (111, 'Sciarra', 108);
INSERT INTO employees VALUES (112, 'Urman', 108);
INSERT INTO employees VALUES (113, 'Popp', 108);
INSERT INTO employees VALUES (206, 'Gietz', 205);


CREATE TABLE empsalary (
  empno BIGSERIAL PRIMARY KEY,
  depname TEXT,
  location TEXT,
  salary DECIMAL
);

INSERT INTO empsalary VALUES (11, 'develop', 'fi', 5200);
INSERT INTO empsalary VALUES (7, 'develop', 'fi', 4200);
INSERT INTO empsalary VALUES (9, 'develop', 'fi', 4500);
INSERT INTO empsalary VALUES (8, 'develop', 'fi', 6000);
INSERT INTO empsalary VALUES (10, 'develop', 'se', 5200);
INSERT INTO empsalary VALUES (5, 'personnel', 'fi', 3500);
INSERT INTO empsalary VALUES (2, 'personnel', 'fi', 3900);
INSERT INTO empsalary VALUES (3, 'sales', 'se', 4800);
INSERT INTO empsalary VALUES (1, 'sales', 'se', 5000);
INSERT INTO empsalary VALUES (4, 'sales', 'se', 4800);
 

CREATE TABLE emp_phone (
  emp_id BIGINT REFERENCES employees(employee_id),
  emp_phone_num VARCHAR(20),
  UNIQUE(emp_id, emp_phone_num)  
);

INSERT INTO emp_phone VALUES (101, '555-123');
INSERT INTO emp_phone VALUES (101, '555-234');
INSERT INTO emp_phone VALUES (101, '555-345');
INSERT INTO emp_phone VALUES (108, '555-111');
INSERT INTO emp_phone VALUES (205, '555-914');
INSERT INTO emp_phone VALUES (205, '555-222');
INSERT INTO emp_phone VALUES (109, '555-987');

CREATE TABLE emp_sm_contact (
  emp_id BIGINT,
  contact_type VARCHAR(20),
  contact TEXT,
  UNIQUE (emp_id, contact_type)
);


INSERT INTO emp_sm_contact VALUES (100, 'twitter', 'beking');
INSERT INTO emp_sm_contact VALUES (100, 'linkedIn', 'b.king');
INSERT INTO emp_sm_contact VALUES (100, 'g+', 'bking');
INSERT INTO emp_sm_contact VALUES (101, 'twitter', 'kochhar');
INSERT INTO emp_sm_contact VALUES (101, 'linkedIn', 'kochhar.1');
INSERT INTO emp_sm_contact VALUES (101, 'g+', 'kochhar.2');
INSERT INTO emp_sm_contact VALUES (200, 'twitter', 'whalen');



create or replace view outreach  as 
select contact_type, contact, last_name 
from emp_sm_contact, employees
where emp_sm_contact.emp_id = employees.employee_id;3