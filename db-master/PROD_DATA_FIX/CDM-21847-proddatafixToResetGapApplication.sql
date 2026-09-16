
/*
   Issue Description: CDM-21848
   Category/ Module  : Prod data fix To remove the Gap agreement rate
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update gapapplication set activeflag = 0, updatedby = 'CDM-21847', updatedon = now() where gapapplicationid = '9ab996b7-857f-4384-a909-70aae939dbef' and activeflag = 1;
update routing set activeflag = 0, updatedby = 'CDM-21847', updatedon = now() where objectid = '9ab996b7-857f-4384-a909-70aae939dbef' and activeflag = 1;

