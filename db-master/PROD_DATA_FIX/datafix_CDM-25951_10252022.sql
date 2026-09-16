-- CDM-25951  - Subsidy approval tab
/*
-- Issue Description: 
-- User is getting a notification to completed the subsidy rate on break the link approval. 
   
-- Case ID: 3217660 - 3d13dc02-af71-4a9e-97fc-ac6df31a815a
-- Client ID: 4259625 (ADONIS WEBB) - 36cabae9-d53a-40f5-a476-3066f21c435b

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Duplicate Record in Adoption Agreement table & Rate is connected with one
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Approved Rate update adoptionagreementid  = '120a1a1a-5e55-407f-90d6-d4ba36fe5ed7'
select activeflag, adoptionagreementid, activeflag, updatedby, updatedon
	from adoptionagreementrate   
where adoptionagreementid = 'c09a4d02-013f-487b-add0-0531f133ac29'
	and activeflag = 1 ;

update adoptionagreementrate
set adoptionagreementid = '120a1a1a-5e55-407f-90d6-d4ba36fe5ed7', 	
	updatedby = 'CDM-25951',
	updatedon = now()
where adoptionagreementid = 'c09a4d02-013f-487b-add0-0531f133ac29'
	and activeflag = 1 ;

-- update adoptionagreementid  = '120a1a1a-5e55-407f-90d6-d4ba36fe5ed7'
select activeflag, adoptionagreementid, activeflag, updatedby, updatedon
	from adoptionagreementraterevision   
where adoptionagreementid = 'c09a4d02-013f-487b-add0-0531f133ac29' ;

update adoptionagreementraterevision
set adoptionagreementid = '120a1a1a-5e55-407f-90d6-d4ba36fe5ed7', 	
	updatedby = 'CDM-25951',
	updatedon = now()
where adoptionagreementid = 'c09a4d02-013f-487b-add0-0531f133ac29' ;

-- Delete 
select adoptionplanningid, activeflag, updatedby, updatedon 
from adoptionagreement 
where adoptionagreementid  = 'c09a4d02-013f-487b-add0-0531f133ac29'
	and activeflag = 1 ;
 
update adoptionagreement
set activeflag = 0, 	
	updatedby = 'CDM-25951',
	updatedon = now()
where adoptionagreementid  = 'c09a4d02-013f-487b-add0-0531f133ac29'
	and activeflag = 1 ;
