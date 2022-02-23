#=============================================================================================================
#Esta tabla muestra todos los datos de las 4 tablas en una sola de 62,587 datos
CREATE OR REPLACE VIEW insurance_table AS
SELECT plan_subs.plan_id, plan_subs.user_id, users.gender, users.date_of_birth, plan_subs.subscription_date,
	   TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) AS plan_age,
	   plan_prices.annual_price_of_plan, claim_report_date, claims_reports.claim_amount
FROM users, plan_prices, plan_subs LEFT OUTER JOIN claims_reports
ON plan_subs.plan_id = claims_reports.plan_id 
WHERE plan_subs.user_id = users.user_id 
AND plan_prices.age = TIMESTAMPDIFF(YEAR, users.date_of_birth, plan_subs.subscription_date)
AND plan_prices.gender = users.gender
ORDER BY plan_subs.plan_id;

SELECT * FROM insurance_table; #LIMIT 62587;
#=============================================================================================================

#El plan con menor edad es de 20 años y el mayor es de 62 años

#=============================================================================================================
#Esta tabla muestra todos los datos de las 4 tablas en una sola de 62,587 datos
CREATE OR REPLACE VIEW insurance_table_1 AS
SELECT plan_subs.plan_id, plan_subs.user_id, users.gender, users.date_of_birth, 
       plan_subs.subscription_date,
	   TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) AS plan_age,
       CASE WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 20 AND 24 THEN '20-24'
			WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 25 AND 29 THEN '25-29'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 30 AND 34 THEN '30-34'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 35 AND 39 THEN '35-39'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 40 AND 44 THEN '40-44'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 45 AND 49 THEN '45-49'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 50 AND 54 THEN '50-54'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 55 AND 59 THEN '55-59'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 60 AND 64 THEN '60-64'
            END AS age_group,
	   plan_prices.annual_price_of_plan, claim_report_date, claims_reports.claim_amount
FROM users, plan_prices, plan_subs LEFT OUTER JOIN claims_reports
ON plan_subs.plan_id = claims_reports.plan_id 
WHERE plan_subs.user_id = users.user_id 
AND plan_prices.age = TIMESTAMPDIFF(YEAR, users.date_of_birth, plan_subs.subscription_date)
AND plan_prices.gender = users.gender
ORDER BY plan_subs.plan_id;

SELECT * FROM insurance_table_1; #LIMIT 62587;
#=============================================================================================================

#=============================================================================================================
#Esta tabla muestra todos los datos de las 4 tablas en una sola de 62,587 datos
CREATE OR REPLACE VIEW insurance_table_2 AS
SELECT plan_subs.plan_id, plan_subs.user_id, users.gender, users.date_of_birth, 
       plan_subs.subscription_date,
	   TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) AS plan_age,
       CASE WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 20 AND 24 THEN '20-24'
			WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 25 AND 29 THEN '25-29'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 30 AND 34 THEN '30-34'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 35 AND 39 THEN '35-39'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 40 AND 44 THEN '40-44'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 45 AND 49 THEN '45-49'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 50 AND 54 THEN '50-54'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 55 AND 59 THEN '55-59'
            WHEN TIMESTAMPDIFF(YEAR, users.date_of_birth,plan_subs.subscription_date) BETWEEN 60 AND 64 THEN '60-64'
            END AS age_group,
	   plan_prices.annual_price_of_plan, claim_report_date, claims_reports.claim_amount,
       (claim_amount/annual_price_of_plan) AS claim_plan
FROM users, plan_prices, plan_subs LEFT OUTER JOIN claims_reports
ON plan_subs.plan_id = claims_reports.plan_id 
WHERE plan_subs.user_id = users.user_id 
AND plan_prices.age = TIMESTAMPDIFF(YEAR, users.date_of_birth, plan_subs.subscription_date)
AND plan_prices.gender = users.gender
ORDER BY plan_subs.plan_id;

SELECT * FROM insurance_table_2 LIMIT 62586;
#=============================================================================================================

SELECT * FROM insurance_table_2 ORDER BY claim_plan DESC;

SELECT * FROM insurance_table_1 ORDER BY claim_amount DESC;

SELECT * FROM insurance_table_1 WHERE age_group = '25-29' 
AND claim_amount < (SELECT AVG(annual_price_of_plan) FROM insurance_table_1 WHERE age_group = '25-29');

#=============================================================================================================
#Esta tabla muestra el resultado que se piensa que pide el ejercicio
CREATE OR REPLACE VIEW insurance_results_4col AS
SELECT '20-24' AS Age_group, 'M' AS Gender,
	ROUND(AVG(annual_price_of_plan), 2) AS Avg_annual_price_of_plan,
    ROUND(AVG(claim_amount), 2) AS Avg_claim_amount
FROM insurance_table WHERE ((plan_age BETWEEN 20 AND 24) AND gender = 'M')
UNION SELECT '25-29', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 25 AND 29) AND gender = 'M')
UNION SELECT '30-34', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 30 AND 34) AND gender = 'M')
UNION SELECT '35-39', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 35 AND 39) AND gender = 'M')
UNION SELECT '40-44', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 40 AND 44) AND gender = 'M')
UNION SELECT '45-49', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 45 AND 49) AND gender = 'M')
UNION SELECT '50-54', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 50 AND 54) AND gender = 'M')
UNION SELECT '55-59', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 55 AND 59) AND gender = 'M')
UNION SELECT '60-64', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 60 AND 64) AND gender = 'M')
UNION SELECT '20-24', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 20 AND 24) AND gender = 'F')
UNION SELECT '25-29', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 25 AND 29) AND gender = 'F')
UNION SELECT '30-34', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 30 AND 34) AND gender = 'F')
UNION SELECT '35-39', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 35 AND 39) AND gender = 'F')
UNION SELECT '40-44', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 40 AND 44) AND gender = 'F')
UNION SELECT '45-49', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 45 AND 49) AND gender = 'F')
UNION SELECT '50-54', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 50 AND 54) AND gender = 'F')
UNION SELECT '55-59', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 55 AND 59) AND gender = 'F')
UNION SELECT '60-64', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2)
	FROM insurance_table WHERE ((plan_age BETWEEN 60 AND 64) AND gender = 'F');
    
