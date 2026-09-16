/* 
    Issue Description: CDM-43593
   Category/ Module  : Person 
   Root cause: User requested to remove persion
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/

UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-43593', updatedon=now(), activeflag = 0 
where actorid = '76b4f64a-9d78-4c31-adec-0adaca98cff7' and servicecaseid= 'dc03702b-db86-489e-8bc4-a661942f9fab' and
personid ='f9cdd297-5465-4121-8da5-aad5f47aef7f' and activeflag = 1;

UPDATE cjams.actor
SET updatedby='CDM-43593', updatedon=now(), activeflag = 0
where actorid = '76b4f64a-9d78-4c31-adec-0adaca98cff7' and 
personid ='f9cdd297-5465-4121-8da5-aad5f47aef7f' and activeflag = 1;

update cjams.personrole  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-43593'
where personroleid = 'f4738d2e-6adc-4253-a1f2-6fa3e3f4eff0' and activeflag = 1;

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-43593'
where actorrelationshipid = '5d9a008e-3adf-41c4-be87-eba74f035791' and activeflag = 1;

update cjams.personroletype 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-43593'
where personroletypeid  = '6fa1b462-3ea7-43f4-8d0e-84c6726c15bc' and activeflag = 1;

--select * from personprogramarea where personid ='f9cdd297-5465-4121-8da5-aad5f47aef7f' -- No records found 