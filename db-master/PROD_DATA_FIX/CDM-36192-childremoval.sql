/*
   Issue Description: CDM-36192
   Category/ Module  :  Child Removal
   Root cause: User error
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a defect raised from person merge 
*/

update intakeservreqchildremoval r
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36192'
where intakeservreqchildremovalid = 'b6245935-048d-48e9-94ba-16890e8ed66e' and personid = 'd1f8a7f8-5faf-48d2-a599-376f8c214ece';

update intakeservreqchildremoval_history r
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36192'
where activeflag = 1 and intakeservreqchildremovalid = 'b6245935-048d-48e9-94ba-16890e8ed66e' and personid = 'd1f8a7f8-5faf-48d2-a599-376f8c214ece';
