/*
  Issue Description:CDM-44021 case reappearance
  Category/ Module : Case Assignments
  Root cause:  B-202849 story changes had data fix which introduced family assignments for open service cases which doesn't have any persons or case linked
  Fix Provided: Data fix has been promoted to close the case
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

/*
select dispositioncode,updatedby,activeflag,* from servicecase where servicecasenumber = '221030018329' and activeflag = 1;
--servicecaseid: 9d1dd3dc-de53-4b06-ad30-55ed921bae40
select assigndate,updatedby,activeflag,* from caseassignment where objectid = '9d1dd3dc-de53-4b06-ad30-55ed921bae40';
caseassignmentid = 'c1e7453e-b1ad-4f01-bd61-ae1f9d8495af';
*/

--Ending assignment in caseassignment
update caseassignment
set  activeflag = 0,updatedby = 'CDM-44021', updatedon = now()
where caseassignmentid = 'c1e7453e-b1ad-4f01-bd61-ae1f9d8495af' and activeflag = 1;

--Closing the case in servicecasedisposition
/*
select servicecasedispositionid,* from servicecasedisposition where servicecaseid = '9d1dd3dc-de53-4b06-ad30-55ed921bae40';
*/
update servicecasedisposition
set intakeserreqstatustypekey = 'Closed', dispositioncode = 'Closed', "comments" = 'Dev Closed', updatedby = 'CDM-44021', updatedon = now()
where servicecasedispositionid = '49f3db83-2ad3-4187-b018-03738385d684' and activeflag = 1;