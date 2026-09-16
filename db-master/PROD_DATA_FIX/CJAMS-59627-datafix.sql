/*
   Issue Description: CJAMS-59627
   Category/ Module  : Assignments
   Root cause: update legislative reporting to reflect -Alleged victim Unavailable >> Family was contacted but unavailable to meet within mandate.
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU',
cpsresponsetimerreason2 = 'VFCM',
    updatedby ='CJAMS-59627',
    updatedon =now()
where intakeserviceid = 'c6e5bcdc-ae83-447f-bb30-02207b75876a'
and cpsresponsetimeractionsid = '8f2609dc-8aa6-413c-ac6b-7e64d38b4681'
and activeflag = 1;