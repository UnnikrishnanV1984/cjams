-- CDM-21572 - Perm Plan
/*
-- Issue Description: 
   Trying to end date old MD CHESSIE Perm. Plans. 
   System says to filling all areas and I have but it will not save.

-- Case ID: 3272425 - 51baa96d-6c4f-4f4e-9832-60cfed33c25c
-- Client ID: 4118912 (VICTORIA	M MARTIN) - 89b94ef9-e96d-44b4-8b9a-2cd8c3ce1c4b

-- Category/ Module: Permanency Plan (Case Management)
-- Root cause: User Error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


-- d0ceda11-1ab7-4dc8-8795-031bfcc064de	
-- 2018-09-12 To 2022-04-14 - Reunification	GUARDR
-- Update End date as 11/01/2019
-- Update End Reason as 'Change in the Permanency Plan'

select permanencyplanid, intakeservicerequestactorid, 
	establisheddate, enddate, reason, updatedby, updatedon, servicecaseid
from cjams.permanencyplan
where permanencyplanid = 'd0ceda11-1ab7-4dc8-8795-031bfcc064de'
	and activeflag = 1 ;
	
update cjams.permanencyplan 
set enddate = '2019-11-01 00:00:00',
	reason = 'Change in the Permanency Plan',
	updatedby = 'CDM-21572',
	updatedon = now()
where permanencyplanid = 'd0ceda11-1ab7-4dc8-8795-031bfcc064de'
	and activeflag = 1 ;

	
-- 669e18fa-8e60-454a-bd46-34c7bf7baa9b	
-- 2019-11-01 To 2022-04-14 - Reunification	GUARDR
-- Update End date as 05/01/2020
-- Update End Reason as 'Change in the Permanency Plan'

select permanencyplanid, intakeservicerequestactorid, 
	establisheddate, enddate, reason, updatedby, updatedon, servicecaseid
from cjams.permanencyplan
where permanencyplanid = '669e18fa-8e60-454a-bd46-34c7bf7baa9b'
	and activeflag = 1 ;
	
update cjams.permanencyplan 
set enddate = '2020-05-01 00:00:00',
	reason = 'Change in the Permanency Plan',
	updatedby = 'CDM-21572',
	updatedon = now()
where permanencyplanid = '669e18fa-8e60-454a-bd46-34c7bf7baa9b'
	and activeflag = 1 ;

