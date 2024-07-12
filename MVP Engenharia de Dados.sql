-- Databricks notebook source
-- MAGIC %md
-- MAGIC Selecionar todos os dados da tabela "restaurant_customer_satisfaction"

-- COMMAND ----------

select * from restaurant_customer_satisfaction_csv

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Quantidade de clientes altamente satisfeitos e não altamente satisfeitos e médias de avaliação:

-- COMMAND ----------

SELECT
DISTINCT count(CustomerID) as Customers,
IF(HighSatisfaction = 1, "Highly Satisfied", "Not Highly Satisfied") as Satisfaction,
CAST(AVG(WaitTime) as DECIMAL(10,2)) as Average_Wait_Time,
CAST(AVG(ServiceRating) as DECIMAL(10,2)) as Average_Service_Rating,
CAST(AVG(FoodRating) as DECIMAL(10,2)) as Average_Food_Rating,
CAST(AVG(AmbianceRating) as DECIMAL(10,2)) as Average_Ambiance_Rating,
CAST((AVG(ServiceRating) + AVG(FoodRating) + AVG(AmbianceRating))/3 as DECIMAL(10,2)) as General_Average_Rating
FROM restaurant_customer_satisfaction_csv
GROUP BY HighSatisfaction
ORDER BY General_Average_Rating DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Análise do turno por avaliação dos clientes em geral e tempo médio de espera:

-- COMMAND ----------

SELECT
TimeOfVisit,
CAST(AVG(WaitTime) as DECIMAL(10,2)) as Average_Wait_Time,
CAST(AVG(ServiceRating) as DECIMAL(10,2)) as Average_Service_Rating,
CAST(AVG(FoodRating) as DECIMAL(10,2)) as Average_Food_Rating,
CAST(AVG(AmbianceRating) as DECIMAL(10,2)) as Average_Ambiance_Rating,
CAST((AVG(ServiceRating) + AVG(FoodRating) + AVG(AmbianceRating))/3 as DECIMAL(10,2)) as General_Average_Rating
FROM restaurant_customer_satisfaction_csv
GROUP BY TimeOfVisit
ORDER BY General_Average_Rating DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Médias de avaliação dos clientes altamente satisfeitos por turno de visitação:

-- COMMAND ----------

SELECT
TimeOfVisit,
CAST(AVG(WaitTime) as DECIMAL(10,2)) as Average_Wait_Time,
CAST(AVG(ServiceRating) as DECIMAL(10,2)) as Average_Service_Rating,
CAST(AVG(FoodRating) as DECIMAL(10,2)) as Average_Food_Rating,
CAST(AVG(AmbianceRating) as DECIMAL(10,2)) as Average_Ambiance_Rating,
CAST((AVG(ServiceRating) + AVG(FoodRating) + AVG(AmbianceRating))/3 as DECIMAL(10,2)) as General_Average_Rating
FROM restaurant_customer_satisfaction_csv
WHERE HighSatisfaction = 1
GROUP BY TimeOfVisit
ORDER BY General_Average_Rating DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Médias de avaliação dos clientes não altamente satisfeitos por turno de visitação:

-- COMMAND ----------

SELECT
TimeOfVisit,
CAST(AVG(WaitTime) as DECIMAL(10,2)) as Average_Wait_Time,
CAST(AVG(ServiceRating) as DECIMAL(10,2)) as Average_Service_Rating,
CAST(AVG(FoodRating) as DECIMAL(10,2)) as Average_Food_Rating,
CAST(AVG(AmbianceRating) as DECIMAL(10,2)) as Average_Ambiance_Rating,
CAST((AVG(ServiceRating) + AVG(FoodRating) + AVG(AmbianceRating))/3 as DECIMAL(10,2)) as General_Average_Rating
FROM restaurant_customer_satisfaction_csv
WHERE HighSatisfaction = 0
GROUP BY TimeOfVisit
ORDER BY General_Average_Rating DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Como os clientes frequentam o restaurante?

-- COMMAND ----------

SELECT
VisitFrequency,
count(CustomerID) as Customers
FROM restaurant_customer_satisfaction_csv
GROUP BY VisitFrequency
ORDER BY 2 DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Qual é a culinária preferida dos clientes, de forma geral?

-- COMMAND ----------

SELECT
PreferredCuisine,
count(CustomerID) as Customers
FROM restaurant_customer_satisfaction_csv
GROUP BY PreferredCuisine
ORDER BY 2 DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Qual é a culinária preferida dos clientes que frequentam o estabelecimento diariamente ou semanalmente?

-- COMMAND ----------

SELECT
PreferredCuisine,
count(CustomerID) as Customers
FROM restaurant_customer_satisfaction_csv
WHERE VisitFrequency = "Daily" or VisitFrequency = "Weekly"
GROUP BY PreferredCuisine
ORDER BY 2 DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Qual é a culinária preferida dos membros do programa de fidelidade?

-- COMMAND ----------

SELECT
PreferredCuisine,
count(CustomerID) as Customers
FROM restaurant_customer_satisfaction_csv
WHERE LoyaltyProgramMember = 1
GROUP BY PreferredCuisine
ORDER BY 2 DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Qual é a culinária preferida para os membros do programa de fidelidade que frequentam diariamente ou semanalmente?

-- COMMAND ----------

SELECT
PreferredCuisine,
count(CustomerID) as Customers
FROM restaurant_customer_satisfaction_csv
WHERE LoyaltyProgramMember = 1 and VisitFrequency = "Daily" or VisitFrequency = "Weekly"
GROUP BY PreferredCuisine
ORDER BY 2 DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Com que frequência os membros do programa de fidelidade frequentam o estabelecimento e quanto gastam em média por visita?

-- COMMAND ----------

SELECT
VisitFrequency,
avg(AverageSpend),
count(CustomerID) as Customers
FROM restaurant_customer_satisfaction_csv
WHERE LoyaltyProgramMember = 1
GROUP BY VisitFrequency
ORDER BY 3 DESC
