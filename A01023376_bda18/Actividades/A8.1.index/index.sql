orderLineNumber
(quantityOrdered, orderLineNumber)
(orderLineNumber, quantityOrdered)
(orderLineNumber, quantityOrdered) USING HASH

select * from orderdetails force index(nombre) where orderLineNumber = 1 and quantityOrdered > 50
select productCode from orderdetails force index(nombre) where orderLineNumber = 1 and quantityOrdered > 50
select orderLineNumber count(*) from orderdetails force index(nombre) where orderLineNumber = 1 and quantityOrdered > 50
Group by orderLineNumber

create procedure demo_cursor()
    begin
    declare ids int;
    declare done int default FALSE;
    declare cursor1 corsor for select actor_id from actor;
    declare continue handler
        for not found
        set done = true;

    open cursor1;
    read_loop: LOOP
        fetch cursor1 int ids;
        if done then
            leave read_loop;
        end if;
    end loop;
        select ids;
    close cursor1;
end
