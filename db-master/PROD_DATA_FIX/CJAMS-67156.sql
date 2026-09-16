
/*
Issue Description:I261013965447:Case was open in error. Please remove from screener's dashboard.
Category/Module: Intake 
Root cause: User requested to delete intake I261013965447 as it was created in error.
Fix provided: Data fix done to delete intake I261013965447 as requested by user
Data/Code fix ticket#: CJAMS-67156
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update intakedastaging 
set activeflag =0, updatedby ='CJAMS-67156', updatedon =now()
where intakenumber ='I261013965447' and activeflag =1;

update intakedastatus  
set activeflag =0, updatedby ='CJAMS-67156', updatedon =now()
where intakenumber ='I261013965447' and activeflag =1;