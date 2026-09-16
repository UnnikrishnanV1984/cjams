/*
   Issue Description: 'CJAMS-66870
   Category/ Module  : SAFE-C
   Root cause:user requested to delete safe-c record.
   Fix provided: Data fix has been done to remove the safe assessment records
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
   Case is closed without closing removal and placement. Need to do data fix
*/


update assessment
set activeflag =0,
updatedby='CJAMS-66870',updatedon=now()
where assessmentid='3e326107-8eb9-4c4d-97e7-a94cbb0d5246' and activeflag=1;


update assessmentactor set activeflag =0,updatedby ='CJAMS-66870',updatedon =now()
where assessmentid ='3e326107-8eb9-4c4d-97e7-a94cbb0d5246' and activeflag=1;

update assessmentcomments
set activeflag =0,
updatedby='CJAMS-66870',updatedon=now()
where assessmentid='3e326107-8eb9-4c4d-97e7-a94cbb0d5246' and activeflag=1;

update assessment_history 
set activeflag =0,
updatedby='CJAMS-66870',updatedon=now()
where assessmentid='3e326107-8eb9-4c4d-97e7-a94cbb0d5246' and activeflag=1;

update routing set activeflag =0,updatedby ='CJAMS-66870',updatedon =now()
where objectid ='3e326107-8eb9-4c4d-97e7-a94cbb0d5246' and eventcode= 'ASST';