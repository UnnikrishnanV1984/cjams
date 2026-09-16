/*
 Issue Description: CDM-40386
-- Category/ Module: Case Profile, Notes
-- Root cause: User Error, User wants to update the contact type 
-- Fix Provided: Datafix has been promoted to update the contact type to Face to Face.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
/*
select progressnotetypeid, progressnotereasontypekey, contactdate, activeflag, updatedby, updatedon
	from progressnote
where witsid in (14716696,14716685)
	and activeflag = 1 ; -- 786495b2-c779-4cc4-b812-6a8439bfa96e -- face to face	
*/

update progressnote
set progressnotetypeid = '6e55bc3a-e5c1-4eba-bff1-36dd89608c6e', -- file cabinet case
	updatedby = 'CDM-43659',
	updatedon = now()
where witsid in (14716696,14716685)
	and activeflag = 1 ;