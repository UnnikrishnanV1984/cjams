-- CDM-26509 - Investigation Findings do not show - 2
/*
-- Issue Description: 
    The investigation findings for CPS IR#221020242700 are not showing 
	nor can we print out the Investigation Summary Report.

-- CPS-IR:  221020242700 - 919923c6-669b-458b-a2c7-35e0cbdd1ce7
-- Client ID: 1667830 (ISIS E SMITH) - 3352ebfb-9407-4cea-b6b4-f3e49346e29e
-- intakeservicerequestactorid = bb4782bc-0582-4775-9741-a578c79d43ef - AM
    
-- Category/ Module: Maltreatment/Finding (Investigation Management)
-- Root cause: User error; the alleged maltreator role was deleted by the user. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To delete the Alleged maltreator person role
-- old values 
-- updatedby: d636ac2f-53ff-43e0-adbf-35c97e0427ec	& updatedon: 2022-10-19 09:46:55

select personid, intakeserviceid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon  
	from intakeservicerequestactor 
where intakeservicerequestactorid = 'bb4782bc-0582-4775-9741-a578c79d43ef'
	and activeflag = 0 ;

update cjams.intakeservicerequestactor
set activeflag = 1,
	updatedon = now(), 
	updatedby = 'CDM-26509'
where intakeservicerequestactorid = 'bb4782bc-0582-4775-9741-a578c79d43ef'
	and activeflag = 0 ;
	
-- Bring back the ICC Role
select personid, intakeserviceid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon  
	from intakeservicerequestactor 
where intakeservicerequestactorid = '18a4fd33-bf50-46bf-90f8-b55d42bf989a'
	and activeflag = 0 ;
	
update cjams.intakeservicerequestactor
set activeflag = 1,
	updatedon = now(), 
	updatedby = 'CDM-26509'
where intakeservicerequestactorid = '18a4fd33-bf50-46bf-90f8-b55d42bf989a'
	and activeflag = 0 ;
	
-- To Stop the timer
select * 
from cjams.cpsresponsetimerupdate( '919923c6-669b-458b-a2c7-35e0cbdd1ce7'::uuid, 'CDM-26509'::character varying ) ;
	
