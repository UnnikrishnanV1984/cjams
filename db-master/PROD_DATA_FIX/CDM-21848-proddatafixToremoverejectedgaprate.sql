
/*
   Issue Description: CDM-21848
   Category/ Module  : Prod data fix To remove the Gap agreement rate
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update gapagreementrate set activeflag = 0, updatedby = 'CDM-21848', updatedon = now() where gapagreementrateid = 'cd0688b4-ed8b-42f8-bb64-1e7e26ff5559' and activeflag = 1;
update gapratesrevision set activeflag = 0 , updatedby = 'CDM-21848', updatedon = now() where gaprateid  = 'cd0688b4-ed8b-42f8-bb64-1e7e26ff5559' and activeflag = 1;
update routing set activeflag = 0 , updatedby = 'CDM-21848', updatedon = now() where objectid  = 'cd0688b4-ed8b-42f8-bb64-1e7e26ff5559' and activeflag = 1;
