/*
Issue Description:CJAMS-61907 User requested to do a data fix to remove the intake I231011395253 from the Pending transfer tab
Category/Module: Pending transfer tab
Root cause: User requested to remove the intake I231011395253 from the Pending transfer tab
Fix provided: Data fix has been done to remove the intake from the Pending transfer tab
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

update intaketransfers
set    activeflag = 0,
       updatedby = 'CJAMS-61907',
       updatedon = now()
where  intaketransferid ='8918535d-4850-4a16-b32d-8d3f68763721';
