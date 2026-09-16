/*
   Issue Description: CDM-37915
   Category/ Module  : ROA opened in error
   Case#: 231021303009
   Root cause: There are no information available in the service case. Delete this ROA case as requested by user.
   Fix: Data fix promoted to remove the case number # 231021303009 from CW and person (client ID # 1343655) prior case history.
*/ 

-- Intakeserviceid - 23408c48-e1f9-473a-be66-1ba3b19c6c92
-- servicecaseid - null
select intakeserviceid ,servicecaseid,activeflag,updatedby,updatedon from intakeservicerequest i where servicerequestnumber = '231021303009' and activeflag = 1;
--UPDATE cjams.intakeservicerequest
--SET servicecaseid=NULL, activeflag=1, updatedby='9c424094-8dc4-4015-9a32-3a7020615f11', updatedon='2023-11-03 12:39:57.837'
--WHERE intakeserviceid='23408c48-e1f9-473a-be66-1ba3b19c6c92'::uuid;

UPDATE intakeservicerequest  
SET  activeflag = 0, 
updatedby = 'CDM-37915', updatedon = now() 
WHERE intakeserviceid = '23408c48-e1f9-473a-be66-1ba3b19c6c92' AND activeflag = 1;

-- No data
select caseassignmentid,activeflag,updatedby,updatedon from caseassignment 
where objectid = '23408c48-e1f9-473a-be66-1ba3b19c6c92' AND activeflag = 1;

select routingid,activeflag,updatedby,updatedon from routing where objectid = '23408c48-e1f9-473a-be66-1ba3b19c6c92'  AND activeflag = 1;

select * from personprogramarea  WHERE objectid = '23408c48-e1f9-473a-be66-1ba3b19c6c92' AND activeflag =1;