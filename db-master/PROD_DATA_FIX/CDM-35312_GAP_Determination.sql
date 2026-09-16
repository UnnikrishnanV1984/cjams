-- CDM-35312 - GAP Determination of Incomplete
/* Issue Description:User request to update relationship id for guardian parent in IV-E side #4380578

-- Person ID: 4380578

-- Category/ Module: Title IV-E  

-- Root cause: User request to update relationship id for guardian parent in IV-E side #4380578 
-- Fix Provided: Datafix has been provided and updated relationshipId #4380578
-- Pull request# N/A

*/

select primaryguardianrelationship, primaryguardianrelationshipid, secondguardianrelationship, secondguardianrelationshipid, * from gapeligibilityinfo where client_id = '4380578' and primaryguardianrelationship='Grandmother' and secondguardianrelationship='Grandfather';

update gapeligibilityinfo
set primaryguardianrelationshipid='1001' ,
	secondguardianrelationshipid='1001',
	updatedon = now(), 	
	updatedby = 'CDM-35312'
where client_id = '4380578' and primaryguardianrelationship='Grandmother' and secondguardianrelationship='Grandfather';