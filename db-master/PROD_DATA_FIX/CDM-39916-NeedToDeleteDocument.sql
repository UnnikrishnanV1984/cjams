/*
Issue Description: Datafix to soft delete the document named 'Hill Appeal Paperwork'
Category/ Module: Removal
Root cause: Document labeled Hill Appeal Paperwork was uploaded into the the wrong case.
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-39916
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update documentproperties
set
	activeflag = 0,
	updatedby = 'CDM-39916',
	updatedon = now()
where documentpropertiesid = '71dc933f-94e6-435b-9864-87cdc7155e62' and activeflag = 1;

update documentattachment
set
	activeflag = 0,
	updatedby = 'CDM-39916',
	updatedon = now()
where documentattachmentid = 'f11171de-86ed-40cb-be28-425690b173fa' and activeflag = 1;