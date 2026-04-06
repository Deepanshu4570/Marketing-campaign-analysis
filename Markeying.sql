CREATE DATABASE Marketing_db;
USE Marketing_db;

CREATE TABLE marketing_campaign (
    
    ID INT PRIMARY KEY,
    Year_Birth INT,
    Education VARCHAR(50),
    Marital_Status VARCHAR(50),
    Income DECIMAL(15, 2),
    Kidhome INT,
    Teenhome INT,
    Dt_Customer DATE,
    Recency INT,
    MntWines INT,
    MntFruits INT,
    MntMeatProducts INT,
    MntFishProducts INT,
    MntSweetProducts INT,
    MntGoldProds INT,
    NumDealsPurchases INT,
    NumWebPurchases INT,
    NumCatalogPurchases INT,
    NumStorePurchases INT,
    NumWebVisitsMonth INT,
    AcceptedCmp3 INT,
    AcceptedCmp4 INT,
    AcceptedCmp5 INT,
    AcceptedCmp1 INT,
    AcceptedCmp2 INT,
    Complain INT,
    Z_CostContact INT,
    Z_Revenue INT,
    Response INT,
    Country VARCHAR(50),

    Age INT,
    Children INT,
    Total_Spend INT,
    Total_Purchases INT,
    Segment VARCHAR(50),
    Income_Bin VARCHAR(20)
);

select * from marketing_campaign;

-- The Overview
SELECT 
    COUNT(ID) AS Total_Customers,
    ROUND(AVG(Income), 2) AS Avg_Income,
    ROUND(AVG(Total_Spend), 2) AS Avg_Spending
FROM marketing_campaign;

-- Segment Profitability
SELECT 
    Segment, 
    COUNT(*) AS Customer_Count,
    SUM(Total_Spend) AS Total_Revenue,
    ROUND(AVG(Total_Spend), 2) AS Avg_Spend_Per_Customer
FROM marketing_campaign
GROUP BY Segment
ORDER BY Total_Revenue DESC;

-- Campaign Success Rate by Segmen
SELECT 
    Segment, 
    SUM(Response) AS Total_Acceptances,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate_Pct
FROM marketing_campaign
GROUP BY Segment
ORDER BY Response_Rate_Pct DESC;

-- High-Value Product Analysis ("Wine vs. Meat" )
SELECT 
    SUM(MntWines) AS Wine_Rev,
    SUM(MntMeatProducts) AS Meat_Rev,
    SUM(MntGoldProds) AS Gold_Rev,
    SUM(MntFishProducts) AS Fish_Rev,
    SUM(MntFruits) AS Fruit_Rev
FROM marketing_campaign;

-- Channel Dominance: Where do people shop?
SELECT 
    SUM(NumWebPurchases) AS Total_Web_Sales,
    SUM(NumStorePurchases) AS Total_Store_Sales,
    SUM(NumCatalogPurchases) AS Total_Catalog_Sales,
    SUM(NumDealsPurchases) AS Total_Discount_Sales
FROM marketing_campaign;

-- Education vs. Purchasing Power
SELECT 
    Education, 
    COUNT(*) AS Customer_Count,
    ROUND(AVG(Total_Spend), 2) AS Avg_Spending
FROM marketing_campaign
GROUP BY Education
ORDER BY Avg_Spending DESC;

-- Complaint Hotspots (Customer Satisfaction)
SELECT 
    Segment, 
    SUM(Complain) AS Total_Complaints
FROM marketing_campaign
GROUP BY Segment
HAVING Total_Complaints > 0
ORDER BY Total_Complaints DESC;

-- Age-Based Digital Engagement
SELECT 
    CASE 
        WHEN Age < 35 THEN 'Young Adult'
        WHEN Age BETWEEN 35 AND 55 THEN 'Middle Aged'
        ELSE 'Senior' 
    END AS Age_Bracket,
    AVG(NumWebVisitsMonth) AS Avg_Monthly_Web_Visits
FROM marketing_campaign
GROUP BY Age_Bracket;

