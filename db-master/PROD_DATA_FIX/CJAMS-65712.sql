/*
   Issue Description: CJAMS-65712
   Category/ Module  : SAFE-C-OHP
   Root cause:user requested to delete safe-c-ohp records.
   Fix provided: Data fix has been done to remove the safe-c-ohp records
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
   Case is closed without closing removal and placement. Need to do data fix
*/



update assessment set activeflag =0,updatedby ='CJAMS-65712',updatedon =now()
where assessmentid in ('9ad0003a-f9d2-4192-9e1c-19b9ac9332d7','3ab3d201-4f99-4333-848c-b54276f0ffb3') and activeflag=1;

update assessmentactor set activeflag =0,updatedby ='CJAMS-65712',updatedon =now()
where assessmentid in ('9ad0003a-f9d2-4192-9e1c-19b9ac9332d7','3ab3d201-4f99-4333-848c-b54276f0ffb3') and activeflag=1;

update assessmentcomments set activeflag =0,updatedby ='CJAMS-65712',updatedon =now()
where assessmentid in ('9ad0003a-f9d2-4192-9e1c-19b9ac9332d7','3ab3d201-4f99-4333-848c-b54276f0ffb3')and activeflag=1;

update assessment_history set activeflag =0,updatedby ='CJAMS-65712',updatedon =now()
where assessmentid in ('9ad0003a-f9d2-4192-9e1c-19b9ac9332d7','3ab3d201-4f99-4333-848c-b54276f0ffb3') and activeflag=1;

update routing set activeflag =0,updatedby ='CJAMS-65712',updatedon =now()
where objectid in ('9ad0003a-f9d2-4192-9e1c-19b9ac9332d7','3ab3d201-4f99-4333-848c-b54276f0ffb3') and eventcode= 'ASST';