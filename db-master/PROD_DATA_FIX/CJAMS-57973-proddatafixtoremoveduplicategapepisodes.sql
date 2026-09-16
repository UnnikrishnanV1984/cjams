/*
   Issue Description: CJAMS-57973
   Category/ Module  : Prod data fix to remove duplicate GAP episodes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update tb_client_eligibility set delete_sw = 'Y', update_ts= now(), update_user_id = 'CJAMS-57973',eligibility_type_cd = null
where client_id = '3942528' and eligibility_type_cd = '2935' and guardian_subsidy_id = '1005674' and delete_sw = 'N';


update gapeligibilityinfo set activeflag = 0, updatedby =  'CJAMS-57973', updatedon = now()
where client_id = '3942528' and activeflag = 1 and guardian_subsidy_id = '1005927';