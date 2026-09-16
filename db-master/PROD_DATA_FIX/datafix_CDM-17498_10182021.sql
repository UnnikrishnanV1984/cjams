-- CDM-17498 - Undo Child Removal End Date
/*
-- Issue Description: 
   User error, Datafix request to re-open child Removal.
   
-- Case ID: 3169428
-- Client ID: 3191610 (MICHAEL P MC HALE) - 3b49aac2-7d1c-4fab-a0ca-81b59575275f
-- Removal ID: 138376 - 2010-12-09 To 2021-07-02 - e8dbe4e0-5cee-45c0-bb81-e36f7ceabcaa
    
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to remove Removal End date (Old value was 2021-07-02)
-- Update Removal, OOH & IV-E

-- Update Removal
select removaldate, exitdate, removalexitreason, updatedby, updatedon  
	from cjams.intakeservreqchildremoval
where removalid = 138376
	and personid = '3b49aac2-7d1c-4fab-a0ca-81b59575275f' 
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	removalexitreason = Null,
	updatedby = 'CDM-17498',
	updatedon = now()
where removalid = 138376
	and personid = '3b49aac2-7d1c-4fab-a0ca-81b59575275f' 
	and activeflag = 1 ;
	
-- Legal Custody
select fromdate, todate, updatedby, updatedon
	from legalcustody 
where legalcustodyid = 'd02e0358-ecca-4f5b-a81b-fa186a1408ea'
	and activeflag = 1;

update cjams.legalcustody 
set todate = Null, 
	updatedby = 'CDM-17498',
	updatedon = now()
where legalcustodyid = 'd02e0358-ecca-4f5b-a81b-fa186a1408ea'
	and activeflag = 1;
	
-- No Updates to Eligibility 

