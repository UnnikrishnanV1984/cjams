/*
-- CJAMS-68748- 

-- Issue Description: 
I261014115645 - Intake needs to be screened out so that CPS-IR : 261023837190 gets deleted on its own, need to inform the user and initiate approval with SSA

-- Root cause: Data fix to set the activeflag to zero
-- Pull request# 5973
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservicerequest 
set activeflag = 0, updatedby = 'CJAMS-68748', updatedon = now()  
where intakeserviceid = '3dbe1331-883a-464d-b5cf-71a6a818997b' and activeflag = 1;

update caseassignment
set activeflag=0, updatedby = 'CJAMS-68748', updatedon = now() 
where objectid ='3dbe1331-883a-464d-b5cf-71a6a818997b' and activeflag = 1;

update personprogramarea
set activeflag=0, updatedby = 'CJAMS-68748', updatedon = now() 
where objectid ='3dbe1331-883a-464d-b5cf-71a6a818997b' and activeflag = 1;

update intakeservicerequestsdm 
set activeflag = 0, updatedby = 'CJAMS-68748', updatedon = now()  
where intakeserviceid = '3dbe1331-883a-464d-b5cf-71a6a818997b' and activeflag = 1;

update intakeservicerequestdispositioncode 
set activeflag = 0, updatedby = 'CJAMS-68748', updatedon = now()  
where intakeserviceid = '3dbe1331-883a-464d-b5cf-71a6a818997b' and activeflag = 1;

update routing
set activeflag=0, updatedby = 'CJAMS-68748', updatedon = now() 
where objectid ='3dbe1331-883a-464d-b5cf-71a6a818997b' and activeflag = 1;

--DELETE PERSONS ONLY FROM CASE.

update actor  
set activeflag=0, updatedby = 'CJAMS-68748', updatedon = now()  
where intakeserviceid = '3dbe1331-883a-464d-b5cf-71a6a818997b' and activeflag = 1;

update intakeservicerequestactor  
set activeflag=0, updatedby = 'CJAMS-68748', updatedon = now()  
where intakeserviceid = '3dbe1331-883a-464d-b5cf-71a6a818997b' and activeflag = 1;

update personrole  
set activeflag=0, updatedby = 'CJAMS-68748', updatedon = now()  
where intakeserviceid = '3dbe1331-883a-464d-b5cf-71a6a818997b' and activeflag = 1;

update actorrelationship  
set activeflag=0, updatedby = 'CJAMS-68748', updatedon = now()  
where intakeserviceid = '3dbe1331-883a-464d-b5cf-71a6a818997b' and activeflag = 1;

update personrole  
set activeflag=0, updatedby = 'CJAMS-68748', updatedon = now() 
WHERE personroleid IN ('538158e1-821d-4060-a510-d78cf7590d00','1fcc41db-555b-49d6-b1b7-a6294ee9a084','f7e2ce47-c2d7-4c80-bdd2-5a11f1c50055','a2229cc3-8555-4655-886c-404e39d02104','a8c89ce1-4967-4a72-91b3-becdf804ebdb') and activeflag = 1;

