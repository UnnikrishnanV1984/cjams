
/*
  Issue Description:CDM-34311 Names in CJAMS that need to be removed: Somerset Co.
  Category/ Module : user management
  Root cause: Users are still active in tables
  Pull request# for code fix: 
  Reason why no related code fix:
  Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 1
*/
-- email:'dentellel.warner@maryland.gov','christinam.jones@maryland.gov','makenzie.cirrani@maryland.gov,
-- melissaa.rice@maryland.gov,carola.kunkel@maryland.gov,clint.anderson@maryland.gov,grace.kim1@maryland.gov,
-- markeith.faniel@maryland.gov,michael.wilmot@maryland.gov,sandra.sigmund@maryland.gov
-- id : 12101,9761,11957,13320,9923,14950,12923,14000,13999,9613

update userprofile set activeflag = 0, updatedby = 'CDM-34311', updatedon = now() 
where securityusersid in ('0a19650d-711f-4a32-b82c-2fb4cec2aaed', '3ef5d96c-3dd1-4ebe-9857-38ebc4a6193a','096ef417-8958-42f4-baf3-abed5e3b3359',
'7c1802b3-645c-4b12-9aeb-73757e233eb5','b4ded5dd-823f-4975-8c46-1a44905c300c','c50a3592-5fe6-4007-ab7c-29ecea76e1bf',
'61cdd867-2cf7-44e5-a60b-9dc134085094','08d6f2b5-abbc-4d0e-94b7-50d659952cd4','c07653fb-0823-4d61-87bd-acb424c8629d',
'c597fb76-4c1e-4842-832b-55d0594fdb43') and activeflag = 1;
update muser set activeflag = 0, updatedby = 'CDM-34311', updatedon = now() 
where securityusersid in ('0a19650d-711f-4a32-b82c-2fb4cec2aaed', '3ef5d96c-3dd1-4ebe-9857-38ebc4a6193a','096ef417-8958-42f4-baf3-abed5e3b3359',
'7c1802b3-645c-4b12-9aeb-73757e233eb5','b4ded5dd-823f-4975-8c46-1a44905c300c','c50a3592-5fe6-4007-ab7c-29ecea76e1bf',
'61cdd867-2cf7-44e5-a60b-9dc134085094','08d6f2b5-abbc-4d0e-94b7-50d659952cd4','c07653fb-0823-4d61-87bd-acb424c8629d',
'c597fb76-4c1e-4842-832b-55d0594fdb43')  and activeflag = 1;
update cjams.securityusers set  activeflag=0, updatedby='CDM-34311', updatedon=now()  
where securityusersid in ('0a19650d-711f-4a32-b82c-2fb4cec2aaed', '3ef5d96c-3dd1-4ebe-9857-38ebc4a6193a','096ef417-8958-42f4-baf3-abed5e3b3359',
'7c1802b3-645c-4b12-9aeb-73757e233eb5','b4ded5dd-823f-4975-8c46-1a44905c300c','c50a3592-5fe6-4007-ab7c-29ecea76e1bf',
'61cdd867-2cf7-44e5-a60b-9dc134085094','08d6f2b5-abbc-4d0e-94b7-50d659952cd4','c07653fb-0823-4d61-87bd-acb424c8629d',
'c597fb76-4c1e-4842-832b-55d0594fdb43') and activeflag = 1;
update cjams.teammemberassignment set  activeflag=0, updatedby='CDM-34311', updatedon=now() 
where securityusersid in ('0a19650d-711f-4a32-b82c-2fb4cec2aaed', '3ef5d96c-3dd1-4ebe-9857-38ebc4a6193a','096ef417-8958-42f4-baf3-abed5e3b3359',
'7c1802b3-645c-4b12-9aeb-73757e233eb5','b4ded5dd-823f-4975-8c46-1a44905c300c','c50a3592-5fe6-4007-ab7c-29ecea76e1bf',
'61cdd867-2cf7-44e5-a60b-9dc134085094','08d6f2b5-abbc-4d0e-94b7-50d659952cd4','c07653fb-0823-4d61-87bd-acb424c8629d',
'c597fb76-4c1e-4842-832b-55d0594fdb43') and activeflag = 1;
update rolemapping set activeflag = 0, updatedby = 'CDM-34311', updatedon = now() 
where principalid in ('12101','9761','11957','13320','9923','14950','12923','14000','13999','9613') and activeflag = 1;
update userresource set activeflag = 0, updatedby = 'CDM-34311', updatedon = now() 
where userid in (12101,9761,11957,13320,9923,14950,12923,14000,13999,9613) and activeflag = 1;

