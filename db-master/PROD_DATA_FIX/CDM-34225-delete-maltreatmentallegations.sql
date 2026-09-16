/*
   Issue Description: CDM-34225
   Category/ Module  :Maltreatment Allegations and Investigation findings
   Root cause: In correct investigaton findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

  update investigationmaltreatment set activeflag =0,updatedby ='CDM-34225',updatedon =now() where investigationid = 'ccf8eb48-3eb6-408c-a828-467d07439f8e' and activeflag= 1;


update investigationallegation set activeflag =0,updatedby ='CDM-34225',updatedon =now() where investigationid = 'ccf8eb48-3eb6-408c-a828-467d07439f8e' and activeflag= 1;
