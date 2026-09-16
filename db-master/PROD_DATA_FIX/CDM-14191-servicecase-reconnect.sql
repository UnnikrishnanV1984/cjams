select * from cjams.createservicecase('a14fc1b4-f787-4a56-8bef-4014fbc405de', 'acc8fa22-ea2b-4ae3-8a20-6d3d5cf739d8', 0,'c4d0b6a8-99c0-4d7e-b6ff-859618c9d4ae', 'intake' );

update servicecase 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-14191'
where servicecasenumber = '211030008401';