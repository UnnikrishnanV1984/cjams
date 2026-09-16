/*
   Issue Description: CDM-31711
   Category/ Module  : Prod data fix for updating permanency plan
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




-- Noah Winner - PID 1980434 - Start date - 3/12/2020
update permanencyplan set establisheddate = '2020-03-12 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid = '96b58039-8f68-4cac-8618-fe65598fa776';

-- Bentlee Martin - PID 3573033 - Start date - 9/27/2018
update permanencyplan set establisheddate = '2018-09-27 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid = '1464866d-67d2-4d18-b406-d5123ab1f6be';

--Landon Bailey - PID 3820703 - Start date - 1/16/2020
update permanencyplan set establisheddate = '2020-01-16 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid = 'a6038299-6b0a-4395-b736-f2d14a892613';


-- Silas Pilcher - PID 4341585 - Start date - 1/3/2020
update permanencyplan set establisheddate = '2020-01-03 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid = 'f2711993-335f-478b-a0d5-f0f1e19bff8a';

-- Arianna Roy - PID 3108407 - Start date - 8/15/2019
--Hunter Roy - PID 3108406 - Start date - 8/15/2019
update permanencyplan set establisheddate = '2019-08-15 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid in  ('ad64d693-00ca-44a9-bf78-b0c9cdfdb781','5781e824-50f8-4985-8b86-b282ba180941');

--Daysaun Jones - PID 3473705 - Start date - 8/15/2018
--Ernest Jones - PID 3660361 - Start date - 8/15/2018
update permanencyplan set establisheddate = '2020-03-12 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid in ('9beb87fa-ceaa-4292-8ca1-3f285976941f','cfbbe35e-f6ab-4fd2-933b-02f69500e9e9');


--Cory Vizza - PID 3410533 - Start date - 3/12/2020 
--Amanda Vizza - PID 2564156 - Start date - 3/12/2020
update permanencyplan set establisheddate = '2020-03-12 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid in ('6bfb64a2-f3f4-4193-8eaa-09fd1c826548',
'2e0bd2c6-052f-41b1-a553-027992686ced');


--Patrick Smith - PID 2203776 - Start date - 8/9/2013
--Jesse Smith - PID 2777977 - Start date - 8/9/2013
update permanencyplan set establisheddate = '2013-08-09 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid in ('b36ca443-8df9-4c97-bc71-3860c56907b7',
'b947599b-b94e-4567-82ca-08c64a15146e');


--Briauna Martin - PID 3418123 - Start date - 11/30/2017
--Myra Martin - PID 3645788 - Start date - 11/30/2017
update permanencyplan set establisheddate = '2017-11-30 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid in ('7ab6c84c-cb4b-4fd5-ad7c-65b175fa03b7','6a61b2d3-3101-4c5e-873f-a5f803769b30');

--Makhia Pifer - PID 3873623 - Start date - 1/11/2018
update permanencyplan set establisheddate = '2018-01-11 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid = '0c6823c6-df08-4027-9a66-1a2ccca8be90';

--Kamryn McAllister - PID 4186545 - Start date - 10/18/2018
update permanencyplan set establisheddate = '2018-10-18 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid = 'd36e0119-0fc0-439b-b75b-6a82e2fe98a1';



--Isabella Nicol - PID 3806269 - Start date - 4/11/2019
--Isaiah Nicol - PID 3806273 - Start date - 4/11/2019
update permanencyplan set establisheddate = '2019-04-11 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid in ('f5d3a7ef-0d4d-4452-96eb-e09d94071d36',
'66fe0958-cbab-48aa-83f7-017dbdd160de');

--Logic Arnold - PID 4071695 - Start date - 5/25/2018
update permanencyplan set establisheddate = '2018-05-25 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid = 'fbc634d9-a4ae-45b1-a25c-e7ac4edae8f2';

--Richard Comire - PID 2053371 - Start date - 11/4/2016
update permanencyplan set establisheddate = '2016-11-04 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid = '4eccc05e-b89f-4931-a05c-a73ee7b52862';

--Christopher Johnston - PID 3479203 - Start date - 4/22/2019
update permanencyplan set establisheddate = '2019-04-22 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid = '9c7a16f4-83e6-4718-8faf-734111a1f35b';

--Ariella Alexander - PID 4216457 - Start date - 6/28/2019
update permanencyplan set establisheddate = '2019-06-28 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid = '13f2784d-7269-4a90-84d1-1e86630f0210';

--Slayden Alexander - PID 4216458 - Start date - 6/29/2019
update permanencyplan set establisheddate = '2019-06-29 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid = 'db422412-9eee-4446-9c30-1b4339d0aed5';
