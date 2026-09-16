
/*
Issue Description:251023070806:An incorrect video was uploaded in a closed CPS investigation. Video is unable to be deleted. Please remove the following video from the documents section: 20250613 Video Wade.MOVSupporting Case Evidence06/13/2025ProtectionSupporting Case EvidenceTaryn Shambaugh06/13/2025 02:01 PM Screen
Root cause: User requert to delete document  due to they do not access do that.
Fix provided: DB query to udate documentproperties,documentattachment.
Data/Code fix ticket#:CJAMS-61696
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update documentproperties
set activeflag =0, updatedby = 'CJAMS-61696', updatedon=now()
where documentpropertiesid ='1d1d9e84-a3a6-4138-bd44-2457afd4d497' and activeflag=1;

update documentattachment
set activeflag =0, updatedby = 'CJAMS-61696', updatedon=now()
where documentattachmentid ='1cba4f46-2f23-4530-887e-1902ecb0b7b6' and activeflag=1;