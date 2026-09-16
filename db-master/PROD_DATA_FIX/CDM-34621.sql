/*
 * CDM-34621 - Intake
 * Customer Email ID:jill.taylor1@maryland.gov
 * Customer Name:Jill Taylor
 * Focus Area:Assignments
 * Description - Dashboard:Intake #I221010242029 from 2022 is on Dashboard of Ebony Murray. It just appeared. Needs to be removed. 
 * delete Intake - #I221010242029,  we also received approval from SSA and Product owners, attached the same in the ticket
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34621'
where objectid in ('I221010242029');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-34621',
    updatedon = now()
WHERE intakenumber in ('I221010242029');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-34621',
    updatedon = now()
WHERE intakenumber in ('I221010242029');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34621'
WHERE intakenumber in ('I221010242029');
