--CDM-27882-Correct start date of living arrangement
/*
File Name: CDM-27882-livingarrangement-Correctstartdate
-- Issue Description: 
   For the Case ID: 3276768 : start date of Ka Niyah's initial living arrangement should be corrected from 10/14/21 to 10/13/21
   Email ID: megan.brasauskas1@maryland.gov

-- Resolution: Updated the startdatetime to 10/13/21 in the livingarrangement,placement table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
	placement
set
	startdatetime = '2021-10-13 00:00:00',
	updatedby = 'CDM-27882',
	updatedon = now()
where
	placementid = 'bb8b644b-8a03-4bb6-9f7a-a9e9e715825c'
	and activeflag = 1;

update
	livingarrangement
set
	livingstartdate = '2021-10-13 00:00:00',
	updatedby = 'CDM-27882',
	updatedon = now()
where
	placementid = 'bb8b644b-8a03-4bb6-9f7a-a9e9e715825c'
	and activeflag = 1;
