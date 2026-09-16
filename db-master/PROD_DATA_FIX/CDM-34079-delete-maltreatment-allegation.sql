/*
   Issue Description: CDM-34000
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

  update investigationmaltreatment set activeflag =0,updatedby ='CDM-34079',updatedon =now() where investigationid = 'a5f82185-8ab1-4a7b-84dd-dcb948675454' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34079',updatedon =now() where investigationid = 'a5f82185-8ab1-4a7b-84dd-dcb948675454' and activeflag= 1;
