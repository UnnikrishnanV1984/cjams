/*
   Issue Description: CDM-34090
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: Incorrect investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

  

update investigationmaltreatment set activeflag =0,updatedby ='CDM-34090',updatedon =now() where investigationid = 'c937010c-9524-45d5-b199-59e453c2b009' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34090',updatedon =now() where investigationid = 'c937010c-9524-45d5-b199-59e453c2b009' and activeflag= 1;