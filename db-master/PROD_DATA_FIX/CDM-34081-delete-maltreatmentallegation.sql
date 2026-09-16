/*
   Issue Description: CDM-34081
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

  update investigationmaltreatment set activeflag =0,updatedby ='CDM-34081',updatedon =now() where investigationid = '6fd00210-148f-43d0-aefd-b26eae01f37a' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34081',updatedon =now() where investigationid = '6fd00210-148f-43d0-aefd-b26eae01f37a' and activeflag= 1;