/*
Issue:Please proceed with the data fix to remove the blank hospitalization as highlighted below.Case ID: 3117128 Client ID: 202068151 (Lariah Remy Crunkilton)
Root Cause: User requested to delete the  blank hospitalization.
Fix Provided (Data Fix Only):Data fix has been promoted to Remove the personhospitalization related table
Data/Code fix ticket#: CJAMS-62843
Regression Impacts:None 
Is Code fix Required?:NO
Code fix ticket#: N/A
Reason why no related code fix:
Backup before update/delete:

*/
update personhospitalization  
set activeflag  ='0',updatedby  ='CJAMS-62843',updatedon  =now()
where hospitalizationid  ='49406797-9a35-4d55-bbb6-895bc01eb68c' and activeflag =1;

update personhospitalization_history  
set activeflag  ='0',updatedby  ='CJAMS-62843',updatedon  =now()
where personhospitalizationhistoryid  ='7d144894-9235-41ba-9c33-dc312850c688' and activeflag =1;