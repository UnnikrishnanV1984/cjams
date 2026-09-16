
/*
Issue Description: 261023486485:The Over Due Reason boxes need to be corrected. It should read Cases not assigned timely and then supervisor delays
Category/Module: case management 
Root cause: User requested to update the overdue reason boxes. It should read Cases not assigned timely and then supervisor delays
Fix provided: Data fix done to update the overdue reason boxes with Cases not assigned timely and then supervisor delays from backend
Data/Code fix ticket#: CJAMS-67862
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User request
*/
update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VCNT',
    cpsresponsetimerreason2 = 'VSDT',
    cpsresponsetimerreason4 = 'OCNT',
	cpsresponsetimerreason5 = 'OSDT', 
	cpsresponsetimerreason7 = 'CCNT', 
	cpsresponsetimerreason8 = 'CSDT', updatedon = now(),
    updatedby = 'CJAMS-67862'
where cpsresponsetimeractionsid = '744353f0-03e0-48ff-b069-7e0311782c74'
and intakeserviceid = 'f56c1ea4-63d8-4c90-9fd3-f01b171a222e'
and activeflag = 1;