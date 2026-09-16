-- CDM-35705 - Incomplete Determination
/* Issue Description:User request to update relationship id for guardian parent in IV-E side #4220118

-- Person ID: 4220118

-- Category/ Module: Title IV-E  

-- Root cause: User request to update relationship id for guardian parent in IV-E side #4220118 
-- Fix Provided: Datafix has been provided and updated relationshipId #4220118
-- Pull request# N/A

*/

select primaryguardianrelationship, primaryguardianrelationshipid, * from gapeligibilityinfo where client_id = '4220118' and activeflag =1;

update gapeligibilityinfo
set primaryguardianrelationshipid='1001' ,
	updatedon = now(), 	
	updatedby = 'CDM-35705'
where client_id = '4220118' and activeflag =1;