
/*
   Issue Description: CJAMS-65946
   Category/ Module  : Delete cases  
   Root cause: User requested to remove records
   Pull request# for code fix: 4329
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

   intakeservicerequest, intakeservicerequestsdm, intakeservicerequestdispositioncode,
caseassignment, personprogramarea, actor, intakeservicerequestactor,
personrole, actorrelationship, personroletype and routing

*/

update intakeservicerequest 
set activeflag =0 ,servicecaseid = null, updatedby = 'CJAMS-65946', updatedon = now() 
where servicerequestnumber in('261023622505','261023622506','261023622507','261023622509','261023622512','261023622519','261023622523','261023622524') and activeflag = 1;


update 
   intakeservicerequestsdm
set activeflag = 0, 
   updatedby = 'CJAMS-65946',
   updatedon = now() 
where 
intakeserviceid in ('f0753180-dc84-47ea-a637-585ffdf0daaa','91c98e4c-bb93-4948-9fe4-24ed8ded8588',
'0d03fb40-022b-4fdc-9b17-7a8c068cfcad',
'9e1a64c3-4717-460c-96f0-45705513d100',
'9e6572b9-43e1-4530-8de2-945f5eb07642',
'ab3da5a5-7b87-4cd1-80af-88eda334d4f8',
'f5f6489a-d344-4d23-a1d2-33245262e92b',
'8ca488fa-2545-4332-ac21-2404b4fa2c4a')  and activeflag = 1;

update 
   intakeservicerequestdispositioncode
set activeflag = 0, 
   updatedby = 'CJAMS-65946',
   updatedon = now() 
where 
intakeserviceid in ('f0753180-dc84-47ea-a637-585ffdf0daaa','91c98e4c-bb93-4948-9fe4-24ed8ded8588',
'0d03fb40-022b-4fdc-9b17-7a8c068cfcad',
'9e1a64c3-4717-460c-96f0-45705513d100',
'9e6572b9-43e1-4530-8de2-945f5eb07642',
'ab3da5a5-7b87-4cd1-80af-88eda334d4f8',
'f5f6489a-d344-4d23-a1d2-33245262e92b',
'8ca488fa-2545-4332-ac21-2404b4fa2c4a')  and activeflag = 1;


update 
   personprogramarea 
set
  activeflag = 0,  
  updatedby = 'CJAMS-65946',
  updatedon = now() 
where 
objectid in ('f0753180-dc84-47ea-a637-585ffdf0daaa','91c98e4c-bb93-4948-9fe4-24ed8ded8588',
'0d03fb40-022b-4fdc-9b17-7a8c068cfcad',
'9e1a64c3-4717-460c-96f0-45705513d100',
'9e6572b9-43e1-4530-8de2-945f5eb07642',
'ab3da5a5-7b87-4cd1-80af-88eda334d4f8',
'f5f6489a-d344-4d23-a1d2-33245262e92b',
'8ca488fa-2545-4332-ac21-2404b4fa2c4a')  and activeflag = 1;

update 
   actor
set activeflag = 0, 
   updatedby = 'CJAMS-65946',
   updatedon = now() 
where 
intakeserviceid in ('f0753180-dc84-47ea-a637-585ffdf0daaa','91c98e4c-bb93-4948-9fe4-24ed8ded8588',
'0d03fb40-022b-4fdc-9b17-7a8c068cfcad',
'9e1a64c3-4717-460c-96f0-45705513d100',
'9e6572b9-43e1-4530-8de2-945f5eb07642',
'ab3da5a5-7b87-4cd1-80af-88eda334d4f8',
'f5f6489a-d344-4d23-a1d2-33245262e92b',
'8ca488fa-2545-4332-ac21-2404b4fa2c4a')  and activeflag = 1;

update 
   intakeservicerequestactor
set activeflag = 0, 
   updatedby = 'CJAMS-65946',
   updatedon = now() 
where 
intakeserviceid in ('f0753180-dc84-47ea-a637-585ffdf0daaa','91c98e4c-bb93-4948-9fe4-24ed8ded8588',
'0d03fb40-022b-4fdc-9b17-7a8c068cfcad',
'9e1a64c3-4717-460c-96f0-45705513d100',
'9e6572b9-43e1-4530-8de2-945f5eb07642',
'ab3da5a5-7b87-4cd1-80af-88eda334d4f8',
'f5f6489a-d344-4d23-a1d2-33245262e92b',
'8ca488fa-2545-4332-ac21-2404b4fa2c4a')  and activeflag = 1;

