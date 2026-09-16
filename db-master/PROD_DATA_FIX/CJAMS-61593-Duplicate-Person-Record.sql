/*
Issue:Duplicate client to be deleted from the case#251023113977 : CJAMS ID - 204204474
Root Cause:User requested to delete duplicated record due to they do not have access to delete.
Fix Provided (Data Fix Only):Data fix was done by Updated personprogramarea table .
Data/Code fix ticket#: CJAMS-61593
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update personprogramarea 
set activeflag =0,updatedon = now(),updatedby ='CJAMS-61593'
where personprogramid  ='134b0c90-b072-4c44-9069-aad101c780a4' and activeflag =1;


update actor 
set activeflag =0,updatedon = now(),updatedby ='CJAMS-61593'
where actorid  ='269db2b1-2ef3-4ee0-94dc-d32c6ac17e0b' and activeflag =1;

update intakeservicerequestactor 
set activeflag =0,updatedon = now(),updatedby ='CJAMS-61593'
where intakeservicerequestactorid in ('6263fb60-4bd1-4186-8cf0-5a02262a211e','3de10a8c-fb93-472a-b8ec-bb17dc1f5946') and activeflag =1;


update personrole 
set activeflag =0,updatedon = now(),updatedby ='CJAMS-61593'
where personroleid  in ('a2551471-d4d8-4a07-87e8-4f37306903be') and activeflag =1;



update personroletype 
set activeflag =0,updatedon = now(),updatedby ='CJAMS-61593'
where personroletypeid  in ('1e86e84a-0a9c-4541-923b-91960bf48be5',
'4c35737f-6ccb-449b-8d4a-17b9497e8734') and activeflag =1;
