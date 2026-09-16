update placement 
set activeflag =0, updatedon =now(), updatedby ='CDM-9807'
where placementid ='6934398d-5bdf-464b-975a-b8e16f9ba664';

update placementrevision 
set activeflag =0, updatedon =now(), updatedby ='CDM-9807'
where placementid ='6934398d-5bdf-464b-975a-b8e16f9ba664';