/*
   Issue Description: CDM-34088
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

  update investigationmaltreatment set activeflag =0,updatedby ='CDM-34088',updatedon =now() where investigationid = '6c970dd5-560e-488f-90e5-6144c5919678' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34088',updatedon =now() where investigationid = '6c970dd5-560e-488f-90e5-6144c5919678' and activeflag= 1;