/*
   Issue Description: CDM-20622
   Category/ Module  : Contact Notes
   Root cause: user wants to remove contact notes
   Pull request# for code fix: 4920
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
*/
update progressnote set activeflag = 0, updatedon = now(), updatedby = 'CDM-20622' 
where progressnoteid = '2ddc1a46-849b-4bf8-a545-1e59e21f23ad';

update progressnotedetail set activeflag  = 0, updatedon = now(), updatedby = 'CDM-20622'
where progressnoteid = '2ddc1a46-849b-4bf8-a545-1e59e21f23ad' and activeflag  = 1;