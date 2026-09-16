-- CDM-10024 - Maltreator Findings Missing in Closed record
/*
-- Issue Description: 
    CPS IR #20200300046059 
	Person PID# 200165022 was one of the alleged maltreators in the case. 
	Now the alleged maltreator role, maltreatment and Investigation info is missing.

    
-- Category/ Module: Maltreatment/Finding (Investigation Management)
-- Root cause: User error; the alleged maltreator role was removed by the caseworker. 
		Potentiall candidate for a refinement to add validation on person role changes.    	  
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Bring back the Alleged maltreator person role
-- old values 
-- updatedby: 9ca9a597-fd93-43e7-b5e7-1b32d4a8c56f	& updatedon: 2020-11-17 10:40:23
select activeflag, personid, intakeservicerequestpersontypekey, updatedby, updatedon 
   from cjams.intakeservicerequestactor 
where intakeservicerequestactorid  = '8cff6688-fedf-422e-ae75-d4d129f1d6fa'
   and activeflag  = 0 ;


update cjams.intakeservicerequestactor
set activeflag = 1,
	updatedon = now(), 
	updatedby = 'CDM-10024'
where intakeservicerequestactorid  = '8cff6688-fedf-422e-ae75-d4d129f1d6fa'
   and activeflag  = 0 ;

