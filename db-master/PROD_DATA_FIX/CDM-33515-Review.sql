/*
   Issue Description: CDM-33515
   Category/ Module  : case pending inbox 
   Root cause:  code update error
   Fix Provide: Did data fix to active the review record
*/

update cjams.routing set activeflag =1, updatedby ='CDM-33515', updatedon = now()
where routingid ='f76baac1-1f5a-4dfe-a943-051441c3ee37';
