
//* ALTERAR TABELA/COLUNA DBO.CHANNEL *//
UPDATE DBO.channels
SET tipo_canal_venda = 'Sistema Interno'
WHERE tipo_canal_venda = 'OWN CHANNEL'


//* ALTERAR TABELA/COLUNA DBO.deliveries *//
SELECT*
FROM dbo.deliveries

UPDATE dbo.deliveries
SET delivery_status = 'Entregue'
WHERE delivery_status = 'DELIVERED'

UPDATE dbo.deliveries
SET delivery_status = 'Rota de Entrega'
WHERE delivery_status = 'DELIVERING'

UPDATE dbo.deliveries
SET delivery_status = 'Cancelado'
WHERE delivery_status = 'CANCELLED'


//* ALTERAR TABELA/COLUNA  DBO.drivers */
SELECT *
FROM dbo.drivers

UPDATE dbo.drivers
SET driver_type = 'Operador Logístico'
WHERE driver_type = 'LOGISTIC OPERATOR'

//* ALTERAR TABELA/COLUNA  DBO.hubs */

SELECT*
FROM dbo.hubs

ALTER TABLE  dbo.hubs
DROP COLUMN hub_longitude


//* ALTERAR TABELA/COLUNA  dbo.orders *//
SELECT*
FROM dbo.orders

ALTER TABLE  dbo.orders
DROP COLUMN order_created_hour;


ALTER TABLE  dbo.orders
DROP COLUMN order_created_minute;


ALTER TABLE dbo.orders
DROP COLUMN order_created_day;


ALTER TABLE  dbo.orders
DROP COLUMN order_created_month;


ALTER TABLE  dbo.orders
DROP COLUMN order_created_year;

//* ALTERAR TABELA/COLUNA  dbo.payments *//

SELECT distinct payment_method
FROM dbo.payments

UPDATE dbo.payments
SET payment_method = 'Cartão de Crédito Loja'
WHERE payment_method = 'INSTALLMENT_CREDIT_STORE'

UPDATE dbo.payments
SET payment_method = 'Cartão de Crédito Loja'
WHERE payment_method = 'CREDIT_STORE'

UPDATE dbo.payments
SET payment_method = 'Cartão de Crédito'
WHERE payment_method = 'Credit'

UPDATE dbo.payments
SET payment_method = 'Cartão de Débito'
WHERE payment_method = 'Debit'

UPDATE dbo.payments
SET payment_method = 'Cartão de Débito Loja'
WHERE payment_method = 'DEBIT_STORE'


UPDATE dbo.payments
SET payment_method = 'Dinheiro'
WHERE payment_method = 'MONEY'

UPDATE dbo.payments
SET payment_method = 'Aproximação'
WHERE payment_method = 'APROXIMAÇÃO'

UPDATE dbo.payments
SET payment_method = 'PIX'
WHERE payment_method = 'BANK_TRANSFER_DC'

UPDATE dbo.payments
SET payment_method = 'PGTO POR LINK'
WHERE payment_method = 'PAYMENT_LINK'

UPDATE dbo.payments
SET payment_method = 'Vale-Refeição'
WHERE payment_method = 'VALE-REFEIÇÃO'

UPDATE dbo.payments
SET payment_method = 'PGTO por Link'
WHERE payment_method = 'PGTO POR LINK'

UPDATE dbo.payments
SET payment_method = 'Voucher'
WHERE payment_method = 'VOUCHER'

//* ALTERAR TABELA/COLUNA dbo.payments *//

UPDATE dbo.payments
SET payment_status = 'AGUARDANDO'
WHERE payment_status = 'AWAITING'

UPDATE dbo.payments
SET payment_status = 'ESTORNADO'
WHERE payment_status = 'CHARGEBACK'


//* ALTERAR TABELA/COLUNA  dbo.hubs *//

SELECT*
FROM dbo.hubs


//*dbo. DRIVERS - Qtde. de categorias de entrega
2 categorias, motoboy e biker *//

SELECT DISTINCT driver_modal
FROM dbo.drivers

//*dbo. DRIVERS -Qtde. de funcionarios = 4824 *//

SELECT DISTINCT COUNT (cast(driver_id as int)) as 'qtde de entregadores'
FROM dbo.drivers

//* qtde. de MOTOBOY =  3222  *//

SELECT DISTINCT COUNT (cast(driver_id as int)) as 'qtde de entregadores'
FROM dbo.drivers
WHERE DRIVER_MODAL = 'MOTOBOY'

//* qtde. de BIKERS =  1602 *//

SELECT DISTINCT COUNT (cast(driver_id as int)) as 'qtde de entregadores'
FROM dbo.drivers
WHERE DRIVER_MODAL = 'Biker'

//* QTDE. por regime de contratação = 
Qtde. de regimes de contratação = Logistic Operator and Freelance *//
SELECT DISTINCT driver_type
FROM dbo.drivers
//*
motoboy LO= 884 *//
SELECT COUNT (driver_id)
FROM dbo.drivers
WHERE driver_modal = 'MOTOBOY' AND driver_type = 'Operador Logístico'

//*
motoboy FREE= 2338
*//
SELECT COUNT (driver_id)
FROM dbo.drivers
WHERE driver_modal = 'MOTOBOY' AND driver_type = 'Freelance'

//* biker LO= 1 *//

SELECT COUNT (driver_id)
FROM dbo.drivers
WHERE driver_modal = 'Biker' AND driver_type = 'Operador Logístico'

//* biker FREE= 1601 *//

SELECT COUNT (driver_id)
FROM dbo.drivers
WHERE driver_modal = 'Biker' AND driver_type = 'FREELANCE'

//*dbo. CHANNELS - Qtde. de canais de vendas = 40 *//

