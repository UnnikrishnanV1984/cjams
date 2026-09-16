/*
   Issue Description: CDM-32023
   Category/ Module  : Response Timer
   Root cause: Reaponse timer not stopped 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


select personroleid, personid, initialresponse, updatedby, updatedon  
	from personrole 
where intakeserviceid = 'd9cfb122-3c0c-4710-bcea-622a0f6cc6df'
	and activeflag  = 1
	and initialresponse = 0 ;

update personrole
set initialresponse = 1,
	updatedby = 'CDM-32023', 
	updatedon = now()
where intakeserviceid = 'd9cfb122-3c0c-4710-bcea-622a0f6cc6df'
	and activeflag  = 1
	and initialresponse = 0 ;
	
-- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020542475'
	and activeflag = 1 ;

select * 
from cjams.cpsresponsetimerupdate( 'd9cfb122-3c0c-4710-bcea-622a0f6cc6df'::uuid, 'CDM-32023'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020542475'
	and activeflag = 1 ;
		