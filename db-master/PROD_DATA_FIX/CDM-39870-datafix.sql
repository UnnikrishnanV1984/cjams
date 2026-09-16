/*
   Issue Description: CDM-39870
   Category/ Module  : Assessments: Other
   Root cause: user request 
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/


update assessment set activeflag = 0,
updatedby = 'CDM-39870', updatedon = now()
where objectid = 'da0b8447-375c-4ce2-9eae-dd4c1129327d' and assessmentid= '57c95c56-1268-4702-bf47-2d98bf7d6883' and activeflag =1;

update assessmentcomments set activeflag = 0,
updatedby = 'CDM-39870', updatedon = now()
where assessmentid= '57c95c56-1268-4702-bf47-2d98bf7d6883' and activeflag =1;

update assessment_history set activeflag = 0,
updatedby = 'CDM-39870', updatedon = now()
where assessmentid= '57c95c56-1268-4702-bf47-2d98bf7d6883' and assessmenthistoryid = 'ec8346a2-5614-4983-b665-f873686795d2' and activeflag =1;

update routing set activeflag = 0
where objectid= '57c95c56-1268-4702-bf47-2d98bf7d6883' and routingid = 'fabecf6c-3cd3-485d-989c-2d43547b7954'  and activeflag =1;
