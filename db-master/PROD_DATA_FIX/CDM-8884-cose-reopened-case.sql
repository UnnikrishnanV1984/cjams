update servicecase set enddate = '2014-05-27 13:37:49', dispositioncode ='Closed', updatedon=now(), updatedby = 'CDM-8884'
where servicecasenumber = '3074027';

update servicecasedisposition set activeflag = 0, updatedon=now(), updatedby = 'CDM-8884' 
where servicecasedispositionid = '4d15b1a6-2d09-4a1d-ba5e-b2aca90b501c';