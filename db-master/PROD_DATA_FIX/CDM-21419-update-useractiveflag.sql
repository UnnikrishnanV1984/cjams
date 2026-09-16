/*
  Issue Description: CDM-21419 Multiple inboxes for same person
   Category/ Module  :  user management
   Root cause: User with old email is still active in tables
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/
-- email:'kathy.mutzberg1@maryland.gov','kathy.mutzberg2@maryland.gov','kathy.mutzberg4@maryland.gov'
-- id : 12079,13555,14435

update userprofile set activeflag = 0, updatedby = 'CDM-21419', updatedon = now() where email in ('kathy.mutzberg1@maryland.gov','kathy.mutzberg2@maryland.gov','kathy.mutzberg4@maryland.gov');
update muser set activeflag = 0, updatedby = 'CDM-21419', updatedon = now() where email in ('kathy.mutzberg1@maryland.gov','kathy.mutzberg2@maryland.gov','kathy.mutzberg4@maryland.gov');
update rolemapping set activeflag = 0, updatedby = 'CDM-21419', updatedon = now() where principalid in (13555,14435,12079);
update userresource set activeflag = 0, updatedby = 'CDM-21419', updatedon = now() where userid in (13555,14435,12079);

/*
email:'ashley.jones7@maryland.gov'
id : 9541
roles deactivated :  CJAMS_ASCASEWORKER	38
                       CJAMS_AS_PROV_RESOURCE_WORKER	5252
*/

update rolemapping set activeflag = 0, updatedby = 'CDM-21419', updatedon = now() where principalid = 9541 and roleid in(5252,38) and activeflag = 1;
update userresource set activeflag = 0, updatedby = 'CDM-21419', updatedon = now() where userid = 9541 and roleid in(5252,38) and activeflag = 1;