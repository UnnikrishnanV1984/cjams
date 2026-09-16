/*
 Issue Description: CDM-36223
 Category/ Module : Permanancy Plan/Adoption Break The Link
 Root cause: Duplicate Adoption break the link records exists one with approval status and one with review status.
 Fix: Soft delete the un approved record per user request
 Pull request# for code fix: N/A
 Reason why no related code fix: 
 Need to do data fix
 */

select * from adoptionbreakthelink where adoptionbreakthelinkid = '01901a34-a86d-41cf-8335-00b252e4b0b0' and activeflag = 1;

UPDATE adoptionbreakthelink
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36223'
	WHERE adoptionbreakthelinkid = '01901a34-a86d-41cf-8335-00b252e4b0b0' and activeflag = 1;
	
