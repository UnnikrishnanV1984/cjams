
/*
   Issue Description: CDM-38777
   Category/ Module  : Unable to add known Persons to intake case
   Root cause: Unable to add known Persons to intake
   Pull request# for code fix: https://source.mdthink.maryland.gov/projects/DHSCJAMS/repos/cjams_db_scripts/pull-requests/11925/overview
   Reason why no related code fix: as user not able to find the respective person, he added new person so we need to do data fix.
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.person 
set clientflag = 1, updatedby = 'CDM-38777', updatedon = now(),providerid = 5042593
where cjamspid='226778';

update cjams.person 
set clientflag = 1, updatedby = 'CDM-38777', updatedon = now(),providerid = 5042593
where cjamspid='226779';

update intakeservicerequestactor	
set  personid = '4e054343-0c1b-46ba-a654-14f95ef08643', updatedby = 'CDM-38777', updatedon = now()
where  intakeserviceid = '1beeef30-8943-430c-b1b2-34788fbb7829' and activeflag = 1 and personid = '4388d0e4-1d15-47b6-9c00-dc8b21e3e289';
	

update actor	
set  personid = '4e054343-0c1b-46ba-a654-14f95ef08643', updatedby = 'CDM-38777', updatedon = now()
where  actorid='2594fa9d-f8de-4bf5-bca4-27acd08be26d' and activeflag = 1 and personid = '4388d0e4-1d15-47b6-9c00-dc8b21e3e289';

update intakeservicerequestactor	
set  personid = 'd32fc171-4083-46e1-9d1c-07b2ad5740d1', updatedby = 'CDM-38777', updatedon = now()
where  intakeserviceid = '1beeef30-8943-430c-b1b2-34788fbb7829' and activeflag = 1 and personid = 'f54e79fc-978c-4b72-9259-2312db870800';
	

update actor	
set  personid = 'd32fc171-4083-46e1-9d1c-07b2ad5740d1', updatedby = 'CDM-38777', updatedon = now()
where  actorid='2d306451-8975-4d1e-882d-2fb67920f01f' and activeflag = 1 and personid = 'f54e79fc-978c-4b72-9259-2312db870800';