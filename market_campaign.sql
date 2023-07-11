CREATE SCHEMA market_database;
USE market_database;
SELECT * FROM marketing_campaign;
-- Count of customers based on their marital status
SELECT
	Marital_Status,
    COUNT(*) AS customer_count
FROM marketing_campaign
	GROUP BY 1
    ORDER BY 2 DESC
;
-- Count of products bought based on the customers' marital status
SELECT 
	Marital_Status,
    SUM(MntWines) AS wine_bought,
    SUM(MntFruits) AS fruits_bought,
    SUM(MntMeatProducts) AS meat_bought,
    SUM(MntFishProducts) AS fish_bought,
    SUM(MntSweetProducts) AS sweetproducts_bought,
    SUM(MntGoldProds) AS gold_bought
FROM marketing_campaign
	GROUP BY 1
    ORDER BY 2 DESC
;
-- Count of customers based on their education level
SELECT 
	Education,
    COUNT(*)AScustomer_count
FROM marketing_campaign
	GROUP BY 1
    ORDER BY 2 DESC
;
-- Count of products bought based on the customers' educationsal status
SELECT
	Education,
    SUM(MntWines)ASwine_bought,
    SUM(MntFruits)ASfruits_bought,
    SUM(MntMeatProducts)ASmeat_bought,
    SUM(MntFishProducts)ASfish_bought,
    SUM(MntSweetProducts)ASsweetproducts_bought,
    SUM(MntGoldProds)ASgold_bought
FROM marketing_campaign
	GROUP BY 1
    ORDER BY 2 DESC
;
-- Count of graduated customers based on their marital status
SELECT
	Marital_Status,
    COUNT(*)AScustomer_count
FROM marketing_campaign
	WHERE Education = 'graduation'
    AND income > (SELECT AVG(income) FROM marketing_campaign)
		GROUP BY 1
        ORDER BY 2 DESC
;
SELECT
	Marital_Status,
    max(Income)AStop_earners,
    COUNT(*)AScustomer_count
FROM marketing_campaign
	GROUP BY 1
    ORDER BY 3 DESC
;
-- Count of graduated customers bas
SELECT 
	Marital_Status,
    SUM(MntWines)ASwine_bought,
    SUM(MntFruits)ASfruits_bought,
    SUM(MntMeatProducts)ASmeat_bought,
    SUM(MntFishProducts)ASfish_bought,
    SUM(MntSweetProducts)ASsweetproducts_bought,
    SUM(MntGoldProds)ASgold_bought
FROM marketing_campaign
	WHERE Education = 'graduation'
    AND income > (SELECT AVG(income) FROM marketing_campaign)
     AND Teenhome = 0
    AND Kidhome = 0
		GROUP BY 1
;
-- Count of customer that bought products on discounts based on marital status
SELECT
	Marital_Status,
    SUM(NumDealsPurchases)ASdiscount_purchases
FROM marketing_campaign
	WHERE education = 'graduation'
	GROUP BY 1
    ORDER BY 2 DESC
;
-- Count of customers based on channels
SELECT 
	Marital_Status,
    SUM(NumWebPurchases)ASweb_purchases,
    SUM(NumCatalogPurchases)AScatalog_purchases,
    SUM(NumStorePurchases)ASstore_purchases
FROM marketing_campaign
	WHERE Education = 'graduation'
    AND Teenhome = 1
    AND Kidhome = 1
		GROUP BY 1
;
WITH temp AS
(SELECT 
	`marketing_campaign`.`ID`,
    `marketing_campaign`.`Year_Birth`,
    `marketing_campaign`.`Education`,
    `marketing_campaign`.`Marital_Status`,
    `marketing_campaign`.`Income`,
    `marketing_campaign`.`Kidhome`,
    `marketing_campaign`.`Teenhome`,
    `marketing_campaign`.`Dt_Customer`,
    `marketing_campaign`.`Recency`,
    `marketing_campaign`.`MntWines`,
    `marketing_campaign`.`MntFruits`,
    `marketing_campaign`.`MntMeatProducts`,
    `marketing_campaign`.`MntFishProducts`,
    `marketing_campaign`.`MntSweetProducts`,
    `marketing_campaign`.`MntGoldProds`,
    `marketing_campaign`.`NumDealsPurchases`,
    `marketing_campaign`.`NumWebPurchases`,
    `marketing_campaign`.`NumCatalogPurchases`,
    `marketing_campaign`.`NumStorePurchases`,
    `marketing_campaign`.`NumWebVisitsMonth`,
    `marketing_campaign`.`AcceptedCmp3`,
    `marketing_campaign`.`AcceptedCmp4`,
    `marketing_campaign`.`AcceptedCmp5`,
    `marketing_campaign`.`AcceptedCmp1`,
    `marketing_campaign`.`AcceptedCmp2`,
    `marketing_campaign`.`Complain`,
    `marketing_campaign`.`Z_CostContact`,
    `marketing_campaign`.`Z_Revenue`,
    `marketing_campaign`.`Response`,
    CASE WHEN Recency < (SELECT AVG(Recency) FROM marketing_campaign)
		THEN 'frequent_customer'
        ELSE 'regualr_customer'
	END AS customer_status
FROM `market_database`.`marketing_campaign`
)
SELECT
	Marital_Status,
    SUM(NumWebPurchases) AS web_purchase,
    SUM(NumCatalogPurchases) AS catalog_purchase,
    SUM(NumStorePurchases) AS store_purchase
FROM temp
	WHERE customer_status LIKE '%frequent%'
    AND Education = 'graduation'
    AND Teenhome = 1
    AND Kidhome = 1
		GROUP BY 1
        ORDER BY 2, 3, 4 DESC
;
/*
-- Count of frequent customers that make discount purchases
SELECT
	Marital_Status,
    SUM(NumDealsPurchases) AS discount_purchases
FROM temp
	WHERE customer_status LIKE '%freq%'
    AND Education = 'graduation'
		GROUP BY 1
        ORDER BY 2 DESC
;
*/
-- Count of frequent customers that buy the most products based on marital status
/*
SELECT
	Marital_Status,
	SUM(MntWines),
    SUM(MntFruits),
    SUM(MntMeatProducts),
    SUM(MntFishProducts),
    SUM(MntSweetProducts),
    SUM(MntGoldProds)
FROM temp
	WHERE customer_status LIKE '%frequent%'
    AND Education = 'graduation'
		GROUP BY 1
        ORDER BY 2 DESC
;
*/
-- Count of fregent graduated customers based on their marital status
/*
SELECT
	Marital_Status,
    COUNT(*) AS customer_count
FROM temp
	WHERE customer_status LIKE '%frequent%'
    AND Education = 'graduation'
		GROUP BY 1
        ORDER BY 2 DESC
;
*/
-- Count of frequent customers based on their marital status
/*
SELECT
	Marital_Status,
    COUNT(*) AS customer_count
FROM temp
	WHERE customer_status = 'frequent_customer'
		GROUP BY 1
        ORDER BY 2 DESC
;
*/
-- Count of customers that were frequent buyers
/*
SELECT
	customer_status,
    COUNT(*)   AS customer_count
FROM temp
	GROUP BY 1
    ORDER BY 2 DESC
;
*/