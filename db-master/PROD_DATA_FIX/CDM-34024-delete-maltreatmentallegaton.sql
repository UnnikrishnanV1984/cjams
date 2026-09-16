/*
   Issue Description: CDM-34024
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */


  update investigationmaltreatment set activeflag =0,updatedby ='CDM-34024',updatedon =now() where investigationid = 'c48964c6-85a6-4690-90ab-9e64c42adcb7' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34024',updatedon =now() where investigationid = 'c48964c6-85a6-4690-90ab-9e64c42adcb7' and activeflag= 1;