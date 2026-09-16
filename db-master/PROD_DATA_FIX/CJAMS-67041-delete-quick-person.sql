/*
   Issue Description: CJAMS-67041
   Category/ Module  : Quickperson card
   Root cause: user wants to delete quick add person card.
   Fix provided: data fix has been provided by updating the deletestatus value to display the delete icon on application
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/



update quickperson
set deletestatus ='R', updatedby ='CJAMS-67041', updatedon =now()
where  quickpersonid = '86a38bff-052a-48c8-bbb2-eeafd9de30c1';