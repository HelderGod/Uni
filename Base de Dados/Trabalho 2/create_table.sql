DROP TABLE IF EXISTS animals CASCADE;
CREATE TABLE animals (
  name VARCHAR(100),
  register DECIMAL PRIMARY KEY,
  sex VARCHAR(10),
  birthday DATE,
  habitat VARCHAR(100),
);

DROP TABLE IF EXISTS bio_class CASCADE;
CREATE TABLE bio_class (
  classes VARCHAR(50),
  orders VARCHAR(50),
  family VARCHAR(50),
  species VARCHAR(50)
);

-------------------------------------------------------------------------------------

DROP TABLE IF EXISTS animals_place CASCADE;
CREATE TABLE animals_place (
  coords VARCHAR(2) PRIMARY KEY,
  area DECIMAL,
  atmosphere VARCHAR(100),
  environment VARCHAR(100)
);

-------------------------------------------------------------------------------------

DROP TABLE IF EXISTS employees CASCADE;
CREATE TABLE employees (
  name VARCHAR(100),
  nif DECIMAL PRIMARY KEY,
  start DATE,
  cellphone DECIMAL UNIQUE,
  telephone DECIMAL UNIQUE
);

DROP TABLE IF EXISTS keepers CASCADE;
CREATE TABLE keepers (
  animal_name VARCHAR(100),
  animal_register DECIMAL PRIMARY KEY,
  FOREIGN KEY (animal_register) REFERENCES animals ON DELETE RESTRICT,
  employee_name VARCHAR(100),
  employee_nif DECIMAL,
  FOREIGN KEY (employee_nif) REFERENCES employees ON DELETE RESTRICT
);

DROP TABLE IF EXISTS auxiliar_keepers CASCADE;
CREATE TABLE auxiliar_keepers (
  place_coords VARCHAR(2),
  FOREIGN KEY (place_coords) REFERENCES animals_place ON DELETE RESTRICT,
  employee_name VARCHAR(100),
  employee_nif DECIMAL PRIMARY KEY,
  FOREIGN KEY (employee_nif) REFERENCES employees ON DELETE RESTRICT
);

DROP TABLE IF EXISTS vets CASCADE;
CREATE TABLE vets (
  employee_name VARCHAR(100),
  employee_nif DECIMAL PRIMARY KEY,
  FOREIGN KEY (employee_nif) REFERENCES employees ON DELETE RESTRICT
);

DROP TABLE IF EXISTS consults CASCADE;
CREATE TABLE consults (
  employee_nif DECIMAL PRIMARY KEY,
  FOREIGN KEY (employee_nif) REFERENCES vets ON DELETE RESTRICT,
  animal_register DECIMAL,
  FOREIGN KEY (animal_register) REFERENCES animals ON DELETE RESTRICT
);

DROP TABLE IF EXISTS diagnosis CASCADE;
CREATE TABLE diagnosis (
  animal_register DECIMAL,
  FOREIGN KEY (animal_register) REFERENCES animals ON DELETE RESTRICT,
  employee_nif DECIMAL PRIMARY KEY,
  FOREIGN KEY (employee_nif) REFERENCES consults ON DELETE RESTRICT,
  time DATE,
  diagnostic VARCHAR(50)
);

DROP TABLE IF EXISTS treatment CASCADE;
CREATE TABLE treatment (
  animal_register DECIMAL,
  FOREIGN KEY (animal_register) REFERENCES animals ON DELETE RESTRICT,
  employee_nif DECIMAL PRIMARY KEY,
  FOREIGN KEY (employee_nif) REFERENCES consults ON DELETE RESTRICT,
  time DATE,
  cure VARCHAR(50)
);