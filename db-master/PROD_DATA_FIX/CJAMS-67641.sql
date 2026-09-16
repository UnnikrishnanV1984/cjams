

/*
Issue Description: CJAMS-67641
Category/Module: Assessment
Root cause: wrong client in SAFE-C OHP assessment
Fix provided: Data fix has been promoted to remove the wrong SAFE-C OHP record in case# 3193098
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update assessment set activeflag=0, updatedby='CJAMS-67641', updatedon =now() 
where objectid='90b41ee3-9c45-4252-8505-ee7e79eae381' and assessmentid='627c9795-f7b7-468c-bd64-a9ae6617a7ea' and activeflag=1;

update assessmentactor set activeflag =0,updatedby ='CJAMS-67641',updatedon =now()
where assessmentid ='627c9795-f7b7-468c-bd64-a9ae6617a7ea' and activeflag=1;

update assessmentcomments
set activeflag =0,
updatedby='CJAMS-67641',updatedon=now()
where assessmentid ='627c9795-f7b7-468c-bd64-a9ae6617a7ea' and activeflag=1;

update assessment_history 
set activeflag =0,
updatedby='CJAMS-67641',updatedon=now()
where assessmentid ='627c9795-f7b7-468c-bd64-a9ae6617a7ea' and activeflag=1;

update routing set activeflag =0,updatedby ='CJAMS-67641',updatedon =now()
where objectid ='627c9795-f7b7-468c-bd64-a9ae6617a7ea' and eventcode= 'ASST' and activeflag=1;