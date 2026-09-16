/*
   Issue Description: CDM-34112
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

  update investigationmaltreatment set activeflag =0,updatedby ='CDM-34112',updatedon =now() where investigationid = 'a71fd472-e074-457b-b556-938ffb1e9ed6' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34112',updatedon =now() where investigationid = 'a71fd472-e074-457b-b556-938ffb1e9ed6' and activeflag= 1;