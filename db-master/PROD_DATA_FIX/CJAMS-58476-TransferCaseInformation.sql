
/*
Issue Description: Need data fix to transfer all the record to case 251030456662 and client profile from Bio client ID: 1043013 to Adopted Client ID: 200147663. 
Category/Module: Bug
Root cause: moving the one record to another record due to create new Cjams PID for a youth.
Fix provided: DB queries  updateintakeservicerequestpetitionactor, hearingclients,intakeservreqcourtorder,table.
Data/Code fix ticket#: CJAMS-58476
Regression Impacts: N/A
Is Code fix Required?: Nos
Code fix ticket#: N/A           
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--1. Updating intakeservicerequestpetitionactor 
update intakeservicerequestpetitionactor 
set intakeservicerequestactorid  = '81f41ebd-0225-4863-9883-80384b53f027', updatedby = 'CJAMS-58476', updatedon = now()
where intakeservicerequestpetitionactorid = 'e9b68150-8b93-4394-a4ef-4fc80641f4b4' and activeflag = 1;

--2. 
update hearingclients 
set personid  = '6034e7b2-51b6-4dad-a474-823158874482', updatedby = 'CJAMS-58476', updatedon = now()
where courthearingid in('1195c066-5400-4909-a2ee-09d0165830fd',
'699b8fd1-b952-42e9-aa79-4e91458ce48f',
'e646b74b-bfe3-44b4-9a5c-4a4ce3919087',
'53d77166-799a-4a09-b18d-5e475768557d',
'5571f70e-39f9-489c-9338-35bafdcda2da',
'48e5b8af-1530-48a1-8b6f-f9799f2250b0',
'8f69d069-56b5-4a08-9c18-c78705eb1c65',
'4ccf33aa-8c14-4fe8-8bac-3679d70e8e4b',
'2fdd12c8-aefa-4cdf-8cee-131a3c17bab8',
'114ab916-35d0-46d2-9c9e-caf742126fdc',
'f8613ad3-36d7-4357-a291-4d1a82b3ae66',
'aee176f3-e14f-421d-b4d7-e2c3af6a7f5a',
'975f092e-7142-44d9-8a79-696baaa8df1f',
'0dea85d9-1e28-4291-8c1c-8daa6a793536',
'cfcf7946-d51b-44f3-8212-f9183425817a',
'3c17fcf0-4fab-4482-8cfa-9448856b1561',
'6ab34dff-10df-42d4-af16-219549e1b5cb',
'392cb423-9a42-4a6e-b8b3-f7e1c7cc05bf',
'4c4a44c0-0f3f-406d-8b06-dcf03f0e62da',
'71607080-613c-4983-bd68-4a50923b7cda',
'b12f19a4-15c5-47eb-9eb5-9aad7a6d5d8d',
'659f10fe-250a-4cef-98e4-03a04943171c',
'f0a2d50b-d9bd-4201-b58b-bbf65f756907'
) and activeflag = 1;

--3. 
update intakeservreqcourtorder
set intakeservicerequestactorid = '81f41ebd-0225-4863-9883-80384b53f027',updatedby = 'CJAMS-58476', updatedon = now()
where intakeservicerequesthearingid in('1195c066-5400-4909-a2ee-09d0165830fd',
'699b8fd1-b952-42e9-aa79-4e91458ce48f',
'e646b74b-bfe3-44b4-9a5c-4a4ce3919087',
'53d77166-799a-4a09-b18d-5e475768557d',
'5571f70e-39f9-489c-9338-35bafdcda2da',
'48e5b8af-1530-48a1-8b6f-f9799f2250b0',
'8f69d069-56b5-4a08-9c18-c78705eb1c65',
'4ccf33aa-8c14-4fe8-8bac-3679d70e8e4b',
'2fdd12c8-aefa-4cdf-8cee-131a3c17bab8',
'114ab916-35d0-46d2-9c9e-caf742126fdc',
'f8613ad3-36d7-4357-a291-4d1a82b3ae66',
'aee176f3-e14f-421d-b4d7-e2c3af6a7f5a',
'975f092e-7142-44d9-8a79-696baaa8df1f',
'0dea85d9-1e28-4291-8c1c-8daa6a793536',
'cfcf7946-d51b-44f3-8212-f9183425817a',
'3c17fcf0-4fab-4482-8cfa-9448856b1561',
'6ab34dff-10df-42d4-af16-219549e1b5cb',
'392cb423-9a42-4a6e-b8b3-f7e1c7cc05bf',
'4c4a44c0-0f3f-406d-8b06-dcf03f0e62da',
'71607080-613c-4983-bd68-4a50923b7cda',
'b12f19a4-15c5-47eb-9eb5-9aad7a6d5d8d',
'659f10fe-250a-4cef-98e4-03a04943171c',
'f0a2d50b-d9bd-4201-b58b-bbf65f756907'
) and activeflag = 1;





update intakeservicerequestcourthearing 
set servicecaseid = '4ee75cff-1d0f-4a38-9447-71f1a95604ed', intakeserviceid = '3d06724d-2454-4a13-97c8-2ac740897397'
where intakeservicerequestcourthearingid  in('1195c066-5400-4909-a2ee-09d0165830fd',
'699b8fd1-b952-42e9-aa79-4e91458ce48f',
'e646b74b-bfe3-44b4-9a5c-4a4ce3919087',
'53d77166-799a-4a09-b18d-5e475768557d',
'5571f70e-39f9-489c-9338-35bafdcda2da',
'48e5b8af-1530-48a1-8b6f-f9799f2250b0',
'8f69d069-56b5-4a08-9c18-c78705eb1c65',
'4ccf33aa-8c14-4fe8-8bac-3679d70e8e4b',
'2fdd12c8-aefa-4cdf-8cee-131a3c17bab8',
'114ab916-35d0-46d2-9c9e-caf742126fdc',
'f8613ad3-36d7-4357-a291-4d1a82b3ae66',
'aee176f3-e14f-421d-b4d7-e2c3af6a7f5a',
'975f092e-7142-44d9-8a79-696baaa8df1f',
'0dea85d9-1e28-4291-8c1c-8daa6a793536',
'cfcf7946-d51b-44f3-8212-f9183425817a',
'3c17fcf0-4fab-4482-8cfa-9448856b1561',
'6ab34dff-10df-42d4-af16-219549e1b5cb',
'392cb423-9a42-4a6e-b8b3-f7e1c7cc05bf',
'4c4a44c0-0f3f-406d-8b06-dcf03f0e62da',
'71607080-613c-4983-bd68-4a50923b7cda',
'b12f19a4-15c5-47eb-9eb5-9aad7a6d5d8d',
'659f10fe-250a-4cef-98e4-03a04943171c',
'f0a2d50b-d9bd-4201-b58b-bbf65f756907'
) and activeflag = 1;
