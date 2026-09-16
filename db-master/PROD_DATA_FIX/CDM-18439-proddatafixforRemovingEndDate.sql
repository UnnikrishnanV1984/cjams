
/*
   Issue Description: CDM-18439
   Category/ Module  : Removing Removal end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2021-10-15 09:00:00
update intakeservreqchildremoval set exitdate  = null, updatedby = 'CDM-18439', updatedon = now() where intakeservreqchildremovalid = '3ce74cb7-7a5d-4bc2-b483-c43be3b43876';
update personprogramarea set enddate = null, updatedby = 'CDM-18439', updatedon = now() where personprogramid = 'd5d8984c-cf40-4b11-80ff-54eb34ac07bb';