-- CDM-21396 - Permanency Plan
/*
-- Issue Description: 
   user is unable to end date permanency plans	
   
-- Case ID: 3306089 - b0e18cb6-f349-4ac6-bce2-46c71ba9fa4f
-- Clients:
--	3728119 (BRE FORBES) - a8a5fb9f-491a-40bb-8fad-b40281837863
--	3951070	(RYAN KING GAMBLE) - 645826dc-4847-46d8-8e1e-d7c3ef933429
--	3951060	(ROBERT JAMAR GAMBLE) - 9364bb57-ef9f-42e4-b6f1-8c7509b1761a
--	3728122	(MIRRAGE TRAYVON FORBES) - 79f80a21-dcf1-4baf-a8cc-ebda4ef9777c
--	3728120	(BREA FORBES) - 29e16f07-9db9-4b57-9c65-bf44aa465606
--	4051174	(RYLEE GAMBLE) - 080c6d69-4255-49d2-b20e-381eec4ae6da
   
-- Category/ Module: Permanency Plan (Case Management)
-- Root cause: This is a known issue, Veera did a code fix for this and changes are available in the Stage 3.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next prod deployment
*/

-- To update End dates as 02/02/2022
-- and Reason as 'Reunification is the Permanency plan with a concurrent plan of Custody and Guardianship to relative.'

select permanencyplanid, intakeservicerequestactorid, 
	establisheddate, enddate, reason, updatedby, updatedon, servicecaseid
from cjams.permanencyplan
where permanencyplanid 
	in (	'96669ff6-a7fd-4059-b642-77ac57bd1a2b',
			'5aa25e57-093e-44ec-8d8c-ca7e2bc1b5ca',
			'250dff48-9c40-42ed-bc05-f06c1a45207c',
			'b6ba2467-1d31-46da-a4ad-a42723d17c0f',
			'ff8f5a3f-24a9-49c7-8d5b-0b153c3d3bc6',
			'774d6303-797b-4af6-8aca-fa5f2384434f'
		)	
	and activeflag = 1 
	and enddate is null ;

update cjams.permanencyplan 
set enddate = '2022-02-02 00:00:00',
	reason = 'Reunification is the Permanency plan with a concurrent plan of Custody and Guardianship to relative.',
	updatedby = 'CDM-21396',
	updatedon = now()
where permanencyplanid 
	in (	'96669ff6-a7fd-4059-b642-77ac57bd1a2b',
			'5aa25e57-093e-44ec-8d8c-ca7e2bc1b5ca',
			'250dff48-9c40-42ed-bc05-f06c1a45207c',
			'b6ba2467-1d31-46da-a4ad-a42723d17c0f',
			'ff8f5a3f-24a9-49c7-8d5b-0b153c3d3bc6',
			'774d6303-797b-4af6-8aca-fa5f2384434f'
		)	
	and activeflag = 1 
	and enddate is null ;
