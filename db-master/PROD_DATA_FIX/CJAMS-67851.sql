/*
   Issue Description: CJAMS-67851
   Category/ Module  : SAFE-C OHP
   Root cause:user requested to delete safe-c ohp  record as it was enterted incorrectly by user.
   Fix provided: Data fix has been done to remove the safe c ohp  assessment record
   Pull request# for code fix: 
   Reason why no related code fix: User error, no code fix is required 
   Status of the code fix if already submitted and expected prod fix date: 
   Case is closed without closing removal and placement. Need to do data fix
*/


update assessment
set activeflag =0,
updatedby='CJAMS-67851',updatedon=now()
where assessmentid='0eb5d66c-91c6-441a-b216-46804eea9423' and activeflag=1;


update assessmentactor set activeflag =0,updatedby ='CJAMS-67851',updatedon =now()
where assessmentid ='0eb5d66c-91c6-441a-b216-46804eea9423' and activeflag=1;

update assessmentcomments
set activeflag =0,
updatedby='CJAMS-67851',updatedon=now()
where assessmentid='0eb5d66c-91c6-441a-b216-46804eea9423' and activeflag=1;

update assessment_history 
set activeflag =0,
updatedby='CJAMS-67851',updatedon=now()
where assessmentid='0eb5d66c-91c6-441a-b216-46804eea9423' and activeflag=1;

update routing set activeflag =0,updatedby ='CJAMS-67851',updatedon =now()
where objectid ='0eb5d66c-91c6-441a-b216-46804eea9423' and eventcode= 'ASST';