/*
   Issue Description: CDM-32345
   Category/ Module  : Response Timer
   Root cause: Response timer not stopped 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-32345', 
	updatedon = now()
where personroleid = '641858fd-c549-4e75-a170-10f125e9b58f'
	and activeflag  = 1
	and initialresponse = 0 ;

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = ' 231020579659'
	and activeflag = 1 ;


select * 
from cjams.cpsresponsetimerupdate( '4f9f9c8b-6b83-44ea-bec0-04be019f8f52'::uuid, 'CDM-32345'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = ' 231020579659'
	and activeflag = 1;