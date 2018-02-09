create trigger update_despedidos after delete on employee referencing old as
old_values for each row mode db2sql begin atomic update estadisticasA set empDespedidos = empDespedidos +1; end

create trigger update_salario before update on employee referencing old as old_values for each row mode db2sql when(salary >= 1.30 * salary) begin atomic signal sqlstate '56001' ('Error'); end
