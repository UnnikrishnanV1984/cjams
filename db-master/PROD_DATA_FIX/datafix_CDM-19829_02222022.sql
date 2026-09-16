-- CDM-19829 - Mislabeled Maltreator
/*
-- Issue Description: 
    In 2011, Ms Brooke Vance, DOB 08/03/1989 PID 1671276, was listed as a maltreator in error. 

-- CPS IR: CW2734448 - 11788df8-742f-45ca-a503-e1c4e3a4fc58
-- Client ID: 1671276 (BROOKE VANCE) - 442d2957-1302-4458-83f6-0569ad782ca8
    
-- Category/ Module: Maltreatment/Finding (Investigation Management)
-- Root cause: User error; the alleged maltreator role was addred by the caseworker. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To delete the Alleged maltreator person role
-- old values 
-- updatedby: RMC200830	& updatedon: 2011-11-07 15:15:15

select personid, intakeserviceid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon  
	from intakeservicerequestactor 
where intakeservicerequestactorid  = 'b3c49505-dc1c-48df-97c0-faf2c94f6316'
	and activeflag = 1 ;

update cjams.intakeservicerequestactor
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-19829'
where intakeservicerequestactorid  = 'b3c49505-dc1c-48df-97c0-faf2c94f6316'
	and activeflag = 1 ;
