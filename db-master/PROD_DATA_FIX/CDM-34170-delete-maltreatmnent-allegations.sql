/*
   Issue Description: CDM-34170
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */
update investigationmaltreatment set activeflag =0,updatedby ='CDM-34068',updatedon =now() where investigationid = '369c7d19-4dd6-4ba4-a702-50bd66d0d783' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34068',updatedon =now() where investigationid = '369c7d19-4dd6-4ba4-a702-50bd66d0d783' and activeflag= 1;