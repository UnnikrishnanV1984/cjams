
/*
   Issue Description: CDM-20717
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4912, 4923, 4964
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


update intakeservreqchildremoval set exitdate = '2019-11-20 00:00:00.000', updatedby = 'CDM-20717' , updatedon = now() 
where intakeservreqchildremovalid = 'bb80ec32-98e4-4902-909c-7ae9a0bc804d';

update intakeservreqchildremoval set removaldate = '2019-11-20 00:00:00.000', updatedby = 'CDM-20717' , updatedon = now() 
where intakeservreqchildremovalid = '808f0709-1866-4eb1-b4c2-db54e61260ce';

update intakeservreqchildremoval set removaldate = '2019-11-20 00:00:00.000', updatedby = 'CDM-20717' , updatedon = now() 
where intakeservreqchildremovalid = '0f0daf99-7d8f-40c9-9103-108a24656535';


update personprogramarea set startdate = '2019-11-20 00:00:00.000', updatedby = 'CDM-20717' , updatedon = now()  
where personprogramid = 'd51b8514-36ad-4942-9bea-9d337f8e3fc6';

update personprogramarea set enddate = null, updatedby = 'CDM-20717', updatedon = now() 
where personprogramid = '6f29fd35-49ef-49d8-90d6-c663da236381';

update personprogramarea set startdate = '2019-11-20 00:00:00.000', updatedby = 'CDM-20717' , updatedon = now()  
where personprogramid = 'cccee0cc-e761-4b09-b11f-6e8337ea630d';