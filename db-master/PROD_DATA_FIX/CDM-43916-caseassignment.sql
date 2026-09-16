/*
  Issue Description:CDM-43916 family assignment for dummy service case
  Category/ Module : Case Assignments
  Root cause:  B-202849 story changes had data fix which introduced family assignments for open service cases which doesn't have any persons or case linked
  Fix Provided: Data fix has been promoted to Remove family assignment
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

update caseassignment
set activeflag = 0, updatedon = now(), updatedby = 'CDM-43916'
where caseassignmentid in (select ca.caseassignmentid  from caseassignment ca 
inner join servicecase sc on sc.servicecaseid = ca.objectid and sc.activeflag = 1
where ca.updatedby = 'CIDM-9543' and ca.objecttypekey = 'servicecase'
and ca.objectid not in (select servicecaseid from actor where activeflag = 1 and servicecaseid is not null)) and activeflag = 1 and updatedby = 'CIDM-9543';
