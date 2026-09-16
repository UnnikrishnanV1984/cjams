-- CDM-20456 Child Removal
/*
-- Issue Description: 
	User request to change the removal type to Judicial Determination - JD
	Current Type: Enhanced aftercare - EHA
   
-- Case ID: 3109154
-- Client ID: 1657198 (ADRANIE M BROOKS) - 4c8c9931-8454-4a2f-b62a-b3a45c20f314
-- Removal ID: 252689 - 2021-06-02 To Current - 6ec8dbc6-ec5d-4b8f-a95b-a62469e44584

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix  to change the removal type to Judicial Determination - JD 

-- Update Removal
select removalid, removaltypekey, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 252689
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set removaltypekey = 'JD',
	updatedby = 'CDM-20456',
	updatedon = now()
where removalid = 252689
	and activeflag = 1 ;
