/*
   Issue Description: CJAMS-60263 Persons
   Category/ Module  : data fix to remove the person
   Root cause: user requested to remove the person
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update intakeservicerequestactor
set activeflag = 0, updatedby = 'CJAMS-60263', updatedon = now()
where intakeservicerequestactorid = '4dbb446f-1f27-4388-9022-6c2c4f4ae6a1' and activeflag = 1;

update actor
set activeflag = 0, updatedby = 'CJAMS-60263', updatedon = now()
where personid = 'f8dd9e83-795e-4305-987f-71c0a1ab044f' and activeflag = 1;

update actorrelationship
  set activeflag = 0, updatedby = 'CJAMS-60263', updatedon = now()
where ( person1id = 'f8dd9e83-795e-4305-987f-71c0a1ab044f' or person2id = 'f8dd9e83-795e-4305-987f-71c0a1ab044f')
and servicecaseid = 'a16bd839-35fc-4697-94f5-3227dd5498b8'  and activeflag = 1;

update personroletype 
set activeflag =0, updatedby ='CJAMS-60263', updatedon =now()
where personroleid ='aaebb61a-22a7-4e93-820a-4122cb136114' and activeflag =1;

update personrole 
set activeflag =0, updatedby ='CJAMS-60263', updatedon =now()
where personroleid ='aaebb61a-22a7-4e93-820a-4122cb136114' and activeflag =1;
