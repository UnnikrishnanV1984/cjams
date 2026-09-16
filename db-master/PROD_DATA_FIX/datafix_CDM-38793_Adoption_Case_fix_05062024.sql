-- CDM-38793 - Adoption payment wrong
/*
-- Issue Description: 
   The provider #5095362 only received an adoption payment from 2/28/2024 - 2/29/2024 for 3 children. 
   The work to enter the adopion subisdy occurred 2/28/2024, but should not cause the payment to start on 2/28/2024. 
   
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: On the bio case side adoption start date and the rate start was entered as 02/28/2024.
		and on then on the adoption case side the start date was updated to 02/16/2024.
-- Fix Provided: Datafix has been promoted to fix the adoptioncase start date as 02/16/2024 for all 3 cases.
-- Pull request# N/A 
-- Reason why no related code fix: Please replicate this issue in Stage 3 and create CDIM for the code fix.
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update Adoption Case Start dates (CDM-38793) 

-- Case # 241040283062 / Provider ID: 5095362 / Adoption ID: 1066880
-- Client ID: 202814373	(Nehemiah Jerahmeel Frederick Best) - f4cce9b8-a22e-423a-b3fe-9f22eba02c67

update adoptioncase
set startdate = '2024-02-16 14:35:27.478',
	updatedon = now(), 
	updatedby = 'CDM-38793'
where adoptioncaseid = '56f8ef8e-9cf6-47b5-9ae8-4fe565c7e2ae'
	and activeflag = 1;

-- To Trigger Under/Over 
update adoptioncaseagreementrate
set updatedon = now(), 
	updatedby = 'CDM-38793'
where adoptionagreementrateid = '7592fdb6-1c21-41df-8965-ddfffb4ac563'
	and adoptionagreementid  = 'd5e9d1be-4ce5-490a-bb81-2901746b76c9'
	and activeflag = 1 ;


-- Case # 241040283131 / Provider ID: 5095362 / Adoption ID: 1066847
-- Client ID 202814436 (Galilea Elizabeth Vera	Best) - c810eb00-bcdf-46b2-82af-48bb354ec275 

update adoptioncase
set startdate = '2024-02-16 15:51:15.178',
	updatedon = now(), 
	updatedby = 'CDM-38793'
where adoptioncaseid = 'ff44bd90-46f9-4063-b289-32b9aba3ca17'
	and activeflag = 1;

-- To Trigger Under/Over 
update adoptioncaseagreementrate
set updatedon = now(), 
	updatedby = 'CDM-38793'
where adoptionagreementrateid = '303b73c8-a0bb-4f74-b7cd-b2eea450207f'
	and adoptionagreementid  = 'b90a6cb7-3883-40d8-b112-db7be986343d'
	and activeflag = 1 ;
	

-- Case # 241040283365 / Provider ID: 5095362 / Adoption ID: 1066814
-- Client ID 202814680 (Zephaniah Frederick Nehemiah Best) - d0a773f8-6c61-4a57-a670-f255c4c23d32

update adoptioncase
set startdate = '2024-02-16 17:54:38.854',
	updatedon = now(), 
	updatedby = 'CDM-38793'
where adoptioncaseid = '56c52d61-8c6c-4393-82c4-83edde6606b9'
	and activeflag = 1;

-- To Trigger Under/Over 
update adoptioncaseagreementrate
set updatedon = now(), 
	updatedby = 'CDM-38793'
where adoptionagreementrateid = 'a6f8007b-e765-4939-ba9c-55fbbe1c5cc2'
	and adoptionagreementid  = '03653dd8-166c-411d-9708-2b66960fc417'
	and activeflag = 1 ;
