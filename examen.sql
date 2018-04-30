create table LOG_FILM(
	id int not null,
    tipo varchar (7),
    Film_id int not null,
    Last_value int,
    New_value int,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    primary key(id)
)

DELIMITER //
CREATE PROCEDURE nuevo
(IN tipo_a CHAR(7),
	IN Last_Val int,
    in New_val int)
BEGIN
	Update LOG_FILM
    set
		tipo = tipo_a,
        Last_value = Last_Val,
        New_value = New_val;
END //
DELIMITER ;

DELIMITER //
create trigger insert_data
after update on film for each row
Begin
	CALL nuevo(tipo, LV, NV);
end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updLang()
  BEGIN
    DECLARE idf int;
    DECLARE listo int;
    DECLARE curs1 CURSOR FOR SELECT film_id FROM film;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET listo = true;

    OPEN curs1;
    rloop: LOOP
      FETCH curs1 INTO idf;
      IF done THEN
        LEAVE rloop;
      END IF;

      IF (SELECT COUNT(*) FROM film_actor WHERE film_id = idf AND actor_id=3) = 1 THEN
        # ED CHASE(3) then mandarin(4)
        UPDATE film SET original_language_id=4 WHERE film_id = idf;

        ELSEIF (SELECT COUNT(*) FROM film_actor WHERE film_id = idf AND actor_id=31) = 1 THEN
          # SOBIESKI(31) then german(6)
          UPDATE film SET original_language_id=6 WHERE film_id = idf;ELSEIF (SELECT category_id FROM film_category WHERE film_id = idf) = 6 THEN
        # Documentary(6) then italian(2)

        UPDATE film SET original_language_id=2 WHERE film_id = idf;
      ELSEIF (SELECT category_id FROM film_category WHERE film_id = idf) = 9 THEN
        # Foreign(9) then japanese(3)
        UPDATE film SET original_language_id=3 WHERE film_id = idf;

      ELSEIF (SELECT COUNT(*) FROM film_actor WHERE film_id = idf AND actor_id=34) = 1 THEN
        # AUDREY OLIVIER(34) then french(5)
        UPDATE film SET original_language_id=5 WHERE film_id = idf;

      ELSE

        # Else english then 1
        UPDATE film SET original_language_id=1 WHERE film_id = idf;
      END IF;
    END LOOP;
    CLOSE curs1;
  END //
DELIMITER ;

CALL updLang();



/*

                    DB2
*/
CREATE TABLE Candy(
  id INT NOT NULL (START WITH 1, INCREMENT BY 1),
  nombre VARCHAR(150) NOT NULL,
  precio DECIMAL(10,6) NOT NULL,
  fechaI DATE NOT NULL,
  fechaF DATE NOT NULL,
  period business_time(fechaI, fechaF),
  PRIMARY KEY(ID, business_time WITHOUT overlaps)
);

INSERT INTO Candy (nombre, precio, fechaI, FechaF) VALUES
  ('panditas', 3, '2018-1-1', '2019-1-1'),
  ('Gomilocas', 3, '2018-1-1', '2019-1-1'),
  ('dientes', 4, '2018-1-1', '2019-1-1'),
  ('pinguinos', 4, '2018-1-1', '2019-1-1'),
  ('letras', 5, '2018-1-1', '2019-1-1'),
  ('leones', 5, '2018-1-1', '2019-1-1'),
  ('palomas', 6, '2018-1-1', '2019-1-1'),
  ('pajaro', 6, '2018-1-1', '2019-1-1'),
  ('cuervo', 7, '2018-1-1', '2019-1-1'),
  ('tigre', 7, '2018-1-1', '2019-1-1'),
  ('cachorro', 8, '2018-1-1', '2019-1-1'),
  ('twinky', 9, '2018-1-1', '2019-1-1');

UPDATE Candy
FOR PORTION OF BUSINESS_TIME FROM '2018-2-1' to '2019-1-1'
  SET precio = precio*1.45;

UPDATE Candy
FOR PORTION OF BUSINESS_TIME FROM '2018-2-15' to '2019-1-1'
  SET precio = (precio/1.45)*1.1;

UPDATE Candy
FOR PORTION OF BUSINESS_TIME FROM '2018-4-25' to '2019-1-1'
  SET precio = precio*1.45;

UPDATE Candy
FOR PORTION OF BUSINESS_TIME FROM '2018-5-5' to '2019-1-1'
  SET precio = (precio/1.45)*1.1;

UPDATE Candy
FOR PORTION OF BUSINESS_TIME FROM '2018-10-25' to '2019-1-1'
  SET precio = precio*1.45;

UPDATE Candy
FOR PORTION OF BUSINESS_TIME FROM '2018-11-5' to '2019-1-1'
  SET precio = (precio/1.45)*1.1;

SELECT * from Candy WHERE NAME='panditas';

SELECT SUM(precio)/COUNT(*) as AVG from Candy WHERE NAME='panditas';

SELECT MAX(precio) as MAX from Candy WHERE NAME='panditas';

SELECT MIN(precio) as MAX from Candy WHERE NAME='panditas';
