/*
   Issue Description: CDM-34122
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

 update investigationmaltreatment set activeflag =0,updatedby ='CDM-34122',updatedon =now() where investigationid = '28a15b8a-178a-42c5-9395-815216b469a9' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34122',updatedon =now() where investigationid = '28a15b8a-178a-42c5-9395-815216b469a9' and activeflag= 1;