update placement 
set
enddatetime = null,
endtime = null,
updatedon = now(),
updatedby = 'CDM-13844'
where placementid = 'e3413367-a9e6-4d4d-acf3-7ca9456904db';

update placementrevision 
set
exitdate = null,
exittime = null,
updatedon = now(),
updatedby = 'CDM-13844'
where placementid = 'e3413367-a9e6-4d4d-acf3-7ca9456904db';