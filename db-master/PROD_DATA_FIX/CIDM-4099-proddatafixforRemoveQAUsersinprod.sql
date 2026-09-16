
/*
   Issue Description: CIDM-4099
   Category/ Module  : Removing Users from production
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update userprofile set activeflag = 0, updatedby = 'CIDM-4099',updatedon = now() where email in ('bharatkumar.halderia@maryland.gov','james.whelpley@maryland.gov','harshan.nagulapally@maryland.gov','prathima.joshyula@maryland.gov','william.migliorini@maryland.gov') and activeflag = 1;
