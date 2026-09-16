
/*
Issue Description: 221030017655:A monthly visit contact note was completed on 6/30, however in CJAMS the date of the note is written as 6/29. The date on the contact note was changed in CJAMS and is incorrect.A monthly visit contact note was also completed on 7/1, however in CJAMS the date of the note is written as 6/29. The date on the contact note was changed in CJAMS and is incorrect.
Root cause: Users cannot change the contactdate   in  contacts tab, They can able to update .
Fix provided: DB queries to update query to progressnote table
Data/Code fix ticket#: CJAMS-61027
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update progressnote
set contactdate ='2025-06-30 23:00:00.000', updatedby  = 'CJAMS-61027', updatedon = now()
where progressnoteid  = 'c85c1652-3f7a-4ea4-af60-c82b00111fa1' and activeflag =1;

--52214f85-2ede-459c-baf9-4199d58b187f
update progressnote
set contactdate ='2025-07-01 23:00:00.000', updatedby  = 'CJAMS-61027', updatedon = now()
where progressnoteid  in ('52214f85-2ede-459c-baf9-4199d58b187f','91a89f78-f7f8-43f7-a69f-ced36227c09e')and activeflag =1;