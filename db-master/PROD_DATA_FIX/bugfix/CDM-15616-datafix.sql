/*
   Issue Description: CDM-15616
   Category/ Module  :  Case Removal Update
   Root cause: user requeseted to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2021013307893 
select 	removaldate, exitdate, returndate, returntime, activeflag, *
from	intakeservreqchildremoval
where 	intakeservreqchildremovalid = '0deb944a-8b93-4f2b-9703-164cf224cf14'
		and activeflag = 1;
	
update 	intakeservreqchildremoval 
set 	removaldate = '2021-05-05 13:00:00', 
		exitdate = '2021-05-05 13:01:00', 
		returndate = '2021-05-05 13:02:00',
		returntime = '2021-05-05 13:02:00', 
		removalexitreason = 'REUNIF', 
		updatedby = 'CDM-15616', updatedon = now() 
where 	intakeservreqchildremovalid = '0deb944a-8b93-4f2b-9703-164cf224cf14'
		and activeflag = 1;

select	activeflag, startdatetime, enddatetime, personid
from 	placement 
where 	intakeservreqchildremovalid = '0deb944a-8b93-4f2b-9703-164cf224cf14' 
		and personid = '4825fa2c-77be-4e0b-ae7d-5358459cd494' and activeflag=1;

update 	placement
set		startdatetime = '2021-05-05 13:00:00',
		enddatetime = '2021-05-05 13:01:00',
		endtime  = '13:01'
where 	intakeservreqchildremovalid = '0deb944a-8b93-4f2b-9703-164cf224cf14' 
		and personid = '4825fa2c-77be-4e0b-ae7d-5358459cd494' and activeflag=1;

select 	activeflag, programkey,personprogramid, startdate, enddate
from 	personprogramarea
where 	personid = '4825fa2c-77be-4e0b-ae7d-5358459cd494' and activeflag=1 and programkey = 'OOH';
	
update 	personprogramarea 
set 	startdate = '2021-05-05 13:00:00',
		enddate = '2021-05-05 13:01:00', 
		updatedby ='CDM-15616', 
		updatedon = now() 
where 	personprogramid = '083791f3-c415-4ac4-96b4-040155ed8b1b' and activeflag=1;