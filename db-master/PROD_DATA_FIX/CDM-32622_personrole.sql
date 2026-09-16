/*
  Issue Description: CDM-32622
  Root cause: User requested to update the value to true
  Fix provided : 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

UPDATE cjams.personrole
SET initialresponse=1, updatedby='CDM-32622', updatedon=now()
WHERE personroleid='8a299259-cae8-48c5-b4f6-325f2ed37aa3' and personid='1ce4a1e0-6681-48cc-a7a7-879f5c659e1c';
	
-- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020571304'
	and activeflag = 1 ;

select * 
from cjams.cpsresponsetimerupdate('14073a18-ed88-43be-95da-274715c9969f'::uuid, 'CDM-32622'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020571304'
	and activeflag = 1 ;