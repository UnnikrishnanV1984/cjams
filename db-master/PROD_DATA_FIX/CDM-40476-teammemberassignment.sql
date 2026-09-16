/* 
  Issue Description: CDM-40350
  Category/ Module  : User Profile
  Root cause: There is change in user role because of agency code and open am role sent as ldss 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update teammemberassignment
set teammemberid = '552f7d33-e954-4165-8dfc-6067c8c95412', securityusersid = '3ca8e63d-f885-445b-aab9-24456e91ad4a', updatedby = 'CDM-40350', updatedon = now()
where teammemberassignmentid = '3d61610a-4267-4e1b-8d50-9fab9f7cbc3d' and activeflag = 1;
