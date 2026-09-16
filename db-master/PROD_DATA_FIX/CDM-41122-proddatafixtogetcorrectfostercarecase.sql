/*
   Issue Description: CDM-41122
   Category/ Module  : Prod data fix to update clientid in tb-client_eligibility table
   Root cause: Person merge fixed on CDM-11254 but didn't update in IVE table
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


      update tb_client_eligibility set client_id = '200301365', update_ts = now(), update_user_id = 'CDM-41122'
      where removal_id = '251508' and client_id = '1643853';