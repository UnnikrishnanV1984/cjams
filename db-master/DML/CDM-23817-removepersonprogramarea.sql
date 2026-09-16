/*
   Issue Description: CDM-23817
   Category/ Module  : Remove Person Program Area
   Root cause: Remove Person Program Area for IR Case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- person program removal
update personprogramarea p set activeflag = 0,
updatedby = 'CDM-23817',updatedon = now()
where personprogramid = 'f92fc8e7-15f1-49e3-a7d1-eb9b4cfc0a38';

update personprogramarea set entityid = '221020233622', updatedby = 'CDM-23817', updatedon = now()
where personprogramid = '3dcf45a8-e351-4f58-9b1c-ccb0ed70c7f0';