/*
   Issue Description: CDM-37051
   Category/ Module  : Person Card
   Person: 201001084 (412737d5-b71a-4e91-81f4-e4703ed9909d)
   Case: 231021572892 (739eb834-6fc3-4d9b-b1c7-68427c27507a)
   Root cause: user want to change yes for "Was this child an active member of the household at the start of the case but not included on the referral?*"
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select initialresponse, * 
	from personrole 
	where intakeserviceid = '739eb834-6fc3-4d9b-b1c7-68427c27507a' 
		and personid = '412737d5-b71a-4e91-81f4-e4703ed9909d';

update personrole 
	set initialresponse = 1,
		updatedby='CDM-37051',
		updatedon=now() 
	where personroleid='4be209a4-e463-465a-9826-174c1016aded';
	
-- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021572892'
	and activeflag = 1 ;
	
select * 
from cjams.cpsresponsetimerupdate( '739eb834-6fc3-4d9b-b1c7-68427c27507a'::uuid, 'CDM-37051'::character varying ) ;


-- After 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021572892'
	and activeflag = 1 ;