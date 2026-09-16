-- CDM-19396 - Payment Issue
/*
-- Issue Description: 
	The provider was paid for the date of 09/27/21 instead of 09/15/21 in CJAMS. 
	It was corrected and the provider did not receive a full payment. 
	The provider is 12 days of payment.
   
-- Adoption Case ID: 211040011229
-- Client ID: 200813087 (A'ziyah Jolie Boyd) - ec514575-97c0-40d9-a3ef-ecbfb870a91b
-- Adoption ID: 1051280 - 2021-09-27 To	2036-10-20 - 1690c621-19c5-4a98-a16f-efdc8374586b
	
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Data issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Adoption Case Start Date as 2021-09-15 (old Value was 2021-09-27)
select alternateid, startdate, enddate, updatedby, updatedon
	from adoptioncase 
where adoptioncaseid = '1690c621-19c5-4a98-a16f-efdc8374586b'
	and activeflag = 1;

update adoptioncase
set startdate = '2021-09-15 19:45:46', 
	updatedon = now(), 
	updatedby = 'CDM-19396'
where adoptioncaseid = '1690c621-19c5-4a98-a16f-efdc8374586b'
	and activeflag = 1;

-- To Trigger Under/Over 
select startdate, enddate, updatedby, updatedon 
	from adoptioncaseagreementrate
where adoptionagreementrateid = '5dda632a-4905-40da-87f3-25464ae980da'
	and adoptionagreementid = '43143d05-6473-4a09-9370-d93967a5381f'
	and activeflag = 1 ;
	
update adoptioncaseagreementrate
set updatedon = now(), 
	updatedby = 'CDM-19396'
where adoptionagreementrateid = '5dda632a-4905-40da-87f3-25464ae980da'
	and adoptionagreementid = '43143d05-6473-4a09-9370-d93967a5381f'
	and activeflag = 1 ;
	