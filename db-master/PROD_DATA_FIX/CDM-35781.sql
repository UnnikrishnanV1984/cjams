-- CDM-35781 - Eligibiltiy worksheet is blank,
-- Fix is for few clients, childexpectedadoptiveproviderid type is string because it's a user entry field in UI, so did
-- a datafix to update the provider_id with correct value and in UI added validation to allow only numbers.

update tb_ive_adoption_audit set childexpectedadoptiveproviderid = 5055164,updatedby = 'CDM-35781', updatedon = now() where cjamspid = 200829849;
update tb_ive_adoption_audit set childexpectedadoptiveproviderid = 5055164,updatedby = 'CDM-35781', updatedon = now() where cjamspid = 200829850;
