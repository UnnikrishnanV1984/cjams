
/*
Issue Description: Please update the Contact: Attempted to Contact: Completed on the Contact ID: 14871401 as highlighted below.
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
set contactstatus = true, updatedby = 'CJAMS-58565', updatedon = now()
where progressnoteid = 'd3cff6ae-d367-4c99-a0f9-25508df44ee4' and activeflag =1;
