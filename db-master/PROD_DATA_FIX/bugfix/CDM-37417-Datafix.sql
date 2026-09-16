/*
 * CDM-37417 - Program Assignment
 * Customer Email ID:rrebecca.biggs1@maryland.gov
 * Customer Name:Rebecca Biggs
 * Focus Area:Persons: Household
 * Description - End date THE program assignment 
 * 
 */

select startdate , enddate , * from personprogramarea where personprogramid = '1ebbd4db-18b2-4ca6-9545-21c95e8bb7ba';
UPDATE cjams.personprogramarea
SET enddate='2021-12-30' 
where personprogramid='1ebbd4db-18b2-4ca6-9545-21c95e8bb7ba'::uuid;

select startdate , enddate , * from personprogramarea where personprogramid = '4d0f3398-c523-4da2-8c91-ac4db97c0810';
UPDATE cjams.personprogramarea
SET enddate='2021-12-30' 
where personprogramid='4d0f3398-c523-4da2-8c91-ac4db97c0810'::uuid;

select startdate , enddate , * from personprogramarea where personprogramid = '71f27ec3-15d7-4af3-a82b-c3376cd71b06';
UPDATE cjams.personprogramarea
SET enddate='2021-06-24' 
where personprogramid='71f27ec3-15d7-4af3-a82b-c3376cd71b06'::uuid;

select startdate , enddate , * from personprogramarea where personprogramid = '494e6a4d-45cf-444d-b467-a92ef9b93b61';
UPDATE cjams.personprogramarea
SET enddate='2021-06-24' 
where personprogramid='494e6a4d-45cf-444d-b467-a92ef9b93b61'::uuid;

select startdate , enddate , * from personprogramarea where personprogramid = '061bafc5-4bfe-4c91-b22e-4a8ef716a6fb';
UPDATE cjams.personprogramarea
SET enddate='2019-12-31' 
where personprogramid='061bafc5-4bfe-4c91-b22e-4a8ef716a6fb'::uuid;