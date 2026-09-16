
/*
   Issue Description: CDM-37034 / CPS Timer
   Root cause: user wants to replace the active member of the household at the start of the case as 'Yes'.
   Resolution: Need to replace the active member of the household at the start of the case as 'Yes'.
   Pull request# for data fix:N/A
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: data fix
*/

select * from personrole where personid = '89683499-ca20-46ce-8769-6fe4d6ebaabd';

update personrole
set initialresponse = 1, updatedby = 'CDM-37034', updatedon = now()
where personroleid = '9369bd56-72c2-47a5-b569-920ddb69c70d' and activeflag = 1 and initialresponse = 0;

update personrole
set initialresponse = 1,
	updatedby = 'CDM-33396', 
	updatedon = now()
where personroleid in ( 'e7e332ed-f528-474a-bc08-fd0d7a755a51', '2f8c02a7-d3ad-4177-83d5-c22c2f990317' )
	and activeflag  = 1
	and initialresponse = 0 ;

-- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
from intakeservicerequest 
where servicerequestnumber = '241021851226' and activeflag = 1 ;

select * from cjams.cpsresponsetimerupdate( '35816661-b571-4f7c-a88c-118bbff1df69'::uuid, 'CDM-37034'::character varying );
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
from intakeservicerequest 
where servicerequestnumber = '241021851226' and activeflag = 1 ;



