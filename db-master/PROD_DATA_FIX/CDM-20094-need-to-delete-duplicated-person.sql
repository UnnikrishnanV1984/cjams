 /*
  Issue Description:CDM-20094
   Category/ Module  :  need to delete duplicated person
   Root cause:need to delete duplicated person
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update cjams.personrole set activeflag=0,
updatedby='CDM-20094',
updatedon=now()
where personid='50c97367-2c89-458d-9c96-66b26b407fa4' 
and activeflag=1
and intakeserviceid='1d7a862b-dc88-40ab-95c6-6e87400ff727' 
and personroleid='58603425-6686-40a9-857d-402f33b251eb';

update cjams.actor set activeflag = 0,updatedon = now(),updatedby = 'CDM-20094'
where actorid = '28335bbb-b281-4efb-a574-e570f4ef5ba5';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-20094'
where intakeservicerequestactorid = '9d49abec-3edc-42c8-b83d-82e5980a8beb';
