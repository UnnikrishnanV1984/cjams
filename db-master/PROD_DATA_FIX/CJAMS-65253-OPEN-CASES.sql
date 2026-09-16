/*
   Issue Description: CJAMS-65253
   Category/ Module  : Dashboard
   Root cause:  1. remove two CPS AR cases, 261023621415 & 261023621417
                2. Remove the CPS AR program assignment for all involved persons
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:

    intakeservicerequestsdm, intakeservicerequestdispositioncode,
caseassignment, personprogramarea, actor, intakeservicerequestactor,
personrole, actorrelationship, personroletype and routing 
*/


update 
   intakeservicerequest
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
servicerequestnumber = '261023621415' and activeflag = 1;

update 
   intakeservicerequestsdm
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
intakeserviceid = '6ad553c0-bf47-4c54-a30b-496a0b980ad3' and activeflag = 1;

update 
   intakeservicerequestdispositioncode
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
intakeserviceid = '6ad553c0-bf47-4c54-a30b-496a0b980ad3' and activeflag = 1;

update 
   personprogramarea 
set
  activeflag = 0,  
  updatedby = 'CJAMS-65253',
  updatedon = now() 
where objectid = '6ad553c0-bf47-4c54-a30b-496a0b980ad3' and activeflag = 1;

update 
   actor
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
intakeserviceid = '6ad553c0-bf47-4c54-a30b-496a0b980ad3' and activeflag = 1;

update 
   intakeservicerequestactor
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
intakeserviceid = '6ad553c0-bf47-4c54-a30b-496a0b980ad3' and activeflag = 1;

update 
   personrole
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
intakeserviceid = '6ad553c0-bf47-4c54-a30b-496a0b980ad3' and activeflag = 1;


update 
   personroletype
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now()
where personroleid in ('45159ce9-7191-4711-932d-c561b04384b8',
'878a8046-2de7-4610-9303-f7739e1f223b',
'8d038899-136f-4585-9721-c6f367363698',
'ededca3f-c089-4470-b1a5-ef86a04ad69b')
  AND activeflag = 1;

update 
   actorrelationship
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
intakeserviceid = '6ad553c0-bf47-4c54-a30b-496a0b980ad3' and activeflag = 1;


/*    */
update 
   intakeservicerequest
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
servicerequestnumber = '261023621417'  and activeflag = 1;

update 
   intakeservicerequestsdm
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
intakeserviceid = '3f997b99-843c-4884-8b88-fad118d841db' and activeflag = 1;

update 
   intakeservicerequestdispositioncode
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
intakeserviceid = '3f997b99-843c-4884-8b88-fad118d841db' and activeflag = 1;


update 
   personprogramarea 
set
  activeflag = 0,  
  updatedby = 'CJAMS-65253',
  updatedon = now() 
where objectid = '3f997b99-843c-4884-8b88-fad118d841db' and activeflag = 1;

update 
   actor
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
intakeserviceid = '3f997b99-843c-4884-8b88-fad118d841db' and activeflag = 1;

update 
   intakeservicerequestactor
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
intakeserviceid = '3f997b99-843c-4884-8b88-fad118d841db' and activeflag = 1;

update 
   personrole
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
intakeserviceid = '3f997b99-843c-4884-8b88-fad118d841db' and activeflag = 1;


update 
   personroletype
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now()
where personroleid in ('0d20f340-e1ef-41c1-9675-7314d716fe0d',
'd2ebbdcb-f484-4b61-aedb-f91f35332760',
'ed1415a2-af36-40fb-b463-39c4d4817c6c',
'dfdf4c47-0482-4722-affa-1893edfa4919')
  AND activeflag = 1;

update 
   actorrelationship
set activeflag = 0, 
   updatedby = 'CJAMS-65253',
   updatedon = now() 
where 
intakeserviceid = '3f997b99-843c-4884-8b88-fad118d841db' and activeflag = 1;

