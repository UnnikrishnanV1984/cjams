/*
Issue Description:CJAMS-61904 User requested to do a data fix to remove the intake I241013180361 from the Pending transfer tab
Category/Module: Pending transfer tab
Root cause: User requested to remove the intake I241013180361 from the Pending transfer tab
Fix provided: Data fix has been done to remove the intake from the Pending transfer tab
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

update intaketransfers
set    activeflag = 0,
       updatedby = 'CJAMS-61904',
       updatedon = now()
where  intaketransferid ='e0434464-6864-4fa1-ba55-2ccae297f19a';