-- CDM-37562 - Applicable Child Assessment
/* Issue Description: User is unable to see the values in assessment form for service case #3292205

-- case number: 3292205
-- client id: 4234805
--removalis: 200002

-- Category/ Module: Permanency plan 

-- Root cause: User is unable to see the values in assessment form for service case #3292205 
-- Fix Provided: Datafix has been provided to update childexpectedadoptiveproviderid where name is saved insted of id
-- Pull request# N/A

*/

select * from tb_ive_adoption_audit where adoptionauditid = 46343;	
				
UPDATE cjams.tb_ive_adoption_audit
SET childexpectedadoptiveproviderid='6004902',
updatedby = 'CDM_37562',
updatedon = now()
WHERE adoptionauditid=46343;