
 /*
  Issue Description: CIDM-4357 MDM record updates 
   Category/ Module  :  Person Profile
   Root cause: E&E data update
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

--1.EE-33932 -- 1175036

select lastname from person where cjamspid=1175036
and personid='c54dfcab-85ce-4708-9aea-8ca19b91004e'
and activeflag=1;

update person set lastname='CAVE', updatedby='CIDM-4357', updatedon=now() where cjamspid=1175036
and personid='c54dfcab-85ce-4708-9aea-8ca19b91004e'
and activeflag=1;

--SELECT json_agg(a) from sp_get_person_mdm('c54dfcab-85ce-4708-9aea-8ca19b91004e') a;

--2.EE-33441 -- 3186324

select firstname from person where cjamspid=3186324
and personid='322ce46e-27c1-4644-b9a7-df80dae06c72'
and activeflag=1;

update person set firstname='JHON', updatedby='CIDM-4357', updatedon=now() where cjamspid=3186324
and personid='322ce46e-27c1-4644-b9a7-df80dae06c72'
and activeflag=1;

--SELECT json_agg(a) from sp_get_person_mdm('322ce46e-27c1-4644-b9a7-df80dae06c72') a;

--3.EE-36259 -- 1127380

select lastname,ssnno from person where cjamspid=1127380
and personid='0900a6bd-1cf6-46c3-92f1-26fb850ee6ae'
and activeflag=1;

update person set lastname='MIDDLETON',ssnno='579110910', updatedby='CIDM-4357', updatedon=now() where cjamspid=1127380
and personid='0900a6bd-1cf6-46c3-92f1-26fb850ee6ae'
and activeflag=1;

select personidentifiervalue from personidentifier 
where personid = '0900a6bd-1cf6-46c3-92f1-26fb850ee6ae' and personidentifiertypekey='SSN' and activeflag=1;

update personidentifier set personidentifiervalue='579110910', updatedby='CIDM-4357', updatedon=now()
where personid = '0900a6bd-1cf6-46c3-92f1-26fb850ee6ae' and personidentifiertypekey='SSN' and activeflag=1;

--SELECT json_agg(a) from sp_get_person_mdm('0900a6bd-1cf6-46c3-92f1-26fb850ee6ae') a;

--4.EE-34830/EE-36121 -- 3677162

select lastname from person where cjamspid=3677162
and personid='0f71b257-3402-46d3-a623-6af7245e2019'
and activeflag=1;

update person set lastname='Lynch', updatedby='CIDM-4357', updatedon=now() where cjamspid=3677162
and personid='0f71b257-3402-46d3-a623-6af7245e2019'
and activeflag=1;

--SELECT json_agg(a) from sp_get_person_mdm('0f71b257-3402-46d3-a623-6af7245e2019') a;
