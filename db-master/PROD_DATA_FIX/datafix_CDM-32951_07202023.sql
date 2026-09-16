-- CDM-32951 - Head of Household is gone
/*
-- Issue Description: 
	The Head of Household has disappeared from Case ID: 231030110691

-- Case ID: 231030110691 - 4105e1c2-37db-440c-bfe6-0258d02e8654
-- Client ID: 4461760 (SOMER E WILKES) - a03aa913-1bca-43e6-ba29-ff4db391b475
-- 314f43ca-5646-427c-ab39-a757458deee8	AM
-- e0365dab-fb45-402c-84f1-954a06b76ac8	PARENT

-- Category/ Module: Person (Investigation Management)
-- Root cause: Data Issue - isprimary is false for all records in intakeservicerequestactor table
-- Fix Provided: Datafix has been promoted make the PARENT role as isprimary = true
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update isprimary as true (CDM-32951) 
-- e0365dab-fb45-402c-84f1-954a06b76ac8	PARENT
select intakeservicerequestactorid, intakeservicerequestpersontypekey, isprimary, 
	intakenumber, intakeserviceid, servicecaseid, activeflag, updatedby, updatedon
from intakeservicerequestactor
where intakeservicerequestactorid = 'e0365dab-fb45-402c-84f1-954a06b76ac8'
	and isprimary = false
	and activeflag = 1 	;
	

update intakeservicerequestactor
set isprimary = true,
	updatedby = 'CDM-32951',
	updatedon = now()
where intakeservicerequestactorid = 'e0365dab-fb45-402c-84f1-954a06b76ac8'
	and isprimary = false
	and activeflag = 1 ;


-- Update isprimary as false ( record is not havign service case ID)
-- bb66543a-d2cd-4a45-800e-ca4364ed1354 LG
select intakeservicerequestactorid, intakeservicerequestpersontypekey, isprimary, 
	intakenumber, intakeserviceid, servicecaseid, activeflag, updatedby, updatedon
from intakeservicerequestactor
where intakeservicerequestactorid = 'bb66543a-d2cd-4a45-800e-ca4364ed1354'
	and isprimary = true
	and activeflag = 1 	;
	

update intakeservicerequestactor
set isprimary = false,
	updatedby = 'CDM-32951',
	updatedon = now()
where intakeservicerequestactorid = 'bb66543a-d2cd-4a45-800e-ca4364ed1354'
	and isprimary = true
	and activeflag = 1 ;