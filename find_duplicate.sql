WITH cte AS /* creat count the same unique rows table */
(SELECT  
   SalesID, 
    SalesPersonID,
    CustomerID,
    ProductID,
    Quantity,
    Discount,
    TotalPrice,
    SalesDate,
    TransactionNumber,
    COUNT(*) AS COUNTER
FROM `grocery.sales`
GROUP BY SalesID, 
    SalesPersonID,
    CustomerID,
    ProductID,
    Quantity,
    Discount,
    TotalPrice,
    SalesDate,
    TransactionNumber)
    SELECT * /* select duplicated rows */
    FROM cte
    WHERE COUNTER > 1;
