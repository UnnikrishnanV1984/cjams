
/*
  Issue Description:CDM-40065 Terminated Worker.
  Category/ Module : user management
  Root cause: Users are still active in tables
  Pull request# for code fix: 
  Reason why no related code fix:
  Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 1
*/
-- email:'tyshea.shields1@maryland.gov','julia.woodcock@maryland.gov','julia.woodcock1@maryland.gov',
-- 'brittany.leach@maryland.gov','nina.gonzalez@maryland.gov',
-- 'lysa.regits@maryland.gov','lorelei.schild@maryland.gov', 'denise.michaels@maryland.gov',
-- 'april.ferguson@maryland.gov','nataki.williams@maryland.gov', 'temiloluwa.kolawole@maryland.gov',
-- 'catherine.white1@maryland.gov','imani.gault@maryland.gov', 'katelyn.khvolis@maryland.gov',
-- 'mariah.johnson1@maryland.gov','shavonne.byrd@maryland.gov','caroline.oguine@maryland.gov',
-- 'corey.gregory@maryland.gov','jennifer.kassel@maryland.gov','melissa.difranco@maryland.gov',
-- 'tatiana.gibson@maryland.gov','ann-louise.hardesty@maryland.gov',
-- 'danielle.bostic@maryland.gov','antionette.wilson@maryland.gov',
-- 'chennal.powell@maryland.gov','rita.ortiz@maryland.gov',
-- 'theresa.cunningham@maryland.gov','nicole.logan@maryland.gov'
-- id : 14525

update userprofile set activeflag = 0, updatedby = 'CDM-40065', updatedon = now() 
where email in ('tyshea.shields1@maryland.gov','julia.woodcock@maryland.gov','julia.woodcock1@maryland.gov',
'brittany.leach@maryland.gov','nina.gonzalez@maryland.gov',
'lysa.regits@maryland.gov','lorelei.schild@maryland.gov', 'denise.michaels@maryland.gov',
'april.ferguson@maryland.gov','nataki.williams@maryland.gov', 'temiloluwa.kolawole@maryland.gov',
'catherine.white1@maryland.gov','imani.gault@maryland.gov', 'katelyn.khvolis@maryland.gov',
'mariah.johnson1@maryland.gov','shavonne.byrd@maryland.gov','caroline.oguine@maryland.gov',
'corey.gregory@maryland.gov','jennifer.kassel@maryland.gov','melissa.difranco@maryland.gov',
'tatiana.gibson@maryland.gov','ann-louise.hardesty@maryland.gov',
'danielle.bostic@maryland.gov','antionette.wilson@maryland.gov',
'chennal.powell@maryland.gov','rita.ortiz@maryland.gov',
'theresa.cunningham@maryland.gov','nicole.logan@maryland.gov') and activeflag = 1;

update muser set activeflag = 0, updatedby = 'CDM-40065', updatedon = now() 
where email in ('tyshea.shields1@maryland.gov','julia.woodcock@maryland.gov','julia.woodcock1@maryland.gov',
'brittany.leach@maryland.gov','nina.gonzalez@maryland.gov',
'lysa.regits@maryland.gov','lorelei.schild@maryland.gov', 'denise.michaels@maryland.gov',
'april.ferguson@maryland.gov','nataki.williams@maryland.gov', 'temiloluwa.kolawole@maryland.gov',
'catherine.white1@maryland.gov','imani.gault@maryland.gov', 'katelyn.khvolis@maryland.gov',
'mariah.johnson1@maryland.gov','shavonne.byrd@maryland.gov','caroline.oguine@maryland.gov',
'corey.gregory@maryland.gov','jennifer.kassel@maryland.gov','melissa.difranco@maryland.gov',
'tatiana.gibson@maryland.gov','ann-louise.hardesty@maryland.gov',
'danielle.bostic@maryland.gov','antionette.wilson@maryland.gov',
'chennal.powell@maryland.gov','rita.ortiz@maryland.gov',
'theresa.cunningham@maryland.gov','nicole.logan@maryland.gov') and activeflag = 1;

update cjams.securityusers set activeflag=0, updatedby='CDM-40065', updatedon=now()  
where securityusersid in (select securityusersid from userprofile where 
email in ('tyshea.shields1@maryland.gov','julia.woodcock@maryland.gov','julia.woodcock1@maryland.gov',
'brittany.leach@maryland.gov','nina.gonzalez@maryland.gov',
'lysa.regits@maryland.gov','lorelei.schild@maryland.gov', 'denise.michaels@maryland.gov',
'april.ferguson@maryland.gov','nataki.williams@maryland.gov', 'temiloluwa.kolawole@maryland.gov',
'catherine.white1@maryland.gov','imani.gault@maryland.gov', 'katelyn.khvolis@maryland.gov',
'mariah.johnson1@maryland.gov','shavonne.byrd@maryland.gov','caroline.oguine@maryland.gov',
'corey.gregory@maryland.gov','jennifer.kassel@maryland.gov','melissa.difranco@maryland.gov',
'tatiana.gibson@maryland.gov','ann-louise.hardesty@maryland.gov',
'danielle.bostic@maryland.gov','antionette.wilson@maryland.gov',
'chennal.powell@maryland.gov','rita.ortiz@maryland.gov',
'theresa.cunningham@maryland.gov','nicole.logan@maryland.gov')) and activeflag = 1;

