/*
   Issue Description: CDM-26723
   Category/ Module  : Child Removal
   Root cause: user request to remove 
   Pull request# for code fix: 5821
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

-- No placement for this one so far 

update cjams.intakeservreqchildremoval set activeflag =0, updatedby='CDM-26723', updatedon=now()

where intakeservreqchildremovalid ='c24f5455-a53e-4a78-85c8-960c84285a61';


update cjams.personprogramarea set activeflag =0, updatedby='CDM-26723', updatedon=now()

where personprogramid ='96c910ef-5460-48f4-9c8a-cf1ee10aa9eb';


update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-26723',
	update_ts = now()
where removal_id = 254837
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;