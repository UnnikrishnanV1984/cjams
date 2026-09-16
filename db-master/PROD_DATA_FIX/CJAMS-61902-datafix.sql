/*
Issue Description:CJAMS-61902 I231010357266:Data fix to remove the intake from the Pending transfer tab
Category/Module: Pending transfer tab
Root cause: User requested to remove the intake from the Pending transfer tab
Fix provided: Data fix has been done to remove the intake from the Pending transfer tab
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

update routing
set    activeflag = 0,
       updatedby = 'CJAMS-61902',
       updatedon = now()
where  objectid = '3292afaa-986d-446c-8c23-7e4d49bfa84b'
and    eventcode= 'INTTRF';

update intaketransfers
set    activeflag = 0,
       updatedby = 'CJAMS-61902',
       updatedon = now()
where  intaketransferid ='3292afaa-986d-446c-8c23-7e4d49bfa84b';

