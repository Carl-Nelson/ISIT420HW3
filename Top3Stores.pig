A = LOAD 'ordersNoHeaders.csv' using PigStorage(',') AS
(id:chararray, cdID:int, dayPurch:int, hourPurch:int, pricePaid:int, salesPersonID:int, storeID:int);

B = FOREACH A GENERATE storeID, pricePaid, salesPersonID;

C = GROUP B BY storeID;

F = FOREACH C GENERATE group AS storeID, SUM(B.pricePaid) as totalSales;

G = ORDER F BY totalSales DESC;

--DUMP G;

H = LIMIT G 3;

-- Two columns, store ID and the total sales in dollars for each location
DUMP H;

STORE H into 'Top3Output';
