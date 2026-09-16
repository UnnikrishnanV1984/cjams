update placement 
set 
enddatetime = null,
endtime = null,
updatedon = now(),
updatedby = 'CDM-13678'
where placementid = '586a3072-7575-44d4-be4b-5ebacd6114e6';

update placementrevision 
set 
exitdate = null,
exittime = null,
updatedon = now(),
updatedby = 'CDM-13678'
where placementid = '586a3072-7575-44d4-be4b-5ebacd6114e6';