/*
Issue Description:3247213:A child's record in the person's tab is in the inactive section instead of the active section. Please assist. 
Root cause: Incorrect or outdated objectid caused the person's program to be misclassified under "Inactive" despite an active program.
Fix provided: Updated objectedid in personprogramarea table.
Data/Code fix ticket#: CJAMS-59718
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a one-time data inconsistency resolved through a direct SQL update; application logic is functioning as expected.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update personprogramarea
set objectid = '2f210d84-9657-406a-b9f7-ba4e1c2863c7', updatedby = 'CJAMS-59718', updatedon = now()
where personprogramid = '40c73b3e-bcf8-4a95-9ab6-abdc4d9319da' and activeflag =1;