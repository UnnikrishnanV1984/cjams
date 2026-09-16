-- CDM-20321 - removal ended in error
/*
-- Issue Description: 
   User error, Datafix request to re-open Removal/OOH for Dayvion Foreman #2040298 was ended in error.
   
-- Case ID: 211030012480 (Other Case 3153187)
-- Client ID: 2040298 (DAYVION FOREMAN) - 914f201d-869d-4333-94d7-6bfcc2c5c875
-- Removal ID: 253309 - 2021-11-24 To 2021-12-22  - 1edaa903-2943-46a6-951a-256c711e3852

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Removal, OOH & IV-E
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 253309
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-20321',
	updatedon = now()
where removalid = 253309
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where  personprogramid  = 'c4fe1a52-ba3b-4be6-a20e-7314f3b15373'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-20321',
	updatedon = now()
where  personprogramid  = 'c4fe1a52-ba3b-4be6-a20e-7314f3b15373'
	and activeflag = 1 ;
	

/*
No Eligibility/Period(s) with the same end date 
No Legal Custody with the same end date 
*/
