 /*
  Issue Description: CDM-32654
   Category/ Module  : Intake Aprroval  
   Root cause: Wrong timestamp is in the narrative incident date(Not replicable in stage3)
   Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
update intakesnapshot 
set updatedby = 'CDM-32654',
    updatedon = now(),
    jsondata = replace(jsondata::text, '"incidentdate": "+020232-06-23T04:00:00.000Z"', '"incidentdate": "2023-06-23T05:00:00.000Z"')::json
where intakenumber = 'I231010707060' and activeflag = 1;

update intakedastaging
set updatedby = 'CDM-32654',
    updatedon = now(),
    jsondata = replace(jsondata::text, '"incidentdate": "+020232-06-23T04:00:00.000Z"', '"incidentdate": "2023-06-23T05:00:00.000Z"')::json
where intakenumber = 'I231010707060' and activeflag = 1;