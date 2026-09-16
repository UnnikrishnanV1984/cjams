/*
Issue Description: Please do a data fix to remove the incorrect person ISABELLA RODRIGUEZ (CJAMS ID - 4015579), from case # 251023154280.
Root cause:  User requested to remove the incorrect person from  the CPS-AR case.
Fix provided: DB queries to update  record in actor  and intakeservicerequestactor ,personrole table.
Data/Code fix ticket#: CJAMS-63215
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Use error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update actor 
set activeflag  =0, updatedby  ='CJAMS-63215',updatedon  =now()
where actorid  ='952d381a-5c29-4d89-8367-7abdc01296c9' and activeflag =1;

update intakeservicerequestactor 
set activeflag  =0, updatedby  ='CJAMS-63215',updatedon  =now()
where intakeservicerequestactorid  ='1233140a-2202-4edf-bd17-fc93a5f4fea7' and activeflag =1;

update personprogramarea  
set activeflag  =0, updatedby  ='CJAMS-63215',updatedon  =now()
where personprogramid  ='402e92a8-d1fe-4ef0-9c78-f26de6020ade' and activeflag =1;

update personrole  
set activeflag  =0, updatedby  ='CJAMS-63215',updatedon  =now()
where personroleid  ='03f1036e-0eb1-4abe-8b41-2606d3733fa5' and activeflag =1;

update personroletype  
set activeflag  =0, updatedby  ='CJAMS-63215',updatedon  =now()
where personroletypeid  ='71e0f719-364f-4eba-b164-e258f02cb1a6' and activeflag =1;