SELECT * FROM insurance_results_4col;
#=============================================================================================================



#=============================================================================================================
#Esta tabla muestra el resultado de 4 columnas, ademas de la cantidad de planes y claims
CREATE OR REPLACE VIEW insurance_results_6col AS
SELECT '20-24' AS Age_group, 'M' AS Gender,
	ROUND(AVG(annual_price_of_plan), 2) AS Avg_annual_price_of_plan,
    ROUND(AVG(claim_amount), 2) AS Avg_claim_amount,
	COUNT(plan_id) AS Plans_group,
    COUNT(claim_amount) AS Claims_group
FROM insurance_table WHERE ((plan_age BETWEEN 20 AND 24) AND gender = 'M')
UNION SELECT '25-29', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 25 AND 29) AND gender = 'M')
UNION SELECT '30-34', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 30 AND 34) AND gender = 'M')
UNION SELECT '35-39', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 35 AND 39) AND gender = 'M')
UNION SELECT '40-44', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 40 AND 44) AND gender = 'M')
UNION SELECT '45-49', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 45 AND 49) AND gender = 'M')
UNION SELECT '50-54', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 50 AND 54) AND gender = 'M')
UNION SELECT '55-59', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 55 AND 59) AND gender = 'M')
UNION SELECT '60-64', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 60 AND 64) AND gender = 'M')
UNION SELECT '20-24', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 20 AND 24) AND gender = 'F')
UNION SELECT '25-29', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 25 AND 29) AND gender = 'F')
UNION SELECT '30-34', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 30 AND 34) AND gender = 'F')
UNION SELECT '35-39', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 35 AND 39) AND gender = 'F')
UNION SELECT '40-44', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 40 AND 44) AND gender = 'F')
UNION SELECT '45-49', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 45 AND 49) AND gender = 'F')
UNION SELECT '50-54', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 50 AND 54) AND gender = 'F')
UNION SELECT '55-59', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 55 AND 59) AND gender = 'F')
UNION SELECT '60-64', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount)
	FROM insurance_table WHERE ((plan_age BETWEEN 60 AND 64) AND gender = 'F');
    
SELECT * FROM insurance_results_6col;
#=============================================================================================================

SELECT SUM(Plans_group), SUM(Claims_group) FROM insurance_results_6col;

#=============================================================================================================
#Esta tabla muestra el resultado de 4 columnas, ademas de la cantidad de planes y claims
CREATE OR REPLACE VIEW insurance_results_8col AS
SELECT '20-24' AS Age_group, 'M' AS Gender,
	ROUND(AVG(annual_price_of_plan), 2) AS Avg_annual_price_of_plan,
    ROUND(AVG(claim_amount), 2) AS Avg_claim_amount,
	COUNT(plan_id) AS Plans_group,
    COUNT(claim_amount) AS Claims_group,
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)) AS Claim_plan_avg,
    (COUNT(claim_amount)/COUNT(plan_id)) AS Claim_plan_no
FROM insurance_table WHERE ((plan_age BETWEEN 20 AND 24) AND gender = 'M')
UNION SELECT '25-29', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 25 AND 29) AND gender = 'M')
UNION SELECT '30-34', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 30 AND 34) AND gender = 'M')
UNION SELECT '35-39', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 35 AND 39) AND gender = 'M')
UNION SELECT '40-44', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 40 AND 44) AND gender = 'M')
UNION SELECT '45-49', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 45 AND 49) AND gender = 'M')
UNION SELECT '50-54', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 50 AND 54) AND gender = 'M')
UNION SELECT '55-59', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 55 AND 59) AND gender = 'M')
UNION SELECT '60-64', 'M', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 60 AND 64) AND gender = 'M')
UNION SELECT '20-24', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 20 AND 24) AND gender = 'F')
UNION SELECT '25-29', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 25 AND 29) AND gender = 'F')
UNION SELECT '30-34', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 30 AND 34) AND gender = 'F')
UNION SELECT '35-39', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 35 AND 39) AND gender = 'F')
UNION SELECT '40-44', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 40 AND 44) AND gender = 'F')
UNION SELECT '45-49', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 45 AND 49) AND gender = 'F')
UNION SELECT '50-54', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 50 AND 54) AND gender = 'F')
UNION SELECT '55-59', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 55 AND 59) AND gender = 'F')
UNION SELECT '60-64', 'F', ROUND(AVG(annual_price_of_plan), 2), ROUND(AVG(claim_amount), 2),
	COUNT(plan_id), COUNT(claim_amount),
    (ROUND(AVG(claim_amount)/AVG(annual_price_of_plan), 5)), (COUNT(claim_amount)/COUNT(plan_id))
	FROM insurance_table WHERE ((plan_age BETWEEN 60 AND 64) AND gender = 'F');
    
SELECT * FROM insurance_results_8col ORDER BY 8 DESC, 7 DESC;
#=============================================================================================================
