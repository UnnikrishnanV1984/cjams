/*
   CDM-37217 - Screen Out
   Issue Description: Unable to screen out this case
   Category/ Module  : Screenout
   Root cause: User request to screen out the case #I231011673955
   Fix Provided: Datafix has been provided to update case to screenout
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastaging
set    jsondata = jsonb_set(jsondata, '{DAType}', jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
		  jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
		  jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"')))),
       status = 'Closed',
       updatedon = now(),
       updatedby = 'CDM-37217'
where  intakenumber = 'I231011673955' and activeflag = 1 ;

update intakesnapshot
set    jsondata = jsonb_set(jsondata, '{DAType}', jsonb_set(jsondata->'DAType', '{DATypeDetail}',
		  jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
		  jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
       updatedby = 'CDM-37217', 
       updatedon = now()
where  intakenumber = 'I231011673955' AND activeflag = 1;

update routing 
set updatedby = 'CDM-37217', updatedon = now(), activeflag = 0, routingstatustypeid = 8
where objectid = 'I231011673955' and routingid = 'dc53c177-0d8f-471b-9d7a-d52993a9ad1b';

update intakeservicerequest
set activeflag = 1, updatedon = now(), updatedby = 'CDM-37217'
where intakeserviceid = 'c7b5798f-e985-4088-9304-20299f929ee9' and activeflag = 0;

update personprogramarea
set activeflag = 0, updatedon = now(), updatedby = 'CDM-37217'
where objectid = 'c7b5798f-e985-4088-9304-20299f929ee9' AND activeflag = 1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-37217', updatedon = now() 
where objectid = 'c7b5798f-e985-4088-9304-20299f929ee9';