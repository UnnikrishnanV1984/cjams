/*
   Issue Description: CDM-37445
   Category/ Module  :program assignment end date issue
   Root cause:  remove the GAP program assignment End Date as requested. Both children
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--Client Name : Jaxson Alexander (CJAMS PID # 200838189)
select startdate , enddate , * from personprogramarea where personprogramid = '8375a401-46bd-4068-8a5f-86afdd3b78d5';
UPDATE cjams.personprogramarea
SET enddate= null 
where personprogramid='8375a401-46bd-4068-8a5f-86afdd3b78d5'::uuid;

--Client Name : Journee Alexander (CJAMS PID # 200838188)
select startdate , enddate , * from personprogramarea where personprogramid = 'c30fd162-098e-4329-aa31-32078138a4ee';
UPDATE cjams.personprogramarea
SET enddate= null 
where personprogramid='c30fd162-098e-4329-aa31-32078138a4ee'::uuid;