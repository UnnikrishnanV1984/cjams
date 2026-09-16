-- CDM-32649 - Rremoval of alleged Maltreator Tag
/*
-- Issue Description: 
	User request to remove the Alleged Maltreator role from Mason Kaplan (CJAMS PID# 3666755)
   
-- CPS-IR 2021048082374 - 96570c71-6a7f-4a26-b22a-d122417f96cc
-- Client ID: 3666755 (MASON KAPLAN) - e9483eb7-a282-47dc-8ffb-6fdb1a25fc9b
   
-- Category/ Module: Person roles (Investigation Management)
-- Root cause: User Error, Alleged Maltreator was incorrcelty added for this client.
-- Fix Provided: Datafix has been promoted to remove the Alleged Maltreator role from Mason Kaplan (CJAMS PID# 3666755)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select personid, intakeserviceid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon 
	from intakeservicerequestactor
where intakeservicerequestactorid = '52fa028c-ca87-4b5c-a63a-3ec8cfd1f3d0'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-32649',
	updatedon = now()
where intakeservicerequestactorid = '52fa028c-ca87-4b5c-a63a-3ec8cfd1f3d0'
	and activeflag = 1 ;
