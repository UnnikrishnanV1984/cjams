/*
Issue Description: 3296501:I entered the wrong end reason- can it be changed? 
Root cause: wrong end reason was enterred in the personprogramarea record for the cliecnt due to manual error.
Fix provided: Data fix has been done to update the data personprogramarea table.
Data/Code fix ticket#: CJAMS-59555
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update personprogramarea 
set endreasonkey = '3372',updatedby = 'CJAMS-59555', updatedon = now()
where personprogramid = '1901afcf-1354-4378-838f-d70c49a4063d' and activeflag =1;