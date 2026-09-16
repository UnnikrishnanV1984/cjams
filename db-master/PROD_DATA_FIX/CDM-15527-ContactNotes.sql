/*
   Issue Description: CDM-15527
   Category/ Module  :  contact notes
   Root cause: user wants to remove the contact notes as entered wrong info
   Pull request# for code fix: 4961
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update progressnote set activeflag = 0, updatedon = now(), updatedby = 'CDM-15527' 
where progressnoteid in ('b399aaf6-e601-45d2-8faf-de9d7c408160', '4dad60b5-5419-46c1-9a64-eb7b003deea3');

update progressnotedetail set activeflag  = 0, updatedon = now(), updatedby = 'CDM-15527'
where progressnoteid in ('b399aaf6-e601-45d2-8faf-de9d7c408160', '4dad60b5-5419-46c1-9a64-eb7b003deea3');
