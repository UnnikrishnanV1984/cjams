/*
   Issue Description: CDM-26935
   Category/ Module  : Child Removal
   Root cause: user request to remove 
   Pull request# for code fix: 5821
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


update cjams.intakeservreqchildremoval set exitdate = null, updatedby ='CDM-26935', updatedon = now()

where intakeservreqchildremovalid ='077b4a52-7121-4b68-8090-6d78a83c2766';


update cjams.personprogramarea set enddate = null, endreasonkey = null, updatedby ='CDM-26935', updatedon = now()

where personprogramid ='3801145d-47bd-4c19-af6f-883e580d4ddf';


update tb_client_eligibility set end_dt = null, update_user_id ='CDM-26935',update_ts =now()
where removal_id in('255512') ;