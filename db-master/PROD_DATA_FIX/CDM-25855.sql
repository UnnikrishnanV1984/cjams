/*
   Issue Description: CDM-25855
   Category/ Module  : Prod data fix to case connect
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update cjams.caseassignment  set activeflag =0, updatedby  ='CDM-25855', updatedon =now()

where caseassignmentid ='a6a7b094-4ed7-4d21-a11f-dab141fafe2a';


update cjams.investigation set activeflag =0, updatedby  ='CDM-25855', updatedon =now()

where intakeserviceid ='0c0a748c-6ff1-4155-b09f-c24f0ee6d315';


select * from createservicecase('0c0a748c-6ff1-4155-b09f-c24f0ee6d315', '9badfa79-3f37-4ebd-b114-c6ad71e599ae', 0, 'd3ed46a3-e946-48f6-83b5-75972c2e3047') ;


