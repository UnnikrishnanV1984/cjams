/*
Issue Description: Need data fix to remove progress note and delete Contact ID: 14956788 from Case# 251030493163.
Category/Module: Bug
Root cause: Users cannot change the contacts numbers  in  contacts tab, They can able to update 
Fix provided: DB queries to update query to progressnote table
Data/Code fix ticket#: CJAMS-58565
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update progressnote
set activeflag = 0, updatedby = 'CJAMS-59399', updatedon = now()
where progressnoteid = 'ea1bcbb1-4f28-42b5-bb19-ab8fac1a5e3b' and activeflag =1;


update progressnotedetail
set activeflag = 0, updatedby = 'CJAMS-59399', updatedon = now()
where progressnoteid = 'ea1bcbb1-4f28-42b5-bb19-ab8fac1a5e3b' and activeflag =1;


update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-59399', updatedon = now()
where progressnoteid = 'ea1bcbb1-4f28-42b5-bb19-ab8fac1a5e3b' and activeflag =1;