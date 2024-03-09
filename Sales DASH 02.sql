
//* ALTERAR TABELA/COLUNA DBO.CHANNEL *//
UPDATE DBO.channels
SET tipo_canal_venda = 'Sistema Interno'
WHERE tipo_canal_venda = 'OWN CHANNEL'


//* ALTERAR TABELA/COLUNA DBO.deliveries *//
SELECT*
FROM DBO.deliveries

UPDATE DBO.deliveries
SET delivery_status = 'Entregue'
WHERE delivery_status = 'DELIVERED'

UPDATE DBO.deliveries
SET delivery_status = 'Rota de Entrega'
WHERE delivery_status = 'DELIVERING'

UPDATE DBO.deliveries
SET delivery_status = 'Cancelado'
WHERE delivery_status = 'CANCELLED'



//* ALTERAR TABELA/COLUNA  DBO.drivers */
SELECT *
FROM DBO.drivers

UPDATE DBO.drivers
SET driver_type = 'Operador Logístico'
WHERE driver_type = 'LOGISTIC OPERATOR'

//* ALTERAR TABELA/COLUNA  DBO.hubs */

SELECT*
FROM DBO.hubs

ALTER TABLE  DBO.hubs
DROP COLUMN hub_longitude;


//* ALTERAR TABELA/COLUNA  DBO.orders *//
SELECT*
FROM DBO.orders

ALTER TABLE  DBO.orders
DROP COLUMN order_created_hour;


ALTER TABLE  DBO.orders
DROP COLUMN order_created_minute;


ALTER TABLE  DBO.orders
DROP COLUMN order_created_day;


ALTER TABLE  DBO.orders
DROP COLUMN order_created_month;


ALTER TABLE  DBO.orders
DROP COLUMN order_created_year;

//* ALTERAR TABELA/COLUNA  DBO.payments *//

SELECT distinct payment_method
FROM DBO.payments

UPDATE DBO.payments
SET payment_method = 'Cartão de Crédito Loja'
WHERE payment_method = 'INSTALLMENT_CREDIT_STORE'

UPDATE DBO.payments
SET payment_method = 'Cartão de Crédito Loja'
WHERE payment_method = 'CREDIT_STORE'

UPDATE DBO.payments
SET payment_method = 'Cartão de Crédito'
WHERE payment_method = 'Credit'

UPDATE DBO.payments
SET payment_method = 'Cartão de Débito'
WHERE payment_method = 'Debit'

UPDATE DBO.payments
SET payment_method = 'Cartão de Débito Loja'
WHERE payment_method = 'DEBIT_STORE'


UPDATE DBO.payments
SET payment_method = 'Dinheiro'
WHERE payment_method = 'MONEY'

UPDATE DBO.payments
SET payment_method = 'Aproximação'
WHERE payment_method = 'APROXIMAÇÃO'

UPDATE DBO.payments
SET payment_method = 'PIX'
WHERE payment_method = 'BANK_TRANSFER_DC'

UPDATE DBO.payments
SET payment_method = 'PGTO POR LINK'
WHERE payment_method = 'PAYMENT_LINK'

UPDATE DBO.payments
SET payment_method = 'Vale-Refeição'
WHERE payment_method = 'VALE-REFEIÇÃO'

UPDATE DBO.payments
SET payment_method = 'PGTO por Link'
WHERE payment_method = 'PGTO POR LINK'

UPDATE DBO.payments
SET payment_method = 'Voucher'
WHERE payment_method = 'VOUCHER'

//* ALTERAR TABELA/COLUNA DBO.payments *//

UPDATE DBO.payments
SET payment_status = 'AGUARDANDO'
WHERE payment_status = 'AWAITING'

UPDATE DBO.payments
SET payment_status = 'ESTORNADO'
WHERE payment_status = 'CHARGEBACK'








//* ALTERAR TABELA/COLUNA  DBO.hubs *//

SELECT*
FROM DBO.hubs







//*dbo. DRIVERS - Qtde. de categorias de entrega
2 categorias, motoboy e biker *//
SELECT DISTINCT driver_modal
FROM dbo.drivers

//*dbo. DRIVERS -Qtde. de funcionarios = 4824 *//

SELECT distinct COUNT (cast(driver_id as int)) as 'qtde de entregadores'
FROM dbo.drivers

//* qtde. de MOTOBOY =  3222  *//

SELECT distinct COUNT (cast(driver_id as int)) as 'qtde de entregadores'
FROM dbo.drivers
WHERE DRIVER_MODAL = 'MOTOBOY'

//* qtde. de BIKERS =  1602 *//

SELECT distinct COUNT (cast(driver_id as int)) as 'qtde de entregadores'
FROM dbo.drivers
WHERE DRIVER_MODAL = 'biker'

//* QTDE. por regime de contratação = 
Qtde. de regimes de contratação = Logistic Operator and Freelance *//
SELECT distinct driver_type
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

//*
biker LO= 1
*//

SELECT COUNT (driver_id)
FROM dbo.drivers
WHERE driver_modal = 'Biker' AND driver_type = 'Operador Logístico'

//*
biker FREE= 1601
*//

SELECT COUNT (driver_id)
FROM dbo.drivers
WHERE driver_modal = 'Biker' AND driver_type = 'FREELANCE'

//*dbo. CHANNELS - Qtde. de canais de vendas = 40 *//

SELECT COUNT (CAST(id_canal_venda AS INT)) AS 'Qtde. de canais de vendas'
FROM dbo.channels

