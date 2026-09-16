
/*
   Issue Description: CDM-35640
   Category/ Module  : initial contact with caregiver 
   Root cause: User requested to update their face to face visit as completed.
   Fix Provided: 
*/

select personroleid, personid, initialresponse, updatedby, updatedon,*  
	from personrole 
where personid ='ea36c07e-0436-4326-8ebc-1ee4bdc5a33d'
	and activeflag  = 1
	and initialresponse = 0;

update personrole
set initialresponse = 1,
	updatedby = 'CDM-35640', 
	updatedon = now()
where personid ='ea36c07e-0436-4326-8ebc-1ee4bdc5a33d'
	and activeflag  = 1
	and initialresponse = 0;
		
-- To Stop the timer		
-- CPS-IR : 231021272229 - 129f9248-c124-40d1-986c-8d567dc629aa		
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon,* 
	from intakeservicerequest 
where servicerequestnumber = '231021272229'
	and activeflag = 1;

select * 
from cjams.cpsresponsetimerupdate( '129f9248-c124-40d1-986c-8d567dc629aa'::uuid, 'CDM-35640'::character varying );
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon,* 
	from intakeservicerequest 
where servicerequestnumber = '231021272229'
	and activeflag = 1;