SELECT COUNT (CAST(id_canal_venda AS INT)) AS 'Qtde. de canais de vendas'
FROM dbo.channels

//*dbo. CHANNELS - categorias CANAIS DE VENDAS, se é OWN CHANNEL ou marketplace*//

SELECT DISTINCT tipo_canal_venda
FROM dbo.channels

//*dbo. CHANNELS - QTDE. marketplace AND OWN CHANNEL*//

//*marketplace= 26 *//

SELECT DISTINCT COUNT (tipo_canal_venda) 
FROM dbo.channels
WHERE tipo_canal_venda = 'MARKETPLACE'

//*Sistema Interno= 14 *//

SELECT DISTINCT COUNT (tipo_canal_venda) 
FROM dbo.channels
WHERE tipo_canal_venda = 'Sistema Interno'


//*- dbo.DELIVERIES - ENTREGAS = QTDE. ENTREGUES X CANCELADAS*//

//*Tipos de entregas = DELIVERED , CANCELLED ,  DELIVERING *//
SELECT COUNT (delivery_order_id) , delivery_status
FROM dbo.deliveries		 
GROUP BY delivery_status

//*Qtde. total de entregas = 378843 *//

SELECT COUNT (delivery_order_id)
FROM DBO.DELIVERIES

//*Qtde. DELIVERED de entregas feitas = 371367 *//

SELECT COUNT (delivery_status)
FROM DBO.DELIVERIES
WHERE delivery_status = 'Entregue'

//*Qtde. CANCELLED de entregas canceladas = 7253 *//

SELECT COUNT (delivery_status)
FROM DBO.DELIVERIES
WHERE delivery_status = 'Cancelado'

//*Qtde. DELIVERING em rota de entrega / ainda não chegaram no cliente = 223 *//

SELECT COUNT (delivery_status)
FROM dbo.deliveries
WHERE delivery_status = 'rota de entrega'

//*PORCENTAGEM DE CADA UMA DELAS EM RELAÇÃO AO TOTAL *//
//* % de todas juntas na mesma query*//

SELECT COUNT(p.delivery_id) , p.delivery_status,
cast( COUNT(p.delivery_id) / tmp.total *100.00 as numeric (10,2))
FROM dbo.deliveries p , (select cast (count(delivery_id) as numeric (10,2)) total FROM dbo.deliveries) tmp
GROUP BY p.delivery_status, tmp.total

//* % de Delivered em relação ao total*//

SELECT COUNT(p.delivery_id) , p.delivery_status,
cast( COUNT(p.delivery_id) / tmp.total *100.00 as numeric (10,2))
FROM dbo.deliveries p , (select cast (count(delivery_id) as numeric (10,2)) total FROM dbo.deliveries) tmp
WHERE p.delivery_status = 'Entregue'
GROUP BY p.delivery_status, tmp.total

//* % de Cancelled em relação ao total*//

SELECT COUNT (P.delivery_id), P.delivery_status,
CAST(COUNT(P.delivery_id) / tmp.total *100.00 AS NUMERIC (10,2))
FROM dbo.deliveries P,
(SELECT CAST (COUNT	(deliverY_id) AS NUMERIC (10,2)) total
FROM dbo.deliveries) tmp
WHERE P.delivery_status = 'Cancelado'
GROUP BY p.delivery_status, tmp.total

//* % de Delivering em relação ao total*//

SELECT COUNT (P.delivery_id), P.delivery_status,
CAST(COUNT(P.delivery_id) / tmp.total *100.00 AS NUMERIC (10,2))
FROM dbo.deliveries P,
(SELECT CAST (COUNT	(deliverY_id) AS NUMERIC (10,2)) total
FROM dbo.deliveries) tmp
WHERE P.delivery_status = 'Rota de Entrega'
GROUP BY p.delivery_status, tmp.total


//* dbo.HUBS - LOCAL ONDE TEM UMA STORE E CADA STORE TEM SEU NOME E CADA HUB TAMBÉM
 - LEGAL FAZER UM FILTRO NO POWER COM OS HUBS *//

//*Qtde. de HUBS = 32 e quais são *//
SELECT COUNT (hub_id) , hub_name
FROM dbo.hubs
group by hub_name

//* dbo.orders - qtde vendas, faturamento, *//

//* quantidade de ORDERS / VENDAS*//

SELECT COUNT (order_id)
FROM dbo.orders


//* Faturamento total de acordo com o payment e status *//

SELECT payment_status , SUM (CAST (payment_amount AS DECIMAL (10,2))) as Faturamento
FROM dbo.payments
GROUP BY payment_status


//* Total de impostos pagos pelos clientes de acordo com o status do pagamento *//

SELECT payment_status , SUM (CAST (payment_fee AS REAL)) as Impostos
FROM dbo.payments
GROUP BY payment_status


//*dbo.payments categorias / tipos de meios de pagamentos compras cenladaas e finalizadas, tudo junto, status do pagamento *//

//*meios de pagamentos*//
SELECT DISTINCT payment_method
FROM dbo.payments

//*payments_status
3 tipos = pago , aguardando , estornado *//

SELECT DISTINCT payment_status
FROM dbo.payments

//*quantidade de vendas por cada meio de pagamento e se foi finalizada ou canceladas*//
//* ORDER AMOUNT =ORDERS , MEIO DE PAGAMENTO = PAYMENTS, STATUS DA COMPRA - ORDERS , STATUS DO PAGAMENTO PAYMENTS*//

SELECT  P.payment_order_id, order_status , payment_method , payment_status, payment_amount  
FROM dbo.orders P
INNER JOIN dbo.payments B ON P.payment_order_id = B.payment_order_id