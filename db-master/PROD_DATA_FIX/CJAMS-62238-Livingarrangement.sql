/*
Issue:Wrong child got hospitalization + living arrangement records. 
Root Cause: user selected wrong child while recording hospitalization/placement.
Fix Provided (Data Fix Only):Perform a data fix in DB to delete those two records (hospitalization & placement) tied to Case# 241030408257 and PID 201029883.
Data/Code fix ticket#: CJAMS-62238
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


update personhospitalization
set activeflag =0,updatedby =' CJAMS-62238',updatedon =now()
where hospitalizationid ='78efd181-a511-475d-821f-34dae6da43c4' and activeflag =2;

update personhospitalization_history
set activeflag =0,updatedby =' CJAMS-62238',updatedon =now()
where hospitalizationid ='78efd181-a511-475d-821f-34dae6da43c4' and activeflag =2;

update livingarrangement 
set activeflag =0,updatedby =' CJAMS-62238',updatedon =now()
where livingid  ='932072d2-3a39-470f-86e8-c249c43c2d63' and activeflag =1;

update placement 
set activeflag =0,updatedby =' CJAMS-62238',updatedon =now()
where placementid  ='bb34c5ed-3c96-472b-9a83-342d55566880' and activeflag =1;


update placementrevision 
set activeflag =0,updatedby =' CJAMS-62238',updatedon =now()
where placementrevisionid  ='4ff37f0a-b997-4b01-a32c-87e2f468dee4' and activeflag =1;

update routing 
set activeflag =0,updatedby =' CJAMS-62238',updatedon =now()
where objectid = 'bb34c5ed-3c96-472b-9a83-342d55566880' and activeflag =1;

