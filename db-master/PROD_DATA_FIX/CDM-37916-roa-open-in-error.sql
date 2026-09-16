/*
   Issue Description: CDM-37916
   Category/ Module  : ROA open in error
   Case#: 231020555372
   Root cause: There are no information available in the service case. Delete this ROA case as requested by user.
   Fix: Data fix promoted to remove the case number # 231020555372 from CW and person (client ID # 2051645) prior case history.
*/ 

-- Intakeserviceid - 61612f2a-f414-4bdf-9418-bb3f5d11bf3b
-- servicecaseid - null
select * from intakeservicerequest i where servicerequestnumber = '231020555372' and activeflag = 1;
-- UPDATE cjams.intakeservicerequest
-- SET servicecaseid=NULL, activeflag=1, updatedby='9c424094-8dc4-4015-9a32-3a7020615f11', updatedon='2023-05-31 13:29:29.944'
-- WHERE intakeserviceid='61612f2a-f414-4bdf-9418-bb3f5d11bf3b'::uuid;

UPDATE intakeservicerequest  
SET  activeflag = 0, 
updatedby = 'CDM-37916', updatedon = now() 
WHERE intakeserviceid = '61612f2a-f414-4bdf-9418-bb3f5d11bf3b' AND activeflag = 1;

select caseassignmentid,activeflag,updatedby,updatedon from caseassignment 
where objectid = '61612f2a-f414-4bdf-9418-bb3f5d11bf3b' AND activeflag = 1;
-- UPDATE cjams.caseassignment
-- SET activeflag=1, updatedby='9c424094-8dc4-4015-9a32-3a7020615f11', updatedon='2023-05-31 13:32:06.811'
-- WHERE caseassignmentid='4b681639-b22b-4b9d-8519-1dd30b10e4b1'::uuid;

update caseassignment
set activeflag = 0, updatedby = 'CDM-37916', updatedon = now() 
where objectid = '61612f2a-f414-4bdf-9418-bb3f5d11bf3b' AND activeflag = 1;

select routingid,activeflag,updatedby,updatedon from routing where objectid = '61612f2a-f414-4bdf-9418-bb3f5d11bf3b'  AND activeflag = 1;
--UPDATE cjams.routing
--SET activeflag=1, updatedby='9c424094-8dc4-4015-9a32-3a7020615f11', updatedon='2023-05-31 13:32:06.811'
--WHERE routingid='cee6733a-041b-4771-bcdd-e73bf9dcd2a5'::uuid;

update routing
set activeflag = 0, updatedby = 'CDM-37916', updatedon = now() 
where objectid = '61612f2a-f414-4bdf-9418-bb3f5d11bf3b' and activeflag = 1;

-- No data
select * from personprogramarea  WHERE objectid = '61612f2a-f414-4bdf-9418-bb3f5d11bf3b' AND activeflag =1;