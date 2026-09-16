/*
   Issue Description: CIDM-8948
   Category/ Module  : Prod data fix to update CSMS Referral ID
   Root cause: CSMS error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




 -- 760755
 update ivecsesoutbounddata set csmsreferralid = '761028', updatedon = now(), csmsretryuser = 'CIDM-8948'
 where ivecsesoutboundid = '5363be76-7152-46c0-a88d-9667a741e6e7';