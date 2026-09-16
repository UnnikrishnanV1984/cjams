-- CDM-9753 - Expungement
/*
-- Issue Description: 
   The maltreator on this case was modified by agreement of all parties to "unnamed". 
   Two of the findings were changed to "unnamed" successfully, but the third finding 
   still showing the original maltreator's name.
   
   
   CPS IR: CW2945947
    
-- Category/ Module: CPS-IR  (Investigation Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Data fix to update the maltreator as unnamed
-- Client ID: 4433256 (CARLOS	VILLA) - 699b4931-78cd-4c13-b7ec-18b5c18347aa
-- AM Actor ID: 9d6c04a0-2a8d-44b2-9e52-66602f649b2c

-- Client ID: 200173495	(unnamed	unnamed) - d15f88cd-75b6-4684-9aba-dc44e7c9ae8e
-- AM Actor ID:  49e939e2-2a3f-414b-a5ea-b3ccbadcad9d

-- Old values 
-- 9d6c04a0-2a8d-44b2-9e52-66602f649b2c	279fcb3c-75cf-47a2-ae6c-2d6aabcde9c5	2020-10-20 13:37:40
select intakeservicerequestactorid, updatedby, updatedon 
    from cjams.Investigationallegationmaltreators
where investigationallegationmaltreatorsid  = '05f5ad9b-6fee-491a-beed-30d89c1cffc0'
 and activeflag  = 1 ;


update cjams.investigationallegationmaltreators
	set intakeservicerequestactorid = '49e939e2-2a3f-414b-a5ea-b3ccbadcad9d',
		updatedby = 'CDM-9753',
		updatedon = now()		
where investigationallegationmaltreatorsid  = '05f5ad9b-6fee-491a-beed-30d89c1cffc0'
 and activeflag  = 1 ;
