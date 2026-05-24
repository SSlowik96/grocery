CREATE OR REPLACE TABLE `grocery.sales` AS 

WITH drop_nulls AS /* drop rows where key values are missing */
  (SELECT 
    SalesID, 
    SalesPersonID,
    CustomerID,
    ProductID,
    Quantity,
    Discount,
    TotalPrice,
    SalesDate,
    TransactionNumber
  FROM `grocery.sales_dirty`
  WHERE SalesID IS NOT NULL 
  AND SalesDate IS NOT NULL
  AND Quantity > 0), /* quantity can't be lower than 0 */

date_casting AS /* getting correct date types */
(SELECT DISTINCT /*  deduplication */
    SalesID, 
    SalesPersonID,
    CustomerID,
    ProductID,
    Quantity,
    Discount,
    TotalPrice,
    cast(SalesDate AS DATE) AS SalesDate,
    TRIM (TransactionNumber) AS TransactionNumber
    FROM drop_nulls)

SELECT  
    dc.SalesID, 
    dc.SalesPersonID,
    dc.CustomerID,
    dc.ProductID,
    dc.Quantity,
    dc.Discount,
    dc.TotalPrice,
    dc.SalesDate,
    dc.TransactionNumber,
    pr.ProductName, 
    pr.Price, 
    pr.VitalityDays
FROM date_casting AS dc
LEFT JOIN grocery.products AS pr
ON pr.ProductID = dc.ProductID