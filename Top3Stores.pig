A = LOAD 'ordersNoHeaders.csv' using PigStorage(',') AS
(id:chararray, cdID:int, dayPurch:int, hourPurch:int, pricePaid:int, salesPersonID:int, storeID:int);

B = FOREACH A GENERATE storeID, pricePaid, salesPersonID;

C = GROUP B BY storeID;

--D = FOREACH C GENERATE group AS storeID, B.(pricePaid, salesPersonID);

--E = GROUP D BY storeID;

F = FOREACH C GENERATE group AS storeID, SUM(B.pricePaid) as totalSales;

G = ORDER F BY totalSales DESC;

--DUMP G;

H = LIMIT G 3;

DUMP H;

STORE H into 'Top3Output';