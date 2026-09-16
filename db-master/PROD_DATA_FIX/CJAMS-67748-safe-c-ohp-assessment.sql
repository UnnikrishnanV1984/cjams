/*
   Issue Description: CJAMS-67748
   Category/Module: SAFE-C OHP
   Root cause: User Error. User requested to delete SAFE-C OHP Assessments added on 05/08/2026
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

update assessment 
set activeflag =0, updatedby ='CJAMS-67748', updatedon =now()
where assessmenttemplateid  ='f6e4c466-72ae-4453-9997-a2a12fcf8035' and assessmentid ='507c7407-7a02-4123-9d67-36fd21b673c8' and activeflag =1;

update assessment 
set activeflag =0, updatedby ='CJAMS-67748', updatedon =now()
where assessmenttemplateid  ='f6e4c466-72ae-4453-9997-a2a12fcf8035' and assessmentid ='e598aac7-b79f-4c9a-a92d-fa77990aec53' and activeflag =1;

update assessmentactor 
set activeflag =0, updatedby ='CJAMS-67748', updatedon =now()
where assessmentid in ('507c7407-7a02-4123-9d67-36fd21b673c8', 'e598aac7-b79f-4c9a-a92d-fa77990aec53') and activeflag =1;

update assessmentcomments 
set activeflag =0, updatedby ='CJAMS-67748', updatedon =now()
where assessmentid in ('507c7407-7a02-4123-9d67-36fd21b673c8', 'e598aac7-b79f-4c9a-a92d-fa77990aec53') and activeflag =1;

update assessment_history 
set activeflag =0, updatedby ='CJAMS-67748', updatedon =now()
where assessmentid in ('507c7407-7a02-4123-9d67-36fd21b673c8', 'e598aac7-b79f-4c9a-a92d-fa77990aec53') and activeflag =1;

update routing 
set activeflag =0, updatedby ='CJAMS-67748', updatedon =now()
where objectid in ('507c7407-7a02-4123-9d67-36fd21b673c8', 'e598aac7-b79f-4c9a-a92d-fa77990aec53') and eventcode ='ASST' and activeflag =1;
