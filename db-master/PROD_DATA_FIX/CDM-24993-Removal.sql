/*
   Issue Description: CDM-24993
   Category/ Module  : Childremoval 
   Root cause: user requested this change 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




update cjams.intakeservreqchildremoval set exitdate = null, updatedby ='CDM-24993', updatedon = now()

where intakeservreqchildremovalid ='88725231-d8c7-40dd-800e-d00f8284ef9c';


update cjams.personprogramarea set enddate = null, endreasonkey = null, updatedby ='CDM-24993', updatedon = now()

where personprogramid ='8db1b2ab-708e-47ee-8dee-a1757350caea';


update tb_client_eligibility set end_dt = null, update_user_id ='CDM-24993',update_ts =now()
where removal_id in('254579') ;