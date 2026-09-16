
/*
Issue Description:251023082663:Requesting that the note with contact ID: 15184696 uploaded July 21st 11:46:22am in case 251023082663 be deleted. The contact note was left unfinished for too long and a completed copy of the original note was uploaded. Requesting the deletion of the unfinished note
Root cause: User request to delete the incomplete contact note, They can only able to update 
Fix provided: DB queries to update query to progressnote table
Data/Code fix ticket#: CJAMS-60883
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update progressnote
set activeflag = 0, updatedby = 'CJAMS-60883', updatedon = now()
where progressnoteid = 'ccf7c7f0-c7ab-406e-b11a-619442e74488' and activeflag =1;


update progressnotedetail
set activeflag = 0, updatedby = 'CJAMS-60883', updatedon = now()
where progressnotedetailid = '6923091d-2790-4e82-8ae1-5b72bd37d0aa' and activeflag =1;


update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-60883', updatedon = now()
where contactparticipantid = 'f7fe5b64-2aff-4853-93b5-1639a899100e' and activeflag =1;