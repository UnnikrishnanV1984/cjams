/*
   Issue Description: CDM-34000
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

  update investigationmaltreatment set activeflag =0,updatedby ='CDM-34038',updatedon =now() where investigationid = 'df8da36a-928e-4a33-b21b-98f6122aa01c' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34038',updatedon =now() where investigationid = 'df8da36a-928e-4a33-b21b-98f6122aa01c' and activeflag= 1;