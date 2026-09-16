/*
   Issue Description: CDM-26471
   Category/ Module  : Child removal
   Pull request# for code fix: 7030
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update intakeservreqchildremoval set exitdate =null, updatedby ='CDM-26471', updatedon = now()  where intakeservreqchildremovalid ='8ddb8708-26f7-42fe-9412-5217b3685445' and activeflag =1;


update personprogramarea set enddate = null, updatedby ='CDM-26471', updatedon = now()  where personprogramid ='27b1c8c9-1587-4b56-b1e4-acf5e05bd06e' and activeflag =1;

update tb_client_eligibility set  end_dt = null,
update_user_id = 'CDM-26471', update_ts = now()
where removal_id ='251684';