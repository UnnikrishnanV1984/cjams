update personimmunization p 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-15109'
where personimmunizationid in ('3bd754e1-76d9-49cc-aefa-43c39f00e764', '278b519d-c1e3-4f2f-9650-1718bce0906a');