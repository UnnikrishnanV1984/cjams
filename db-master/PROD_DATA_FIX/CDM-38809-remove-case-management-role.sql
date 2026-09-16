/*
  Issue Description:CDM-38809 Terminated Worker.
  Category/ Module : user management
  Root cause: Remove Case Management role
  Fix Provided: Data fix has been promoted to Remove case management role for the requested users.
  Pull request# for code fix: 
  Reason why no related code fix:
  Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 1
*/

-- Email:
-- iletha.gerald1@maryland.gov
-- mervin.king@maryland.gov
-- hannah.fonti@maryland.gov
-- venus.carpenter2@maryland.gov
-- ashley.lamonda1@maryland.gov
-- dakkia.fedd@maryland.gov
-- imec.lane@maryland.gov
-- jameria.davis@maryland.gov

-- id : 37090,35888,35822,37288,38426,36880,35987,37123,36946


update userresource set activeflag = 0, updatedby = 'CDM-38809', updatedon = now() 
where userid in (37090,35888,35822,37288,38426,36880,35987,37123,36946) and activeflag = 1 and 
permissiongroupid ='0388441d-afe8-4aff-9553-a192e6fca30f' and roleid =135;


