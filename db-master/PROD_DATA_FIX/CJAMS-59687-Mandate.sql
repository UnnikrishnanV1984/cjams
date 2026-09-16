
/*
Issue Description:251023018303:Per J. Moore, case reviewed, ticket being submitted for incorrect drop down box re: missing mandate.Contact note #14906115 is for an attempt at school within the time frame - can do a ticket to change reason to "Alleged victim unavailable > Attempted face to face > 1-2 attempts"
Root cause: Incorrect response reason was selected due to a dropdown misselection during entry, leading to an inaccurate mandate violation.
Fix provided: Data fix has been done to update the cpsresponsetimeractions table.
Data/Code fix ticket#: CJAMS-59687
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a one-off user entry error; application logic and dropdown options are functioning correctly. A data fix was sufficient to correct the reason values.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', 
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V12F',
    updatedby ='CJAMS-59687',
    updatedon =now()
where cpsresponsetimeractionsid = 'c5e2c930-99ff-4afd-8cdd-6e262d74d075'
and activeflag = 1;