/*
   Issue Description: CDM-35099
   Category/ Module  : Prod data fix to update the provider id details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update tb_payment_status set delete_sw = 'Y', update_ts = now(), update_user_id = 'CDM-35099'
where payment_id = '3733905' and delete_sw = 'N';

update tb_payment_detail set delete_sw = 'Y', update_ts = now(), update_user_id = 'CDM-35099'
where payment_id = '3733905' and delete_sw = 'N';

update tb_payment_header set delete_sw = 'Y', update_ts = now(), update_user_id = 'CDM-35099'
where payment_id = '3733905' and delete_sw = 'N' ;


UPDATE cjams.adoptioncaseagreement
SET  parent1providername='Lisa  Ledman', parent2providername='Christopher  Ledman', parent2providerid=5025881, updatedby = 'CDM-35099', updatedon = now() 
WHERE adoptionagreementid='38b1b46a-e58b-42e9-872b-4d028088a207' ;


update adoptioncaserevision set parent1providername='Lisa  Ledman', parent2providername='Christopher  Ledman', updatedon = now(), updatedby = 'CDM-35099'
where adoptionagreementid = '38b1b46a-e58b-42e9-872b-4d028088a207' and adoptionagreementrateid in ('32a28d7a-cec3-4280-94e1-e1c0d23bc2dd','7e791d66-5c55-431b-a5a9-43200cb4f1a8') and approvaldate is not null
and activeflag = 1 ;
