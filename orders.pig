-- What hour of the day has the least number of sales?

A = LOAD 'ordersNoHeaders.csv' using PigStorage(',') AS (id:int, cdID:int, dayPurch:int, hourPurch:int, pricePaid:int, salesPerson:int, storeID:int);

-- get rid of most of the fields

B = FOREACH A GENERATE hourPurch, pricePaid, storeID;

-- DUMP B;

C = Group B by hourPurch;

-- DUMP C;

D = FOREACH C GENERATE group AS hourPurch, SUM(B.pricePaid) as salesPerHour;

-- DUMP D;

E = ORDER D BY salesPerHour ASC;

-- DUMP E;

F = LIMIT E 6;

-- DUMP F;

STORE F into 'WorstPerformingHour';

