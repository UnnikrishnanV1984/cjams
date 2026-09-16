/*
  Issue Description: CIDM-9140
  Category/ Module: Permanency Plan
  Root cause: Actoris is deactivated
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/
update permanencyplan p1
set intakeservicerequestactorid = (select intakeservicerequestactorid from intakeservicerequestactor is2
inner join cjams.referencevalues rv on rv.ref_key = is2.intakeservicerequestpersontypekey and rv.referencetypeid=176 and rv.activeflag = 1 
where is2.servicecaseid = p1.servicecaseid and is2.activeflag = 1 and is2.personid = (select personid from intakeservicerequestactor is3 where 
is3.intakeservicerequestactorid = p1.intakeservicerequestactorid)
order by rv.displayorder asc limit 1), updatedby = 'CIDM-9140' , updatedon = now()
where permanencyplanid in (select p.permanencyplanid from permanencyplan p
inner join intakeservicerequestactor i on i.intakeservicerequestactorid = p.intakeservicerequestactorid and i.activeflag = 0
where p.activeflag = 1 and p.enddate is null);

-- select (select intakeservicerequestactorid from intakeservicerequestactor is2
-- inner join cjams.referencevalues rv on rv.ref_key = is2.intakeservicerequestpersontypekey and rv.referencetypeid=176 and rv.activeflag = 1 
-- where is2.servicecaseid = p1.servicecaseid and is2.activeflag = 1 and is2.personid = (select personid from intakeservicerequestactor is3 where 
-- is3.intakeservicerequestactorid = p1.intakeservicerequestactorid)
-- order by rv.displayorder asc limit 1)
-- from permanencyplan p1
-- where permanencyplanid in (select p.permanencyplanid from permanencyplan p
-- inner join intakeservicerequestactor i on i.intakeservicerequestactorid = p.intakeservicerequestactorid and i.activeflag = 0
-- where p.activeflag = 1 and p.enddate is null)