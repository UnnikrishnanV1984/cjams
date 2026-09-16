/*
   Issue Description: CDM-38974 GAP rate correction for Service Case #3179974 (Provider Teresa Sturgill #5051514) and 
                      Service Case #3195476 (Provider Timothy Schaumberg #5087198) were fixed to generate payments through CJAMS. The payment amount that they both received were incorrect.Case #3179974 
                      and Case #5087198 should be getting $28.79 per diam ($892.49 per month). 
   Category/ Module  :  Permanency Plan
    Root cause: User Error while creating the subsidy rate and needs to be corrected as $892.49 per month. 
                Service Case #3195476
                Client ID: 3221018 (SKYLER STURGILL)
                Provider ID: 5051514 (Teresa Sturgill)
                Service Case #5087198
                Client ID: 3182447 (JACOB BARNHART)
                Provider ID: 5087195 (Timothy Schaumburg)
   Fix provided : Data fix has been promoted to update the subsidy rate to  $892.49 per month for the above providers
   Code fix ticket#: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A

*/

--  Provider id:5051514
update gapagreementrate set paymentamout = '892.49', updatedby = 'CDM-38974', updatedon = now() 
where gapagreementrateid = '34f3e09b-f7db-4ff2-ba0d-a3748636d726';


update gapratesrevision set paymentamt = '892.49', approvaldate = now() , updatedby = 'CDM-38974', updatedon = now() 
where gaprateid = '34f3e09b-f7db-4ff2-ba0d-a3748636d726' and activeflag = 1;

--  Provider id:5087195
update gapagreementrate set paymentamout = '892.49', updatedby = 'CDM-38974', updatedon = now() 
where gapagreementrateid = 'faeec7a4-9966-4e01-9a83-61f7987566cd';


update gapratesrevision set paymentamt = '892.49', approvaldate = now() , updatedby = 'CDM-38974', updatedon = now() 
where gaprateid = 'faeec7a4-9966-4e01-9a83-61f7987566cd' and activeflag = 1;


