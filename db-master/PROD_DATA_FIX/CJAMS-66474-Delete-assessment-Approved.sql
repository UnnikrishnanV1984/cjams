/*
   Issue Description: CJAMS-66474
   Category/ Module  : Prod data fix to the removal
   Root cause: Please do the needful Data fix for the following of removing Safe C removal

            Case ID: 241030264098
            SafeC - 7:33:20 AM, on 3/19/2026 - Approved Status
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update assessment 
set activeflag=0, updatedby ='CJAMS-66474', updatedon =now() 
where assessmentid='5fa7616f-b8c1-4a17-aea0-6ece1b42823b' and activeflag=1;

update assessmentactor 
set activeflag=0, updatedby ='CJAMS-66474', updatedon =now() 
where assessmentid='5fa7616f-b8c1-4a17-aea0-6ece1b42823b' and activeflag=1;

update assessmentcomments 
set activeflag=0, updatedby ='CJAMS-66474', updatedon =now() 
where assessmentid='5fa7616f-b8c1-4a17-aea0-6ece1b42823b' and activeflag=1;

update assessment_history 
set activeflag=0, updatedby ='CJAMS-66474', updatedon =now() 
where assessmentid='5fa7616f-b8c1-4a17-aea0-6ece1b42823b' and activeflag=1;

update routing 
set activeflag=0, updatedby ='CJAMS-66474', updatedon =now() 
where objectid='5fa7616f-b8c1-4a17-aea0-6ece1b42823b' and eventcode= 'ASST' and activeflag = 1;
