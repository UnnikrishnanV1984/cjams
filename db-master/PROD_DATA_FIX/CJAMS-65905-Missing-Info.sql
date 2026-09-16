/*
   Issue Description: CJAMS-65905
   Category/ Module  : Prod data fix to fix assessment
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

 UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{authorizationApproval, workername}', '"Leslie Valerio"'),
updatedby ='CJAMS-65905',updatedon =now() 
where assessmentid = '99310a43-133c-4b46-91d0-234038567b50' and activeflag = 1;

  UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{authorizationApproval, caseworkersigndate}', '"2026-02-26T02:04:16"'),
updatedby ='CJAMS-65905',updatedon =now() 
where assessmentid = '99310a43-133c-4b46-91d0-234038567b50' and activeflag = 1;

  UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{authorizationApproval, supervisorname}', '"Dawn Blades"'),
updatedby ='CJAMS-65905',updatedon =now() 
where assessmentid = '99310a43-133c-4b46-91d0-234038567b50' and activeflag = 1;
   

update routing
SET updatedby ='CJAMS-65905',insertedon = '2026-02-27 16:08:01' 
where objectid = '99310a43-133c-4b46-91d0-234038567b50' and routingstatustypeid = 16 and activeflag = 1;
   
