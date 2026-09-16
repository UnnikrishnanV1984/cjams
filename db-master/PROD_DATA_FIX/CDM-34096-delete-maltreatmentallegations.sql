/*
   Issue Description: CDM-34096
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: Incorrect investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

update investigationmaltreatment set activeflag =0,updatedby ='CDM-34096',updatedon =now() where investigationid = '5157565d-4d85-4fac-8838-a5a58290b55f' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34096',updatedon =now() where investigationid = '5157565d-4d85-4fac-8838-a5a58290b55f' and activeflag= 1;