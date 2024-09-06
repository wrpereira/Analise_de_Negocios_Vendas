
--Alterar conteúdo da coluna dbo.channels

UPDATE dbo.channels
SET tipo_canal_venda = 'Sistema Interno'
WHERE tipo_canal_venda = 'OWN CHANNEL'

--Alterar conteúdo da coluna dbo.deliveries

UPDATE dbo.deliveries
SET delivery_status = 'Entregue'
WHERE delivery_status = 'DELIVERED'

UPDATE dbo.deliveries
SET delivery_status = 'Rota de Entrega'
WHERE delivery_status = 'DELIVERING'

UPDATE dbo.deliveries
SET delivery_status = 'Cancelado'
WHERE delivery_status = 'CANCELLED'

--Alterar conteúdo da coluna dbo.drivers

UPDATE dbo.drivers
SET driver_type = 'Operador Logístico'
WHERE driver_type = 'LOGISTIC OPERATOR'

--Alterar tabela da coluna dbo.hubs

SELECT*
ALTER TABLE  dbo.hubs
DROP COLUMN hub_longitude

--Alterar tabela da coluna dbo.orders

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

--Qtde. de meios payment_method

SELECT DISTINCT payment_method
FROM dbo.payments

--Alterar conteúdo da coluna dbo.payments

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

UPDATE dbo.payments
SET payment_status = 'AGUARDANDO'
WHERE payment_status = 'AWAITING'

UPDATE dbo.payments
SET payment_status = 'ESTORNADO'
WHERE payment_status = 'CHARGEBACK'

--Tipos de entregadores

SELECT DISTINCT driver_modal
FROM dbo.drivers

--Qtde. total de entregadores

SELECT DISTINCT COUNT (cast(driver_id as int)) as 'qtde de entregadores'
FROM dbo.drivers

--Qtde. total de MOTOBOY

SELECT DISTINCT COUNT (cast(driver_id as int)) as 'qtde total de MOTOBOY'
FROM dbo.drivers
WHERE DRIVER_MODAL = 'MOTOBOY'

--Qtde. total de BIKER

SELECT DISTINCT COUNT (cast(driver_id as int)) as 'qtde total de BIKER'
FROM dbo.drivers
WHERE DRIVER_MODAL = 'BIKER'

--Tipos de regime de contratação

SELECT DISTINCT driver_type
FROM dbo.drivers

--Qtde. total de entregadores por regime de contratação
-- MOTOBOY - Operador Logístico

SELECT COUNT (driver_id)
FROM dbo.drivers
WHERE driver_modal = 'MOTOBOY' AND driver_type = 'Operador Logístico'

-- MOTOBOY - Freelance

SELECT COUNT (driver_id)
FROM dbo.drivers
WHERE driver_modal = 'MOTOBOY' AND driver_type = 'FREELANCE'

-- BIKER - Operador Logístico

SELECT COUNT (driver_id)
FROM dbo.drivers
WHERE driver_modal = 'BIKER' AND driver_type = 'Operador Logístico'

-- BIKER - Operador Logístico

SELECT COUNT (driver_id)
FROM dbo.drivers
WHERE driver_modal = 'BIKER' AND driver_type = 'FREELANCE'

--Qtde. total de canais de vendas

SELECT COUNT (CAST(id_canal_venda AS INT)) AS 'Qtde. de canais de vendas'
FROM dbo.channels

--Tipos de categorias de canais de vendas

SELECT DISTINCT tipo_canal_venda
FROM dbo.channels

--Qtde. total de canais de vendas por tipo
--MARKETPLACE

SELECT DISTINCT COUNT (tipo_canal_venda) 
FROM dbo.channels
WHERE tipo_canal_venda = 'MARKETPLACE'

--Sistema Interno

SELECT DISTINCT COUNT (tipo_canal_venda) 
FROM dbo.channels
WHERE tipo_canal_venda = 'Sistema Interno'

