-- CDM-27881-Correct start date of living arrangement 
/*
File Name: CDM-27881-livingarrangement-UpdateStartDate
-- Issue Description: 
   For the Case Id 3276768: User requested to correct the start date of Cameron's initial living arrangement from 10/14/21 to 10/13/21
   and Remove the duplicate Living Arrangement on 10/14/2021 01:00PM  
   CLient Email ID :megan.brasauskas1@maryland.gov

-- Resolution: Updated the activeflag to zero and startdatetime to  2021-10-13 in the placement and livingarrangement table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


 update
	placement
set
	activeflag = 0,
	updatedby = 'CDM-27881',
	updatedon = now()
where
	placementid = '89113087-4ce3-4b4b-a713-8b84d1d38037'
	and activeflag = 1;

update
	livingarrangement
set
	activeflag = 0,
	updatedby = 'CDM-27881',
	updatedon = now()
where
	placementid = '89113087-4ce3-4b4b-a713-8b84d1d38037'
	and activeflag = 1;

update
	placement
set
	startdatetime = '2021-10-13 00:00:00',
	updatedby = 'CDM-27881',
	updatedon = now()
where
	placementid = '6a7e9ae8-f1aa-4167-96df-107fa9a6271f'
	and activeflag = 1;

update
	livingarrangement
set
	livingstartdate = '2021-10-13 00:00:00',
	updatedby = 'CDM-27881',
	updatedon = now()
where
	placementid = '6a7e9ae8-f1aa-4167-96df-107fa9a6271f'
	and activeflag = 1;
