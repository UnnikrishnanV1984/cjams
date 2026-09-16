

/*
Issue Description:241040388694:I can't give admin rights to Sara Blanco for case number 241040388694. She is under the unit Finance. However when I select that unit and then try to select her from the worker drop down list the list is blank. 
Category/Module: Bug
Root cause: In db data was miss matched due to that user do not have acces under selected social worker role.
Fix provided: DB queries  update intakedastatus, intakedastaging table.
Data/Code fix ticket#: CJAMS-60217
Regression Impacts: N/A
Is Code fix Required?: No      
Code fix ticket#: N/A
Reason why no related code fix: This is db related issue, not required code fix.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update teammember
set roletypekey = 'CWCW' ,updatedby = 'CJAMS-60217',updatedon = now()
where teammemberid = 'bc954d56-b276-48ac-8b16-15b3b68bb67d' and activeflag=1;