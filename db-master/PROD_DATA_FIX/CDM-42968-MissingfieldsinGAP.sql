
/* 
    Issue Description: CDM-42968
  Category/ Module  : IV-E-gapeligibility
  Root cause: MissingfieldsinGAP
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  void the rejected provider placement from backend
  Backup before update/ delete: 
*/

update gapeligibilityinfo
set childguardianid = 6005031, latestfcplacementstartdatewithperpectiveguardian='2013-09-03 04:00:00',guardianshipagreementsigneddate='2021-11-23 05:00:00', updatedby='CDM-42968', updatedon=now()
where gapeligibilityinfoid='2f27afde-26cb-4784-b4f8-1e9bc6c9363e' and activeflag=1;