-- Tipos de entregas = Entregue , Cancelado e Rota de Entrega

SELECT COUNT (delivery_order_id) , delivery_status
FROM dbo.deliveries		 
GROUP BY delivery_status

--Qtde. total de Entregas

SELECT COUNT (delivery_order_id)
FROM DBO.DELIVERIES

-- Qtde. de Entregas Entregue

SELECT COUNT (delivery_status)
FROM DBO.DELIVERIES
WHERE delivery_status = 'Entregue'

-- Qtde. de Entregas Canceladas

SELECT COUNT (delivery_status)
FROM DBO.DELIVERIES
WHERE delivery_status = 'Cancelado'

--Qtde. de Entregas em Rota de Entrega

SELECT COUNT (delivery_status)
FROM dbo.deliveries
WHERE delivery_status = 'Rota de Entrega'

-- % de representatividade de cada tipo de status de entrega em relação ao total de Entregas

SELECT COUNT(p.delivery_id) , p.delivery_status,
CAST( COUNT(p.delivery_id) / tmp.total *100.00 as numeric (10,2))
FROM dbo.deliveries p , (SELECT CAST (COUNT(delivery_id) as numeric (10,2)) total FROM dbo.deliveries) tmp
GROUP BY p.delivery_status, tmp.total

-- % de Entregas com status Entregue em relação ao total

SELECT COUNT(p.delivery_id) , p.delivery_status,
CAST( COUNT(p.delivery_id) / tmp.total *100.00 as numeric (10,2))
FROM dbo.deliveries p , (SELECT CAST (COUNT(delivery_id) as numeric (10,2)) total FROM dbo.deliveries) tmp
WHERE p.delivery_status = 'Entregue'
GROUP BY p.delivery_status, tmp.total

-- % de Entregas com status cancelado em relação ao total

SELECT COUNT(p.delivery_id) , p.delivery_status,
CAST( COUNT(p.delivery_id) / tmp.total *100.00 as numeric (10,2))
FROM dbo.deliveries p , (SELECT CAST (COUNT(delivery_id) as numeric (10,2)) total FROM dbo.deliveries) tmp
WHERE p.delivery_status = 'Cancelado'
GROUP BY p.delivery_status, tmp.total

-- % de Entregas com status Rota de Entrega em relação ao total

SELECT COUNT(p.delivery_id) , p.delivery_status,
CAST( COUNT(p.delivery_id) / tmp.total *100.00 as numeric (10,2))
FROM dbo.deliveries p , (SELECT CAST (COUNT(delivery_id) as numeric (10,2)) total FROM dbo.deliveries) tmp
WHERE p.delivery_status = 'Rota de Entrega'
GROUP BY p.delivery_status, tmp.total

--Qtde. total de HUBS

SELECT COUNT (hub_id) , hub_name
FROM dbo.hubs
group by hub_name


--Qtde. total de Orders / Pedidos

SELECT COUNT (order_id)
FROM dbo.orders

--Faturamento total de acordo com o total de pagamentos e status de pagamento

SELECT payment_status , SUM (CAST (payment_amount as decimal (10,2))) as Faturamento
FROM dbo.payments
GROUP BY payment_status

--Total de impostos pagos pelos clientes de acordo com o status do pagamento

SELECT payment_status , SUM (CAST (payment_fee as real)) as Impostos
FROM dbo.payments
GROUP BY payment_status

--Tipos de meios de pagamentos

SELECT DISTINCT payment_method
FROM dbo.payments

--Tipos de status de pagamento

SELECT DISTINCT payment_status
FROM dbo.payments

--Resumo de status do pedido, meio de pagamento,  status de pagamento e valor pago

SELECT  P.payment_order_id, order_status , payment_method , payment_status, payment_amount  
FROM dbo.orders P
INNER JOIN dbo.payments B ON P.payment_order_id = B.payment_order_id