/*
   Issue Description: CDM-26084
   Category/ Module  : Child Removal/Placement
   Root cause: user request
   Pull request# for code fix: 5821
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

--No placement for this removal 


update cjams.intakeservreqchildremoval set activeflag =0, updatedby='CDM-26084', updatedon=now()

where intakeservreqchildremovalid ='54f72431-0c42-404b-a4ab-7eed75b21307';


update cjams.personprogramarea set activeflag =0, updatedby='CDM-26084', updatedon=now()

where personprogramid ='e1f4a35c-11bc-450a-ba45-54202c8ad2cf';


update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-26084',
	update_ts = now()
where removal_id = 254779
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;