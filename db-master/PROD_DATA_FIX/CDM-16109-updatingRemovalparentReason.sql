/*
   Issue Description: CDM-16109
   Category/ Module  :  updated the Parent 2 Details in removal
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 1, null
update intakeservreqchildremoval set isbothparentssigned = 2,
 parent2comments = 'The father is unknown. (Mother doesn''t know who the father is and there isn''t a father listed on the birth certificate)',
updatedby = 'CDM-16109', updatedon = now() 
where intakeservreqchildremovalid = '478d466b-c4b5-4f12-930a-ceb26bc018ef';
