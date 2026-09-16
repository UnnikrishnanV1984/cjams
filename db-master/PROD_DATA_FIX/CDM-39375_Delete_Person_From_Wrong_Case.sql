/*
   Issue Description: CDM-39375
   Category/ Module  : Person delete  
   Root cause: User requested to delete the person from case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update actorrelationship 
   set activeflag =0, updatedby ='CDM-39375', updatedon =NOW()
   where intakeservicerequestactorid in 
  (select intakeservicerequestactorid from intakeservicerequestactor i 
      where personid='c868342b-e9ec-46e6-b521-c58e02edc704' and intakeserviceid='43d1ed2a-ff60-4c0c-ad0c-446f1617649c')
    and activeflag =1;



update intakeservicerequestactor 
   set activeflag =0,updatedby ='CDM-39375', updatedon =NOW()
   where personid='c868342b-e9ec-46e6-b521-c58e02edc704' 
   and intakeserviceid='43d1ed2a-ff60-4c0c-ad0c-446f1617649c'
    and activeflag =1;

update actor
   set activeflag =0,updatedby ='CDM-39375', updatedon =NOW()
   where personid='c868342b-e9ec-46e6-b521-c58e02edc704' 
       and intakeserviceid='43d1ed2a-ff60-4c0c-ad0c-446f1617649c'
    and activeflag =1;


update personrole 
    set activeflag =0,updatedby ='CDM-39375', updatedon =NOW()
   where personid='c868342b-e9ec-46e6-b521-c58e02edc704' 
       and intakeserviceid='43d1ed2a-ff60-4c0c-ad0c-446f1617649c'
    and activeflag =1;


update personroletype 
set activeflag = 0,updatedon =now(), updatedby ='CDM-39375'
where personroletypeid = '9fdb7357-049f-45ea-808f-ce3664c1a817' 
  and activeflag =1;


update personprogramarea 
set activeflag =0, updatedon =now(), updatedby ='CDM-39375'
where personprogramid ='e7409490-2bd9-4b5f-9fca-eb22fc49471e' 
  and activeflag =1;