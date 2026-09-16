/*
   Issue Description: CJAMS-58132
   Category/ Module  : Update child fatality value
   Root cause: user requeseted to update child fatality value. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakesnapshot
set jsondata=jsonb_set(jsondata,'{sdm,childfatality}','"yes"') , updatedby ='CJAMS-58132', updatedon =now()
where intakeserviceid = '4a983a5a-60e0-4965-b45b-ef750a8630ae' and activeflag = 1;