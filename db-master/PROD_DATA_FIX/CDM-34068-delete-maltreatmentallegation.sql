/*
   Issue Description: CDM-34000
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

update investigationmaltreatment set activeflag =0,updatedby ='CDM-34068',updatedon =now() where investigationid = 'f6e8d834-afd0-4c2e-9876-7a2ee2ee2971' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34068',updatedon =now() where investigationid = 'f6e8d834-afd0-4c2e-9876-7a2ee2ee2971' and activeflag= 1;