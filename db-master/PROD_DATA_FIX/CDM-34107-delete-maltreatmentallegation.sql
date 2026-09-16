/*
   Issue Description: CDM-34107
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

  update investigationmaltreatment set activeflag =0,updatedby ='CDM-34107',updatedon =now() where investigationid = 'a2e0a3b0-ff23-4455-8b0a-688c6ccfa8bb' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34107',updatedon =now() where investigationid = 'a2e0a3b0-ff23-4455-8b0a-688c6ccfa8bb' and activeflag= 1;