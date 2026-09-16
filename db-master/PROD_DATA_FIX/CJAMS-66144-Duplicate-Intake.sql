/*
   Issue Description: CJAMS-66144
   Category/ Module  : delete intake 
   Root cause: user wants to delete intake
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

   CJAMS PID# :204769346, CJAMS PID# 204769352,CJAMS PID#:204769276 and CJAMS PID# :204769340"
*/

--204769346
update actor 
set activeflag =0, updatedby='CJAMS-66144', updatedon=now() 
where actorid in ('04c789fa-f11c-409b-b422-1a092debfed4') and activeflag = 1;


update intakeservicerequestactor 
set activeflag =0, updatedby='CJAMS-66144', updatedon=now() 
where actorid ='04c789fa-f11c-409b-b422-1a092debfed4' and activeflag = 1;

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-66144'
where personroleid ='8f980c3d-1d63-4fdd-8a61-5b73f64abb73' and activeflag = 1;

update cjams.personroletype
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-66144'
where personroleid ='8f980c3d-1d63-4fdd-8a61-5b73f64abb73' and activeflag = 1;




-------204769352

update actor 
set activeflag =0, updatedby='CJAMS-66144', updatedon=now() 
where actorid in ('ce0f88c7-7458-48ce-8746-5c06844bb5c3') and activeflag = 1;


update intakeservicerequestactor 
set activeflag =0, updatedby='CJAMS-66144', updatedon=now() 
where actorid ='ce0f88c7-7458-48ce-8746-5c06844bb5c3' and activeflag = 1;

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-66144'
where personroleid ='4b1b2ee2-4f02-4e6a-889a-19f92dab604c' and activeflag = 1;

update cjams.personroletype
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-66144'
where personroleid ='4b1b2ee2-4f02-4e6a-889a-19f92dab604c' and activeflag = 1;


--------------204769276
update actor 
set activeflag =0, updatedby='CJAMS-66144', updatedon=now() 
where actorid in ('d5597cfd-d761-41f2-bd64-e1db1bc5037e') and activeflag = 1;


update intakeservicerequestactor 
set activeflag =0, updatedby='CJAMS-66144', updatedon=now() 
where actorid ='d5597cfd-d761-41f2-bd64-e1db1bc5037e' and activeflag = 1;

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-66144'
where personroleid ='2e9478fb-fdfe-43bb-8dd7-e52c92a81bca' and activeflag = 1;

update cjams.personroletype
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-66144'
where personroleid ='2e9478fb-fdfe-43bb-8dd7-e52c92a81bca' and activeflag = 1;


--204769340

update actor 
set activeflag =0, updatedby='CJAMS-66144', updatedon=now() 
where actorid in ('2835224b-e594-4621-b0bf-3e059bebe592') and activeflag = 1;


update intakeservicerequestactor 
set activeflag =0, updatedby='CJAMS-66144', updatedon=now() 
where actorid ='2835224b-e594-4621-b0bf-3e059bebe592' and activeflag = 1;

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-66144'
where personroleid ='604a81c4-77a7-41bb-85ca-eb7773e6959e' and activeflag = 1;

update cjams.personroletype
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-66144'
where personroleid ='604a81c4-77a7-41bb-85ca-eb7773e6959e' and activeflag = 1;

