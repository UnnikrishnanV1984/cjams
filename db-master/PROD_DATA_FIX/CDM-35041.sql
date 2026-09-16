/*
 * CDM-35041 - Bug Defect
 * Customer Email ID:tynekia.green@maryland.gov
 * Customer Name:Tynekia Green
 * Focus Area:Services: Other
 * remove/delete the intake # I221010321929
 * 
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35041'
where objectid in ('I221010321929');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-35041',
    updatedon = now()
WHERE intakenumber in ('I221010321929');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-35041',
    updatedon = now()
WHERE intakenumber in ('I221010321929');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35041'
WHERE intakenumber in ('I221010321929');
