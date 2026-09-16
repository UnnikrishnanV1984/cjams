-- CDM-29292-Correct start date of living arrangement
/*
-- Issue Description: 
-- 3259091:Please change the begin date of the first living arrangement (3024 Tennessee Ave , Halethorpe , Maryland , 21227) from 7/6/22 to 7/5/22. This is impacting our ability to check Title IV-e eligibility.
-- Email ID: megan.brasauskas1@maryland.gov

-- Resolution: Updated the startdatetime to 2022-07-05 in the livingarrangement,placement table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
	placement
set
	startdatetime = '2022-07-05 00:00:00.000',
	updatedby = 'CDM-29292',
	updatedon = now()
where
	placementid = '627eb167-30e3-4204-9c91-ff8446f99821'
	and activeflag = 1;

update
	livingarrangement
set
	livingstartdate = '2022-07-05 00:00:00.000',
	updatedby = 'CDM-29292',
	updatedon = now()
where
	placementid = '627eb167-30e3-4204-9c91-ff8446f99821'
	and activeflag = 1;

