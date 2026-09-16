--CDM-7629 - update programassignment end reason 3248648

UPDATE personprogramarea SET endreasonkey = 3379, updatedby = 'CDM-7629', updatedon = now() 
WHERE personprogramid = 'f82aa75a-4de7-4814-882c-a4c247356c5f' AND programkey = 'AXYS' AND activeflag = 1;
