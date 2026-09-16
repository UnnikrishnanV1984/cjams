/*
 * CDM-35087 - Intake Referral
 * Customer Email ID:jill.taylor1@maryland.gov
 * Customer Name:Jill Taylor
 * Focus Area:Services: Other
 * Description - Dashboard:Intake: I231010731052 Michelle ChildersDated: 7-5-2023Just showed up on Denise Winder's dashboard when I select her. 
 * The referral does not show on her dashboardIt is from 7-5-2023 but just appearedNeeds to be deleted 
 * remove/delete the Intake # I231010731052 as requested.
 * 
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35087'
where objectid in ('I231010731052');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-35087',
    updatedon = now()
WHERE intakenumber in ('I231010731052');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-35087',
    updatedon = now()
WHERE intakenumber in ('I231010731052');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35087'
WHERE intakenumber in ('I231010731052');
