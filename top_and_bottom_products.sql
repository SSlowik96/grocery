WITH top10 AS /* top10 products */
    (SELECT
      ProductID,
      SUM (Quantity) as SumOfProducts
    FROM grocery.sales
    GROUP BY ProductID
    ORDER BY SumOfProducts DESC
    LIMIT 10),

 lower10 AS /* bottom 10 products */
    (SELECT
      ProductID,
      SUM (Quantity) as SumOfProducts
    FROM grocery.sales
    GROUP BY ProductID
    ORDER BY SumOfProducts ASC
    LIMIT 10),

  SumTables AS /* union top10 and bottom10 products */
    (Select 
        ProductID,
        SumOfProducts
    FROM top10
    UNION DISTINCT
    Select
        ProductID,
        SumOfProducts
    FROM lower10)

SELECT /* top10 bottom 10 products with names and prices */
      st.ProductID,
      st.SumOfProducts,
      pr.ProductName,
      pr.Price
FROM SumTables as st
LEFT JOIN `grocery.products` AS pr
ON st.ProductID = pr.ProductID