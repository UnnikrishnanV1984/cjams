/*
   Issue Description: CDM-34115
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

  update investigationmaltreatment set activeflag =0,updatedby ='CDM-34115',updatedon =now() where investigationid = 'db3a942c-125e-417c-8259-3b0e22070621' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34115',updatedon =now() where investigationid = 'db3a942c-125e-417c-8259-3b0e22070621' and activeflag= 1;