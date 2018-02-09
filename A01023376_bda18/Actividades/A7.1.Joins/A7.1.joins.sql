/*
     AARON ZAJAC
     A01023376
     GitHub: aarzh
*/
SELECT distinct productLine FROM orders JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber JOIN products ON orderdetails.productCode = products.productCode WHERE customerNumber = 112;
-- faltan explain
SELECT distinct productLine FROM orders JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber JOIN products ON orderdetails.productCode = products.productCode WHERE customerNumber = 112;
--quedo el segundo join
create index indice on orderdetails (productCode)
-- falta explain
SELECT distinct productLine FROM orders JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber JOIN products ON orderdetails.productCode = products.productCode WHERE customerNumber = 112;
-- ya quedo
