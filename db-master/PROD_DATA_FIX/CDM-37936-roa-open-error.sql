/*
   Issue Description: CDM-37936
   Category/ Module  : ROA open in error
   Case#: 231021120948
   Root cause: There are no information available in the service case. Delete this ROA case as requested by user.
   Fix: Data fix promoted to remove the case number # 231021120948 from CW and person (client ID # 1295428) prior case history.
*/ 

-- Intakeserviceid - 8b447b67-2593-4412-84e3-fca85b197562
-- servicecaseid - null
select * from intakeservicerequest i where servicerequestnumber = '231021120948' and activeflag = 1;
-- UPDATE cjams.intakeservicerequest
-- SET activeflag=1, updatedby='ba384e95-a535-4b1f-b9ea-b94c4f9ef782', updatedon='2023-09-22 23:55:51.966'
-- WHERE intakeserviceid='8b447b67-2593-4412-84e3-fca85b197562'::uuid;

UPDATE intakeservicerequest  
SET  activeflag = 0, 
updatedby = 'CDM-37936', updatedon = now() 
WHERE intakeserviceid = '8b447b67-2593-4412-84e3-fca85b197562' AND activeflag = 1;

select caseassignmentid,activeflag,updatedby,updatedon from caseassignment 
where objectid = '8b447b67-2593-4412-84e3-fca85b197562' AND activeflag = 1;
-- UPDATE cjams.caseassignment
-- SET activeflag=1, updatedby='ba384e95-a535-4b1f-b9ea-b94c4f9ef782', updatedon='2023-09-23 00:02:22.521'
-- WHERE caseassignmentid='c59d6898-ee31-4b80-b611-c164d42be01b'::uuid;

update caseassignment
set activeflag = 0, updatedby = 'CDM-37936', updatedon = now() 
where objectid = '8b447b67-2593-4412-84e3-fca85b197562' AND 
caseassignmentid='c59d6898-ee31-4b80-b611-c164d42be01b'::uuid AND activeflag = 1;

select routingid,activeflag,updatedby,updatedon from routing where objectid = '8b447b67-2593-4412-84e3-fca85b197562'  AND activeflag = 1;
-- UPDATE cjams.routing
-- SET activeflag=1, updatedby='ba384e95-a535-4b1f-b9ea-b94c4f9ef782', updatedon='2023-09-23 00:02:22.521'
-- WHERE routingid='c2e6535c-102b-428f-a1bf-1685c212f010'::uuid;

update routing
set activeflag = 0, updatedby = 'CDM-37936', updatedon = now() 
where objectid = '8b447b67-2593-4412-84e3-fca85b197562' AND routingid='c2e6535c-102b-428f-a1bf-1685c212f010'::uuid AND activeflag = 1;

-- No data
select * from personprogramarea  WHERE objectid = '8b447b67-2593-4412-84e3-fca85b197562' AND activeflag =1;