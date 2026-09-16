
/*
   Issue Description: CDM-16646
   Category/ Module  : Data fix for updating provider id in adoptio audit table
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update tb_ive_adoption_audit set childexpectedadoptiveproviderid = '5094506', updatedby = 'CDM-16646', updatedon = now()  where cjamspid in ('4489486','4332839'); 
