delimiter $$
create procedure show_products(
    IN linea_producto varchar(50))
BEGIN
    declare line varchar(50);

    set line = concat(linea_producto, "%");
    select * from products where productLine like line;
END $$
delimiter ;

delimiter $$
create procedure showName(
    IN lineaCliente varchar(50))
BEGIN
    declare line varchar(50);
    set line = concat(lineaCliente, "%");
    select * from customers where lineaCliente like line;
END $$
delimiter ;

delimiter $$
create procedure showCost()
BEGIN
    select * from products ORDER BY buyPrice ASC limit 1;
    select * from products ORDER BY buyPrice DESC limit 1;
END $$
delimiter ;
