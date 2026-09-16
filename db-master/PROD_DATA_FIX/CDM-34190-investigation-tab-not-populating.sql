/*
   Issue Description: CDM-34190
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

 

update investigationmaltreatment set activeflag =0,updatedby ='CDM-34190',updatedon =now() where investigationid = 'f08b89be-d4de-4855-a65d-13c10a2ab095' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34190',updatedon =now() where investigationid = 'f08b89be-d4de-4855-a65d-13c10a2ab095' and activeflag= 1;
