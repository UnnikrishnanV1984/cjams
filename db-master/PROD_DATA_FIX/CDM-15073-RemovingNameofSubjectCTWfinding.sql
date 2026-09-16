/*
   Issue Description: CDM-15073
   Category/ Module  :  Updating the Exit date for Removal Record
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- CDM-15073
--TEQUIALA BRADLEY
update tb_foster_care_judicial tfcj set nameofsubjectctwfinding = null, updatedby = 'CDM-15073', updatedon = now() where client_id = '3304875' and removal_id = 199091;


