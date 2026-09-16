/*
   Issue Description: CDM-34526
   Category/ Module  : Contact 
   Root cause: user want to update data of Contact Purpose with Monthly Visit for contact ID # 11405915.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update progressnote set progressnotereasontypekey='MV,WV', updatedby='CDM-34526',updatedon =now() where 
progressnoteid in ('3b7d35f4-07f0-4921-9572-1985597b69f6');