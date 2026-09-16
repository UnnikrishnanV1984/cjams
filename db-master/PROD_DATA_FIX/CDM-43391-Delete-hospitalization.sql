/*

   Issue Description: CDM-43391-Delete hospitilization record.

   Category/ Module  : Person

   Root cause: User requested to delete hospitilization record.

   Fix provided :Datafix to delete hospitilization record.

   Code fix ticket#:

   Reason why no related code fix: 

   Status of the code fix if already submitted and expected prod fix date: 

   Backup before update/ delete:



*/












update personhospitalization
set activeflag = 0, updatedon= now(), updatedby='CDM-43391'
where hospitalizationid='00ea880b-acb0-4862-92e5-69d8f7ed34ac' and activeflag = 2;