update 
   personrole
set activeflag = 0, 
   updatedby = 'CJAMS-65946',
   updatedon = now() 
where 
intakeserviceid in ('f0753180-dc84-47ea-a637-585ffdf0daaa','91c98e4c-bb93-4948-9fe4-24ed8ded8588',
'0d03fb40-022b-4fdc-9b17-7a8c068cfcad',
'9e1a64c3-4717-460c-96f0-45705513d100',
'9e6572b9-43e1-4530-8de2-945f5eb07642',
'ab3da5a5-7b87-4cd1-80af-88eda334d4f8',
'f5f6489a-d344-4d23-a1d2-33245262e92b',
'8ca488fa-2545-4332-ac21-2404b4fa2c4a')  and activeflag = 1;


update 
   personroletype
set activeflag = 0, 
   updatedby = 'CJAMS-65946',
   updatedon = now()
where personroleid in ('592a471d-78d6-4f1c-ba7f-b0f9bc85cb34',
'c2b9e317-5667-4ac9-a59d-c8a850cf9677',
'bed86faa-e2b6-47a7-9c51-fb1addad0c9f',
'fc79eb2c-d649-46f5-bc1e-dfff8a9f1948','4b756290-98de-46c7-99f9-a03f93162a66',
'b7251b15-7c34-45eb-a703-008c6f6bf82c',
'46ac2900-9909-4610-ad50-ed2c272d00e0',
'c9357f29-1c4b-4815-b456-ebd88ca64b01',
'7cfa4bbd-46bc-478a-8e1a-ae747e36a690',
'f0d5a4f4-b269-4c05-9418-bb37af33d894',
'fc5adb4c-5ad9-4ce6-acf6-ea1b7965db48',
'9be98182-435e-4a52-b44e-460966e2e215',
'7550a9b8-3852-4d07-b949-2893fb5b8601',
'10c3a461-555f-478b-8b60-c01360b4240f',
'9e275548-32c8-4808-b222-a486cb80c388',
'ac6eac26-3cfd-4579-833f-cfb139cd013b',
'a5ff3108-9607-4216-a6a2-b0696b90c941',
'30eb0280-4165-4425-9a8e-dedd1f9e3519',
'dec22aaa-151c-4a62-8647-a1de53409e2d',
'98d0d8f8-6937-46c4-807f-cea58cfd7f95',
'402b2183-f931-4eb9-9d36-59d28929d8b6',
'f2955151-7c88-476c-90ed-6d3e419df574',
'c2eadc48-c2eb-41ff-99e4-4ddf0fca4e5b',
'550a47c5-66a2-48f6-ac53-a4d6620b1c3a',
'8c6210da-d5c1-4b97-844a-7932542cb924',
'54d69486-2533-4952-b57e-a03fc50f85b2',
'68e3ac08-4197-4f81-8710-2044050830c7',
'5c6c4db5-986a-4352-9485-2d795057c846',
'c4d9414f-3b73-4696-9c23-5dc9a167608b',
'577f933a-7ba7-4928-ab3f-1ef38f2868d1',
'a49eb561-fc91-4ba2-ab14-bb5213b9b31c',
'f66caf9b-b614-4644-b2c6-d37f06d36b3e')
  AND activeflag = 1;
 


update 
   actorrelationship
set activeflag = 0, 
   updatedby = 'CJAMS-65946',
   updatedon = now() 
where 
intakeserviceid in ('f0753180-dc84-47ea-a637-585ffdf0daaa','91c98e4c-bb93-4948-9fe4-24ed8ded8588',
'0d03fb40-022b-4fdc-9b17-7a8c068cfcad',
'9e1a64c3-4717-460c-96f0-45705513d100',
'9e6572b9-43e1-4530-8de2-945f5eb07642',
'ab3da5a5-7b87-4cd1-80af-88eda334d4f8',
'f5f6489a-d344-4d23-a1d2-33245262e92b',
'8ca488fa-2545-4332-ac21-2404b4fa2c4a')  and activeflag = 1;


