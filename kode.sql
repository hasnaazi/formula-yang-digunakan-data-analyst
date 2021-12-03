#Menggunakan Windows Fuction

#Penggunaan rank, dense rank, row number
--Perbedaan Rank, Dense Rank & Row Number
--Rank : Memberikan angka yang sama pada data yang duplikat dan juga memberikan gap pada data yang baru
-- Dense Rank : Memberikan angka yang sama pada data yang duplikat tetapi tidak memberikan gap pada data yang baru
-- Row Number : Mengurutkan semua baris yang ada tanpa menghiraukan data yang duplikat

SELECT ORDERNUMBER, QUANTITYORDERED,
  rank() OVER (ORDER BY QUANTITYORDERED DESC) AS rank,
  dense_rank() OVER (ORDER BY QUANTITYORDERED DESC) AS dense_rank,
  row_number() OVER (ORDER BY QUANTITYORDERED DESC) AS row_number
  
  from raw_data ORDER BY QUANTITYORDERED DESC
  
#Penggunaan MAX, MIN, SUM, AVG
 -- MAX : digunakan untuk mencari nilai tertinggi
 -- MIN : digunakan untuk mencari nilai terendah
 -- SUM : digunakan untuk menghitung jumlah
 -- AVG : digunakan untuk menghitung nilai rata-rata
 SELECT ORDERNUMBER, QUANTITYORDERED, SALES, ORDERDATE, PRODUCTLINE,
  MAX(SALES) OVER (PARTITION BY PRODUCTLINE ) AS max_sales,
  MIN(SALES ) OVER (PARTITION BY PRODUCTLINE) AS min_sales,
  SUM(SALES) OVER (PARTITION BY PRODUCTLINE) AS sum_sales,
  AVG(SALES) OVER (PARTITION BY PRODUCTLINE) AS avg_sales
  FROM `my-project-1-data-analyst.satu.sale`
  
  
#Penggunaan LAG
SELECT 
    MONTH,
    MONTH_V2,
    TOTAL_SALES,
    LAG(TOTAL_SALES) OVER (ORDER BY MONTH ) AS PREV_MONTH

FROM 
(
SELECT 
    DATE_TRUNC(ORDERDATE, MONTH) AS MONTH,
    FORMAT_TIMESTAMP("%B", timestamp (ORDERDATE)) AS MONTH_V2,
    SUM(SALES) AS TOTAL_SALES
FROM 
    `my-project-1-data-analyst.satu.sale`
GROUP BY MONTH, MONTH_V2
)
ORDER BY MONTH ASC
