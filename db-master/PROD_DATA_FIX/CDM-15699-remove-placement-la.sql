/*
    CDM-15699
    User asked to delete the living arrangement
*/

update livingarrangement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-15699' 
where placementid = '8300da82-e08c-421b-9c0a-6fdf9c381a91';

update placement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-15699' 
where placementid = '8300da82-e08c-421b-9c0a-6fdf9c381a91';