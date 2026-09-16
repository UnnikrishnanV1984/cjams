/*
Issue:the TPR information is not populating in the Permanency Plan TPR while there are TPR records available in the Court TPR tab.
Root Cause: Both parents' tprdetails had the wrong tprrecommendationid 
Fix Provided (Data Fix Only):Updated into tprdetails table.
Data/Code fix ticket#: CJAMS-63040-TPR
Regression Impacts:None 
Is Code fix Required?:no
Code fix ticket#: n/a
Reason why no related code fix:Data  error
Backup before update/delete:
*/
update tprdetails
set tprrecommendationid = '20e43915-83d0-482e-bba6-b1079f57f0a8',updatedby='CJAMS-63040',updatedon=now()
where tprdetailsid in ('6cc189fa-42b5-41c9-9c77-d428d48eb51a', '2b10702c-f0b1-40a1-8e71-0b49cff983ba') and activeflag=1;

update tprrecommendation
set activeflag =0,updatedby='CJAMS-63040',updatedon=now()
WHERE tprrecommendationid = '0edae7d3-a977-4e70-bce6-247ee3e01028' and activeflag=1;
