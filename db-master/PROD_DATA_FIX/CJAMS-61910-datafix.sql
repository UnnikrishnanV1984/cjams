/*
Issue Description:CJAMS-61910 User requested to do a data fix to remove the intake I231010570168 from the Pending transfer tab
Category/Module: Pending transfer tab
Root cause: User requested to remove the intake I231010570168 from the Pending transfer tab
Fix provided: Data fix has been done to remove the intake from the Pending transfer tab
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

update intaketransfers
set    activeflag = 0,
       updatedby = 'CJAMS-61910',
       updatedon = now()
where  intaketransferid ='ab1c7172-c199-4650-8bc9-fe10cae17ca1';