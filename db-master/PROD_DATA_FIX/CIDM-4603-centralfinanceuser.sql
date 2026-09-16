
 /*
  Issue Description: CIDM-4603 Create access to the EFT box for Felicia Ping
   Category/ Module  :  Finance ETF switch
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/


update userprofile set teamtypekey='FNS', updatedby='CIDM-4603', updatedon= now() where email = 'felicia.ping1@maryland.gov' and activeflag=1;
