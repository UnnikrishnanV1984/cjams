/*
Issue Description: Data fix to delete the POSC approval request from the 
supervisor approval dashboard 
Category/Module: Bug
Root cause: data fix to delete the POSC approval request from the 
supervisor approval dashboard 
Fix provided: Fix has been promoted to change the description to Father
Data/Code fix ticket#: CJAMS-60183
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

 update routing 
    set activeflag = 0,
        updatedby = 'CJAMS-60183', 
        updatedon = now()
    where routingid = '7d7fd1b1-91a6-40cc-b022-1d8629fdc7a2'
    and activeflag = 1;

