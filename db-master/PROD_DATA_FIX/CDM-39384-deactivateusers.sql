
/*
  Issue Description:CDM-39384 Terminated Worker.
  Category/ Module : user management
  Root cause: Users are still active in tables
  Pull request# for code fix: 
  Reason why no related code fix:
  Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 1
*/
-- email:'michael.shirey@maryland.gov'
-- 'ashlie.nowlin@maryland.gov',
-- 'sara.riker@maryland.gov',
-- 'tracey.hongtong@maryland.gov',
-- 'emily.wieczorek@maryland.gov'
-- id : 14921, 9759, 9926, 9545, 9682

update userprofile set activeflag = 0, updatedby = 'CDM-39384', updatedon = now() 
where securityusersid in ('326a6ea0-3b2b-47e0-9465-16173345cb1a','1b2e7627-186b-4c0a-a057-ef494d1ff523','cb66cbec-8de6-4e0a-b996-cabdbbc5425d', 
'c811b7fb-fcb8-47e1-9d9b-b9664c9dba77','2e4fb913-17c1-4fab-b6ab-39f988a3519f') and activeflag = 1;
update muser set activeflag = 0, updatedby = 'CDM-39384', updatedon = now() 
where securityusersid in ('326a6ea0-3b2b-47e0-9465-16173345cb1a','1b2e7627-186b-4c0a-a057-ef494d1ff523','cb66cbec-8de6-4e0a-b996-cabdbbc5425d', 
'c811b7fb-fcb8-47e1-9d9b-b9664c9dba77','2e4fb913-17c1-4fab-b6ab-39f988a3519f')  and activeflag = 1;
update cjams.securityusers set activeflag=0, updatedby='CDM-39384', updatedon=now()  
where securityusersid in ('326a6ea0-3b2b-47e0-9465-16173345cb1a','1b2e7627-186b-4c0a-a057-ef494d1ff523','cb66cbec-8de6-4e0a-b996-cabdbbc5425d', 
'c811b7fb-fcb8-47e1-9d9b-b9664c9dba77','2e4fb913-17c1-4fab-b6ab-39f988a3519f') and activeflag = 1;
update cjams.teammemberassignment set activeflag=0, updatedby='CDM-39384', updatedon=now() 
where securityusersid in ('326a6ea0-3b2b-47e0-9465-16173345cb1a','1b2e7627-186b-4c0a-a057-ef494d1ff523','cb66cbec-8de6-4e0a-b996-cabdbbc5425d', 
'c811b7fb-fcb8-47e1-9d9b-b9664c9dba77','2e4fb913-17c1-4fab-b6ab-39f988a3519f') and activeflag = 1;
update rolemapping set activeflag = 0, updatedby = 'CDM-39384', updatedon = now() 
where principalid in ('14921', '9759', '9926', '9545', '9682') and activeflag = 1;
update userresource set activeflag = 0, updatedby = 'CDM-39384', updatedon = now() 
where userid in (14921, 9759, 9926, 9545, 9682) and activeflag = 1;
UPDATE teammember SET activeflag = 0,	updatedby = 'CDM-39384',updatedon = now()
WHERE teammemberid IN ('3c210eaf-e17e-4947-af6d-f28bb1599156','40319303-35dc-47d8-b3df-7635ec220002','303de590-620c-4888-b06f-6acacaccafa4',
'180ae901-6a7a-4ed4-a866-32b16b1ce263','f2fb2c9a-88b7-47f9-acca-09f0e673c6d9') and activeflag = 1;

