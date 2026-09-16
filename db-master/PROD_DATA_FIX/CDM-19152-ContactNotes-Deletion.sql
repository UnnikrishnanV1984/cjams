/*
   Issue Description: CDM-19152
   Category/ Module  : Contact notes
   Root cause: user wants to delete contact notes
   Pull request# for code fix: 4911
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
	
update progressnote set activeflag = 0, updatedon = now(), updatedby = 'CDM-19152' 
where progressnoteid = '90671c1a-254d-430f-b461-654caf26ebc7';

update progressnotedetail set activeflag  = 0, updatedon = now(), updatedby = 'CDM-19152'
where progressnoteid = '90671c1a-254d-430f-b461-654caf26ebc7' and activeflag  = 1;