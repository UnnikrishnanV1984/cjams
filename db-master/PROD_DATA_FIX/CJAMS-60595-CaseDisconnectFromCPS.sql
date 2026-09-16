/*
Issue Description:251023073006:The attached service case was created in error. The children need to be removed from the father Michael Foley, Jr 11/12/1992. The service case selected is for the mother of the children who is deceased. I was able to end date the assignment and close out the service case, ut when I try to open a new service case for the father, it says one is already open (the mother's case, which is incorrect). This is a priority, as a removal is needed and a service case is needed in order to complete the removal.
Root cause: user could not able to disconnect the servicase from CPS  ,they can only create.
Fix provided: DB queries  update enddate intakeservicerequest tables
Data/Code fix ticket#: CJAMS-60595
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakeservicerequest 
set servicecaseid = null ,updatedby = 'CJAMS-60595', updatedon = now() 
where intakenumber in ('I251013302518') and activeflag =1;


update actor 
set activeflag  =0,updatedby = 'CJAMS-60595', updatedon = now() 
where actorid  in ('0bcb3e84-14db-473c-a0c5-906a5974210f',
'1fb48fbc-7905-4438-b3eb-c778458515d5',
'd457d1fd-6648-470e-be02-1be7492a7345',
'6dc9e66d-6988-4e72-8f03-dc7aeaeaa054',
'642d1575-44cb-4acf-9a73-926455701ad5') and activeflag  =1;


update intakeservicerequestactor
set  activeflag  =0,updatedby = 'CJAMS-60595', updatedon = now() 
where intakeservicerequestactorid  in ('58719f05-6879-4736-b40b-bb25516a8b1d',
'e39b19d7-e72e-424d-86c6-718682230ac7',
'1c922e7c-0c96-4c59-80b2-132f6713fd21',
'b9754236-789f-421b-98cb-51f11fbe7c16') and activeflag =1;

update  actorrelationship 
set activeflag = 0,updatedby = 'CJAMS-60595', updatedon = now() 
where actorrelationshipid in ('1c5a5e62-70aa-417b-ba6e-1ba757687575',
'a1d4635d-2e3b-49ad-976b-834c581c1e22',
'4e356d26-add2-4936-b4d3-df7bdd407bf8',
'194735b9-008c-4164-95b1-c1a55e1da191') and activeflag =1;

update  personrole  
set activeflag = 0,updatedby = 'CJAMS-60595', updatedon = now() 
where personroleid  in ('f8356611-c615-4eba-9a70-16bb40789596',
'841dc6af-fb51-447b-9555-5e1313c407cf',
'3f6691e4-6d0e-4c39-a9a0-9f5507c5930f',
'ae971076-c887-459b-a705-7f779333a7b7',
'cb327bbc-5049-4380-a773-9631cb70ca40') and activeflag =1;


update personroletype 
set activeflag  =0,updatedby = 'CJAMS-60595', updatedon = now() 
where personroletypeid in ('2a146d37-1c0d-4456-8591-56f7a63b65ec',
'4a890704-1c21-48fb-8099-584eb5ec9dc8',
'942a74c2-3216-4114-89da-5668d0b7c30b',
'3c8509f2-dffc-443c-ae04-f941bf3cd372',
'ec7edfae-37f5-437a-a21b-2b43da8e9579') and activeflag =1;


update personprogramarea 
set activeflag  =0, updatedby = 'CJAMS-60595', updatedon = now() 
where personprogramid  in ('712dd86a-5efb-4064-a761-c87ed10265b0',
'5a91129e-6964-47f3-84eb-e5fa026b983e') and activeflag =1;



update assessment
set activeflag = 0,updatedby = 'CJAMS-60595', updatedon = now() 
where assessmentid = '3226415d-36b2-4903-8078-79d7cb03cb6f' and activeflag =1;

update assessment_history 
set activeflag =0,updatedby = 'CJAMS-60595', updatedon = now() 
where assessmenthistoryid in ('9a0b3ef6-29da-4920-b6c6-6b77b8b8478e','bb5740ef-9a55-4e93-a2f4-9b20a965b62f') and activeflag =1;

update assessmentactor
set activeflag =0,updatedby = 'CJAMS-60595', updatedon = now() 
where assessmentactorid = '4f8deec9-9c38-490a-b859-5aa26d721456' and activeflag=1;

update routing
set activeflag =0,updatedby = 'CJAMS-60595', updatedon = now() 
where routingid = '4d8161fa-4b68-460e-b989-84f5d03375d8' and activeflag=1;

