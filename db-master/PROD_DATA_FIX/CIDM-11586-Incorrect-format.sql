/*

Person Id Case Id Program Start Date
8d2e2aa1-cca3-451c-a903-e85dac19cd1e 3303002 0221-04-20 0:00:00

b74c1ffb-d709-4b8e-bc75-ed989e6d9add 2020034404677 0221-02-17 0:00:00
e529c552-2448-4995-8cc2-cf2fb744fe5a 2020034404677 0221-02-17 0:00:00

17bda101-a56f-48f4-bc95-527a4966159c 2020035704937 0221-02-26 0:00:00
95cc4c06-c7be-40cb-8e94-ce485ead8cce 2020035704937 0221-02-26 0:00:00

d0dd3ebc-9245-4252-a4f4-811ebdbfd233 3162296 0202-06-21 0:00:00
daf750c4-a4d2-4d25-9613-57a40dbcca9e 2020027303281 0221-08-27 0:00:00
f157f26f-787d-4c0f-b455-4995ced134f7 202103905846 0221-10-26 0:00:00
ec6c613d-e1a2-47e0-bef5-e877cfd65acc 221030018070 0222-08-25 0:00:00
6a06a37d-53c6-46ae-b730-a77f7bc75ef6 3306188 0222-01-25 0:00:00
75e2fb8b-00cb-49c2-85eb-b47e063e6879 2020027303281 0221-08-27 0:00:00



*/


update personprogramarea 
set startdate ='2021-04-20 0:00:00', updatedon = now(), updatedby ='CIDM-11586'
where personid ='8d2e2aa1-cca3-451c-a903-e85dac19cd1e' and activeflag = 1  and entityid='3303002' and startdate='0221-04-20 0:00:00';

update personprogramarea 
set startdate ='2021-02-17 0:00:00', updatedon = now(), updatedby ='CIDM-11586'
where personid ='b74c1ffb-d709-4b8e-bc75-ed989e6d9add' and entityid='2020034404677' and activeflag = 1 and startdate='0221-02-17 0:00:00';

update personprogramarea 
set startdate ='2021-02-17 0:00:00', updatedon = now(), updatedby ='CIDM-11586'
where personid ='e529c552-2448-4995-8cc2-cf2fb744fe5a' and entityid='2020034404677' and activeflag = 1 and startdate='0221-02-17 0:00:00';



update personprogramarea 
set startdate ='2021-02-26 0:00:00', updatedon = now(), updatedby ='CIDM-11586'
where personid ='17bda101-a56f-48f4-bc95-527a4966159c' and entityid='2020035704937' and activeflag = 1 and startdate='0221-02-26 0:00:00';

update personprogramarea 
set startdate ='2021-02-26 0:00:00', updatedon = now(), updatedby ='CIDM-11586'
where personid ='95cc4c06-c7be-40cb-8e94-ce485ead8cce' and entityid='2020035704937' and activeflag = 1 and startdate='0221-02-26 0:00:00';


update personprogramarea 
set startdate ='2020-06-21 0:00:00', updatedon = now(), updatedby ='CIDM-11586'
where personid ='d0dd3ebc-9245-4252-a4f4-811ebdbfd233' and entityid='3162296' and activeflag = 1 and startdate='0202-06-21 0:00:00';

update personprogramarea 
set startdate ='2021-08-27 0:00:00', updatedon = now(), updatedby ='CIDM-11586'
where personid ='daf750c4-a4d2-4d25-9613-57a40dbcca9e' and entityid='2020027303281' and startdate='0221-08-27 0:00:00';

--f157f26f-787d-4c0f-b455-4995ced134f7 202103905846 0221-10-26 0:00:00
update personprogramarea 
set startdate ='2021-10-26 0:00:00', updatedon = now(), updatedby ='CIDM-11586'
where personid ='f157f26f-787d-4c0f-b455-4995ced134f7' and entityid='202103905846' and activeflag = 1 and startdate='0221-10-26 0:00:00';

--ec6c613d-e1a2-47e0-bef5-e877cfd65acc 221030018070 0222-08-25 0:00:00
update personprogramarea 
set startdate ='2022-08-25 0:00:00', updatedon = now(), updatedby ='CIDM-11586'
where personid ='ec6c613d-e1a2-47e0-bef5-e877cfd65acc' and entityid='221030018070' and activeflag = 1 and startdate='0222-08-25 0:00:00';

--6a06a37d-53c6-46ae-b730-a77f7bc75ef6 3306188 0222-01-25 0:00:00
update personprogramarea 
set startdate ='2022-01-25 0:00:00', updatedon = now(), updatedby ='CIDM-11586'
where personid ='6a06a37d-53c6-46ae-b730-a77f7bc75ef6' and entityid='3306188' and activeflag = 1 and startdate='0222-01-25 0:00:00';

--75e2fb8b-00cb-49c2-85eb-b47e063e6879 2020027303281 0221-08-27 0:00:00
update personprogramarea 
set startdate ='2021-08-27 0:00:00', updatedon = now(), updatedby ='CIDM-11586'
where personid ='75e2fb8b-00cb-49c2-85eb-b47e063e6879' and entityid='2020027303281' and startdate='0221-08-27 0:00:00';

