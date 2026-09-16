--CDM-22804

update Permanencyplan set activeflag = 0, updatedon = now(), updatedby = 'CDM-22804' 
where permanencyplanid  in ('3d282005-6983-4e28-af75-37bcd58a7a22','323281da-90b4-429f-9267-ec8db863f850');

update Permanencyplan set intakeservicerequestactorid='296e7564-41b6-41f3-a4a9-a5ef36d56cb7', updatedon = now(), updatedby = 'CDM-22804' 
where permanencyplanid  in ('7ae6c26d-fdf2-4656-b7c1-d1d3f7e15ad1');
