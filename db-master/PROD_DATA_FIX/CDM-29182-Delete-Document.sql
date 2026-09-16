/*
   Issue Description: CDM-29182
   Category/ Module  : documents tab
   Root cause: user wants to delete the document which was added bymistake
   Pull request# for data fix: 8220
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/
update documentproperties set activeflag = 0, updatedby = 'CDM-29182', 
updatedon = now() where documentpropertiesid = '824d21c5-7e82-452f-90cd-3edad35f100b';

update documentattachment set activeflag = 0, updatedby = 'CDM-29182', 
updatedon = now() where documentpropertiesid = '824d21c5-7e82-452f-90cd-3edad35f100b';