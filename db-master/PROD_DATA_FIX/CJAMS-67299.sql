/*Issue Description:231030081823:Requesting that the note with contact ID: 16072458   in case 231030081823 be deleted. 
Root cause: User request to delete the  contact note, They can only able to update 
Fix provided: DB queries to update query to progressnote table
Data/Code fix ticket#: CJAMS-67299
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update progressnote
set activeflag = 0, updatedby = 'CJAMS-67299', updatedon = now()
where progressnoteid = 'ce922c9d-7381-4763-a16c-75d719bef0b6' and activeflag =1;


update progressnotedetail
set activeflag = 0, updatedby = 'CJAMS-67299', updatedon = now()
where progressnoteid = 'ce922c9d-7381-4763-a16c-75d719bef0b6' and activeflag =1;


--NO record in  contactparticipant