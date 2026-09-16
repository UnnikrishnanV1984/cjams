/*
   Issue Description: CDM-31611
   Category/ Module  : notifications
   Root cause:user want to update Staff name under notifications tab
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
update usernotification set subject='Service Agreement Submitted for review by Lindsey, Beck', 
body='Service Agreement Submitted for review by Lindsey, Beck'
where usernotificationid='081bd878-676d-4aff-b989-2a20fe20538d' ;


update usernotificationmap set fromsecurityusersid='5c38882f-227a-49ee-b516-b6a87dbc5b0a' 
 where usernotificationmapid='fd75b1e6-a56b-484b-b980-c31716aa73c3';