SELECT 
    *
FROM
    customer_segmentation;


-- What is the distribution of customers by gender?
SELECT 
    gender, COUNT(gender) AS count
FROM
    customer_segmentation
GROUP BY gender;


-- How many customers are married or single? What is the percentage of each marital status category?
SELECT 
    Ever_Married,
    COUNT(*) AS count,
    (COUNT(*) * 100 / (SELECT 
            COUNT(*)
        FROM
            customer_segmentation)) AS percentage
FROM
    customer_segmentation
GROUP BY Ever_Married;

UPDATE customer_segmentation 
SET 
    Ever_Married = NULLIF(Ever_Married, '');


-- What are the different professions represented in the dataset? How many customers are in each profession?
SELECT DISTINCT
    Profession, COUNT(*) AS counting_profession
FROM
    customer_segmentation
GROUP BY Profession;

UPDATE customer_segmentation 
SET 
    Profession = NULLIF(Profession, '');


-- What is the distribution of family sizes among customers? What is the most common family size?
SELECT 
    family_size, COUNT(*) AS count
FROM
    customer_segmentation
GROUP BY family_size
ORDER BY count DESC;
-- Thus the most common is 2


-- Can spending scores be segmented based on gender?
SELECT 
    spending_score, COUNT(Spending_Score) AS count
FROM
    customer_segmentation
WHERE
    gender = 'male'
GROUP BY Spending_Score
ORDER BY count DESC;

SELECT 
    spending_score, COUNT(Spending_Score) AS count
FROM
    customer_segmentation
WHERE
    gender = 'female'
GROUP BY Spending_Score
ORDER BY count DESC;


-- What are the top 5 professions among customers with the highest spending scores?
SELECT 
    profession, COUNT(*) AS count
FROM
    customer_segmentation
WHERE
    spending_score = 'High'
GROUP BY profession
ORDER BY count DESC
LIMIT 5;


-- What is the average spending score for customers with different family sizes?
SELECT 
    Family_Size,
    AVG(CASE
        WHEN spending_score = 'low' THEN 1
        WHEN spending_score = 'medium' THEN 2
        WHEN spending_score = 'high' THEN 3
        ELSE 0
    END) AS avg_spending_score
FROM
    customer_segmentation
GROUP BY Family_Size
ORDER BY avg_spending_score DESC;
-- Thus bigger families usually tend to spend more
-- Also this funtion can be used with Gender, Ever_Married, Graduated, Profession, Work_Experience..