update teammember set activeflag=0, updatedby='CDM-40065', updatedon=now() 
where teammemberid in (select teammemberid from cjams.teammemberassignment 
where securityusersid in (select securityusersid from userprofile where 
email in ('tyshea.shields1@maryland.gov','julia.woodcock@maryland.gov','julia.woodcock1@maryland.gov',
'brittany.leach@maryland.gov','nina.gonzalez@maryland.gov',
'lysa.regits@maryland.gov','lorelei.schild@maryland.gov', 'denise.michaels@maryland.gov',
'april.ferguson@maryland.gov','nataki.williams@maryland.gov', 'temiloluwa.kolawole@maryland.gov',
'catherine.white1@maryland.gov','imani.gault@maryland.gov', 'katelyn.khvolis@maryland.gov',
'mariah.johnson1@maryland.gov','shavonne.byrd@maryland.gov','caroline.oguine@maryland.gov',
'corey.gregory@maryland.gov','jennifer.kassel@maryland.gov','melissa.difranco@maryland.gov',
'tatiana.gibson@maryland.gov','ann-louise.hardesty@maryland.gov',
'danielle.bostic@maryland.gov','antionette.wilson@maryland.gov',
'chennal.powell@maryland.gov','rita.ortiz@maryland.gov',
'theresa.cunningham@maryland.gov','nicole.logan@maryland.gov')) and activeflag = 1) and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CDM-40065', updatedon=now() 
where securityusersid in (select securityusersid from userprofile where 
email in ('tyshea.shields1@maryland.gov','julia.woodcock@maryland.gov','julia.woodcock1@maryland.gov',
'brittany.leach@maryland.gov','nina.gonzalez@maryland.gov',
'lysa.regits@maryland.gov','lorelei.schild@maryland.gov', 'denise.michaels@maryland.gov',
'april.ferguson@maryland.gov','nataki.williams@maryland.gov', 'temiloluwa.kolawole@maryland.gov',
'catherine.white1@maryland.gov','imani.gault@maryland.gov', 'katelyn.khvolis@maryland.gov',
'mariah.johnson1@maryland.gov','shavonne.byrd@maryland.gov','caroline.oguine@maryland.gov',
'corey.gregory@maryland.gov','jennifer.kassel@maryland.gov','melissa.difranco@maryland.gov',
'tatiana.gibson@maryland.gov','ann-louise.hardesty@maryland.gov',
'danielle.bostic@maryland.gov','antionette.wilson@maryland.gov',
'chennal.powell@maryland.gov','rita.ortiz@maryland.gov',
'theresa.cunningham@maryland.gov','nicole.logan@maryland.gov')) and activeflag = 1;

update rolemapping set activeflag = 0, updatedby = 'CDM-40065', updatedon = now() 
where principalid in (select id::varchar from muser where 
email in ('tyshea.shields1@maryland.gov','julia.woodcock@maryland.gov','julia.woodcock1@maryland.gov',
'brittany.leach@maryland.gov','nina.gonzalez@maryland.gov',
'lysa.regits@maryland.gov','lorelei.schild@maryland.gov', 'denise.michaels@maryland.gov',
'april.ferguson@maryland.gov','nataki.williams@maryland.gov', 'temiloluwa.kolawole@maryland.gov',
'catherine.white1@maryland.gov','imani.gault@maryland.gov', 'katelyn.khvolis@maryland.gov',
'mariah.johnson1@maryland.gov','shavonne.byrd@maryland.gov','caroline.oguine@maryland.gov',
'corey.gregory@maryland.gov','jennifer.kassel@maryland.gov','melissa.difranco@maryland.gov',
'tatiana.gibson@maryland.gov','ann-louise.hardesty@maryland.gov',
'danielle.bostic@maryland.gov','antionette.wilson@maryland.gov',
'chennal.powell@maryland.gov','rita.ortiz@maryland.gov',
'theresa.cunningham@maryland.gov','nicole.logan@maryland.gov')) and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CDM-40065', updatedon = now() 
where userid in (select id from muser where 
email in ('tyshea.shields1@maryland.gov','julia.woodcock@maryland.gov','julia.woodcock1@maryland.gov',
'brittany.leach@maryland.gov','nina.gonzalez@maryland.gov',
'lysa.regits@maryland.gov','lorelei.schild@maryland.gov', 'denise.michaels@maryland.gov',
'april.ferguson@maryland.gov','nataki.williams@maryland.gov', 'temiloluwa.kolawole@maryland.gov',
'catherine.white1@maryland.gov','imani.gault@maryland.gov', 'katelyn.khvolis@maryland.gov',
'mariah.johnson1@maryland.gov','shavonne.byrd@maryland.gov','caroline.oguine@maryland.gov',
'corey.gregory@maryland.gov','jennifer.kassel@maryland.gov','melissa.difranco@maryland.gov',
'tatiana.gibson@maryland.gov','ann-louise.hardesty@maryland.gov',
'danielle.bostic@maryland.gov','antionette.wilson@maryland.gov',
'chennal.powell@maryland.gov','rita.ortiz@maryland.gov',
'theresa.cunningham@maryland.gov','nicole.logan@maryland.gov')) and activeflag = 1;



