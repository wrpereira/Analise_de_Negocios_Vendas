# 1- Qual o número de hubs por cidade?

SELECT COUNT (DISTINCT hub_id) AS num_stores, hub_city
FROM hubs
GROUP BY hub_city
ORDER BY num_stores desc


# 2- Qual o número de pedidos (orders) por status?

SELECT COUNT (order_id) AS num_pedidos, order_status
FROM orders
GROUP BY order_status;

# 3- Qual o número de lojas (stores) por cidade dos hubs?


SELECT COUNT (DISTINCT S.store_id) AS num_lojas , hub_city
from stores S INNER JOIN hubs H ON S.hub_id = H.hub_id
GROUP BY hub_city
ORDER BY num_lojas DESC;

# 4- Qual o maior e o menor valor de pagamento (payment_amount) registrado?

SELECT MAX(payment_amount)
FROM payments;

SELECT MIN(payment_amount)
FROM payments;

# 5- Qual tipo de driver (driver_type) fez o maior número de entregas?


SELECT COUNT (DELIVERY_ID) AS num_entregas,  V.driver_type
FROM deliveries D INNER JOIN drivers V ON 
D.driver_id = V.driver_id
WHERE D.driver_id = V.driver_id
GROUP BY V.driver_type
ORDER BY num_entregas DESC;



# 6- Qual a distância média das entregas por tipo de driver (driver_modal)?


SELECT AVG (CAST(delivery_distance_meters AS BIGINT)) AS media_distancia, V.driver_modal
FROM deliveries D INNER JOIN drivers V ON 
D.driver_id = V.driver_id
WHERE D.driver_id = V.driver_id
GROUP BY V.driver_modal;



# 7- Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?


SELECT S.store_name, ROUND(AVG(CAST(order_amount AS REAL)),2) AS media_pedido
FROM orders O INNER JOIN stores S ON
O.store_id = S.store_id
WHERE O.store_id = S.store_id
GROUP BY S.store_name
ORDER BY media_pedido DESC;


# 8- Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?


SELECT COALESCE (S.store_name, 'sem loja'), COUNT(order_id) AS num_pedidos
FROM orders O LEFT JOIN stores S ON
O.store_id = S.store_id
WHERE O.store_id = S.store_id
GROUP BY S.store_name
ORDER BY num_pedidos DESC;



# 9- Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?

select*
from orders;

select*
from channels;

SELECT C.nome_canal_venda, SUM(CAST(O.order_amount AS REAL)) AS total_vendas
FROM orders O LEFT JOIN channels C ON
O.channel_id = C.id_canal_venda
WHERE C.nome_canal_venda = 'FOOD PLACE'
GROUP BY C.nome_canal_venda;

SELECT SUM(CAST(O.order_amount AS REAL)) AS total_vendas
FROM orders O INNER JOIN channels C ON
O.channel_id = C.id_canal_venda
WHERE O.channel_id = C.id_canal_venda AND C.nome_canal_venda = 'FOOD PLACE';


# 10- Quantos pagamentos foram cancelados (chargeback)?


SELECT payment_status, COUNT (payment_id) AS CONTAGEM
FROM payments
WHERE payment_status = 'ESTORNADO'
GROUP BY payment_status;

# 11- Qual foi o valor médio dos pagamentos cancelados (chargeback)?

SELECT  payment_status, ROUND(AVG(CAST(payment_amount AS REAL)),2) as media_cancelados
FROM payments
WHERE payment_status = 'ESTORNADO'
GROUP BY  payment_status;

# 12- Qual a média do valor de pagamento por método de pagamento (payment_method)
em ordem decrescente?

SELECT payment_method, ROUND(AVG(CAST(payment_amount AS REAL)),2) AS media_pagamento
FROM payments
GROUP BY payment_method
ORDER BY media_pagamento DESC;

# 13- Quais métodos de pagamento tiveram valor médio superior a 100?

SELECT payment_method, AVG(CAST(payment_amount AS real)) AS valor_medio_pgto
FROM payments
GROUP BY payment_method
HAVING AVG(CAST(payment_amount AS real)) > 100;

# 14- Qual a média de valor de pedido (order_amount) por estado do hub (hub_state),
segmento da loja (store_segment) e tipo de canal (channel_type)?

select*
from orders;
select*
from hubs;
select*
from stores;
select*
from channels;



SELECT AVG (order_amount)
FROM






# 15- Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal
(channel_type) teve média de valor de pedido (order_amount) maior que 450?
# 16- Qual o valor total de pedido (order_amount) por estado do hub (hub_state),
segmento da loja (store_segment) e tipo de canal (channel_type)? Demonstre os totais
intermediários e formate o resultado.
# 17- Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja
'FOOD', tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido
(order_amount)?
# 18- Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi
cancelado, algum hub_state teve total de valor do pedido superior a 100.000?
# 19- Em que data houve a maior média de valor do pedido (order_amount)? Dica:
Pesquise e use a função SUBSTRING().
# 20- Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)? Dica:
Use a função SUBSTRING().