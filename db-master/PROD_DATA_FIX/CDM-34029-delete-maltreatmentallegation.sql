
/*
   Issue Description: CDM-34081
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */
  
update investigationmaltreatment set activeflag =0,updatedby ='CDM-34029',updatedon =now() where investigationid = 'f5b8f066-21c8-4c34-be28-9bf8b1dda1bc' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34029',updatedon =now() where investigationid = 'f5b8f066-21c8-4c34-be28-9bf8b1dda1bc' and activeflag= 1;