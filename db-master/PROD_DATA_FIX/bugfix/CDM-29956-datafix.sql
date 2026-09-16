/*
   Issue Description: CDM-29956
   Category/ Module  : remove person
   Root cause: user wants to remove person other
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update actor set activeflag =0, updatedby='CDM-29956', updatedon=now() 
where actorid in ('7e00628f-a018-4d91-a3a1-0aadca443eea');


update intakeservicerequestactor set activeflag =0, updatedby='CDM-29956', 
updatedon=now() where intakeservicerequestactorid in ('39385d28-5ff6-4078-b25d-844264632a3c');

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CDM-29956'
where personid='26c16e9d-783a-4d49-b115-92ef01d69b48';

update personprogramarea set activeflag =0 , updatedby = 'CDM-29956', 
updatedon = now() where personprogramid='e6ff4b4d-fd52-4664-9bdf-9f1d6fa9cfbb';
