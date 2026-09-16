/*
   Issue Description: CDM-33363
   Category/ Module  : Response Timer
   Root cause: Response timer not stopped 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-33363', 
	updatedon = now()
where personroleid in ('d0b633ab-fff9-4a17-86f2-966d8433dc35','97b1a54a-ba41-4205-82d7-703f58f6e0bf','34cd7dd3-6108-48db-abed-33946ed2bea3','04bbeeb9-2cd0-4fa5-9c3f-3959f9deb106','f9eb4d69-7be1-41ab-9a40-73b884ddb31a','4cbab888-1123-4b96-9bc1-da206fce5603')
	and activeflag  = 1
	and initialresponse = 0 ;

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020702940'
	and activeflag = 1 ;


select * 
from cjams.cpsresponsetimerupdate( '408dd3aa-bf5c-4c90-948a-e39b6e6fba16'::uuid, 'CDM-33363'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = ' 231020702940'
	and activeflag = 1;