/*
   Issue Description: CJAMS-66545
   Category/ Module  : Delete cases  
   Root cause:  Following cases will be removed because they are duplicates.
            Intake #I261013883990 -  CPS IR cases (261023622493, 261023622503 &  261023622498 ) , 
   Pull request# for code fix: 4329
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 


   intakeservicerequest, intakeservicerequestsdm, intakeservicerequestdispositioncode,
caseassignment, personprogramarea, actor, intakeservicerequestactor,
personrole, actorrelationship, personroletype and routing

*/

update intakeservicerequest 
set activeflag =0 ,servicecaseid = null, updatedby = 'CJAMS-66545', updatedon = now() 
where servicerequestnumber in('261023622493', '261023622503', '261023622498') and activeflag = 1;


update 
   intakeservicerequestsdm
set activeflag = 0, 
   updatedby = 'CJAMS-66545',
   updatedon = now() 
where 
intakeserviceid in ('ac9368ff-f432-4b19-8cf3-c32ccc4b7d76',
'e3d8004d-ae83-41be-8941-bb3132072730',
'bc816bf5-dfeb-4356-8b6a-1477ce8f1a01')  and activeflag = 1;

update 
   intakeservicerequestdispositioncode
set activeflag = 0, 
   updatedby = 'CJAMS-66545',
   updatedon = now() 
where 
intakeserviceid in ('ac9368ff-f432-4b19-8cf3-c32ccc4b7d76',
'e3d8004d-ae83-41be-8941-bb3132072730',
'bc816bf5-dfeb-4356-8b6a-1477ce8f1a01')  and activeflag = 1;


update 
   personprogramarea 
set
  activeflag = 0,  
  updatedby = 'CJAMS-66545',
  updatedon = now() 
where 
objectid in ('ac9368ff-f432-4b19-8cf3-c32ccc4b7d76',
'e3d8004d-ae83-41be-8941-bb3132072730',
'bc816bf5-dfeb-4356-8b6a-1477ce8f1a01')  and activeflag = 1;

update 
   actor
set activeflag = 0, 
   updatedby = 'CJAMS-66545',
   updatedon = now() 
where 
intakeserviceid in ('ac9368ff-f432-4b19-8cf3-c32ccc4b7d76',
'e3d8004d-ae83-41be-8941-bb3132072730',
'bc816bf5-dfeb-4356-8b6a-1477ce8f1a01')  and activeflag = 1;

update 
   intakeservicerequestactor
set activeflag = 0, 
   updatedby = 'CJAMS-66545',
   updatedon = now() 
where 
intakeserviceid in ('ac9368ff-f432-4b19-8cf3-c32ccc4b7d76',
'e3d8004d-ae83-41be-8941-bb3132072730',
'bc816bf5-dfeb-4356-8b6a-1477ce8f1a01')  and activeflag = 1;

update 
   personrole
set activeflag = 0, 
   updatedby = 'CJAMS-66545',
   updatedon = now() 
where 
intakeserviceid in ('ac9368ff-f432-4b19-8cf3-c32ccc4b7d76',
'e3d8004d-ae83-41be-8941-bb3132072730',
'bc816bf5-dfeb-4356-8b6a-1477ce8f1a01')  and activeflag = 1;


update 
   personroletype
set activeflag = 0, 
   updatedby = 'CJAMS-66545',
   updatedon = now()
where personroleid in ('b94d0f3b-1425-45fd-8fcf-60d4b0204152',
'06569d39-0428-4249-b8f8-8a6f3ff57a66',
'd44e9791-d15b-405f-bd9c-36bfeab58d45',
'e5e23bbb-289f-4b05-a8db-548aa4cfad31',
'7e6fe31c-65a1-46ed-913f-984726d07092',
'15f1c37c-ac67-431a-9c0d-b7741aea3125',
'6e05e080-4caf-41cc-874e-846501a14167',
'6e7d3e93-2d5d-4f4e-b749-a7605b833ee6',
'34dbb557-802c-477d-9e47-61197af3ac9d',
'08f8e7eb-771d-4681-9603-ec6fdd65ec04',
'5ceb3ad6-f198-4ef1-bc89-f39e20dcb75f',
'411033ee-ccd4-4788-a79e-c28f8dc64656')
  AND activeflag = 1;
 


update 
   actorrelationship
set activeflag = 0, 
   updatedby = 'CJAMS-66545',
   updatedon = now() 
where 
intakeserviceid in ('ac9368ff-f432-4b19-8cf3-c32ccc4b7d76',
'e3d8004d-ae83-41be-8941-bb3132072730',
'bc816bf5-dfeb-4356-8b6a-1477ce8f1a01')  and activeflag = 1;



