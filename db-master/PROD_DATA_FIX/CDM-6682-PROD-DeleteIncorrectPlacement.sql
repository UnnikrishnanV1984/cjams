update routing 
set activeflag =0, updatedon =now(), updatedby ='CDM-6682'
where routingid ='6c044530-b5f1-4380-a7e6-897c8ec57f60';

update placement 
set activeflag =0, updatedon =now(), updatedby ='CDM-6682'
where placementid ='5ef4d299-be9a-4e39-8779-053f7a1072de';

update placementrevision 
set activeflag =0, updatedon =now(), updatedby ='CDM-6682'
where placementrevisionid ='82bf587e-be5c-4091-aa12-58e4edaed911';
