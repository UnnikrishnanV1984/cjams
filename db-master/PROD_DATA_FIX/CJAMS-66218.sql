/*Issue Description:251030510577:Requesting that the note with contact ID: 15188580  in case 251023082663 be deleted. 
Root cause: User request to delete the  contact note, They can only able to update 
Fix provided: DB queries to update query to progressnote table
Data/Code fix ticket#: CJAMS-66218
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update progressnote
set activeflag = 0, updatedby = 'CJAMS-66218', updatedon = now()
where progressnoteid = '30420b8c-16e9-4136-af29-6e2beaaf7e2f' and activeflag =1;


update progressnotedetail
set activeflag = 0, updatedby = 'CJAMS-66218', updatedon = now()
where progressnoteid = '30420b8c-16e9-4136-af29-6e2beaaf7e2f' and activeflag =1;


update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-66218', updatedon = now()
where contactparticipantid = 'f7fe5b64-2aff-4853-93b5-1639a899100e' and activeflag =1;