//*dbo. CHANNELS - categorias CANAIS DE VENDAS, se é OWN CHANNEL ou marketplace*//

SELECT distinct tipo_canal_venda
FROM dbo.channels

//*dbo. CHANNELS - QTDE. marketplace AND OWN CHANNEL*//

//*marketplace= 26 *//

SELECT distinct COUNT (tipo_canal_venda) 
FROM dbo.channels
WHERE tipo_canal_venda = 'MARKETPLACE'

//*Sistema Interno= 14 *//

SELECT distinct COUNT (tipo_canal_venda) 
FROM dbo.channels
WHERE tipo_canal_venda = 'Sistema Interno'


//*- dbo.DELIVERIES - ENTREGAS = QTDE. ENTREGUES X CANCELADAS*//

//*Tipos de entregas = DELIVERED , CANCELLED ,  DELIVERING *//
SELECT COUNT (delivery_order_id) , delivery_status
FROM DBO.DELIVERIES 
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
FROM DBO.DELIVERIES
WHERE delivery_status = 'rota de entrega'

//*PORCENTAGEM DE CADA UMA DELAS EM RELAÇÃO AO TOTAL *//
//* % de todas juntas na mesma query*//

SELECT COUNT(p.delivery_id) , p.delivery_status,
cast( COUNT(p.delivery_id) / tmp.total *100.00 as numeric (10,2))
FROM DBO.deliveries p , (select cast (count(delivery_id) as numeric (10,2)) total FROM DBO.deliveries) tmp
GROUP BY p.delivery_status, tmp.total

//* % de Delivered em relação ao total*//

SELECT COUNT(p.delivery_id) , p.delivery_status,
cast( COUNT(p.delivery_id) / tmp.total *100.00 as numeric (10,2))
FROM DBO.deliveries p , (select cast (count(delivery_id) as numeric (10,2)) total FROM DBO.deliveries) tmp
WHERE p.delivery_status = 'Entregue'
GROUP BY p.delivery_status, tmp.total

//* % de Cancelled em relação ao total*//

SELECT COUNT (P.delivery_id), P.delivery_status,
CAST(COUNT(P.delivery_id) / tmp.total *100.00 AS numeric (10,2))
FROM dbo.deliveries P,
(SELECT CAST (COUNT	(deliverY_id) AS NUMERIC (10,2)) total
FROM dbo.deliveries) tmp
WHERE P.delivery_status = 'Cancelado'
GROUP BY p.delivery_status, tmp.total

//* % de Delivering em relação ao total*//

SELECT COUNT (P.delivery_id), P.delivery_status,
CAST(COUNT(P.delivery_id) / tmp.total *100.00 AS numeric (10,2))
FROM dbo.deliveries P,
(SELECT CAST (COUNT	(deliverY_id) AS NUMERIC (10,2)) total
FROM dbo.deliveries) tmp
WHERE P.delivery_status = 'Rota de Entrega'
GROUP BY p.delivery_status, tmp.total


//* dbo.HUBS - LOCAL ONDE TEM UMA STORE E CADA STORE TEM SEU NOME E CADA HUB TAMBÉM
 - LEGAL FAZER UM FILTRO NO POWER COM OS HUBS *//

//*Qtde. de HUBS = 32 e quais são *//
SELECT COUNT (hub_id) , hub_name
FROM DBO.HUBS
group by hub_name

//* dbo.orders - qtde vendas, faturamento, *//

//* quantidade de ORDERS / VENDAS
368999 VENDAS*//

SELECT COUNT (order_id)
FROM dbo.orders

//* FATURAMENTO STATUS TOTAL = order_amount = 38.800.730,73 *//
//* FATURAMENTO STATUS FINALIZADO = order_amount = 35.293.230,28 *//
//* FATURAMENTO STATUS CANCELADOS = order_amount = 3.507.500,45 *//

SELECT ORDER_STATUS , SUM (CAST (ORDER_AMOUNT AS DECIMAL (10,2))) as Impostos
FROM dbo.orders
GROUP BY order_status




//* impostos pagos pelos clientes = order_delivery_fee= 2.280.009,54 *//
//* impostos pagos pelos clientes /finalizados = order_delivery_fee= 2.188.128,69 *//
//* impostos pagos pelos clientes / cancelados = order_delivery_fee= 91.880,85 *//
//* legal tambem ver no pwoer bi por store e por hub por estado etc*//

SELECT ORDER_STATUS , SUM (CAST (order_delivery_fee AS DECIMAL (10,2)))
FROM dbo.orders
GROUP BY order_status





//*dbo.payments categorias / tipos de meios de pagamentos compras cenladaas e finalizadas, tudo junto, status do pagamento *//

//*meios de pagamentos*//
SELECT distinct payment_method
FROM DBO.payments

//*payments_status
3 tipos = PAID , AWAITING , CHARGEBACK-ESTORNO *//

SELECT distinct payment_status
FROM DBO.payments

//*quantidade de vendas por cada meio de pagamento e se foi finalizada ou canceladas*//
//* ORDER AMOUNT =ORDERS , MEIO DE PAGAMENTO = PAYMENTS, STATUS DA COMPRA - ORDERS , STATUS DO PAGAMENTO PAYMENTS*//

SELECT ORDER_AMOUNT , ORDER_STATUS , PAYMENT_METHOD , PAYMENT_STATUS , P.payment_order_id
FROM dbo.orders P
INNER JOIN dbo.payments B ON P.payment_order_id = B.payment_order_id

