
update placement 
set enddatetime ='2020-09-23 00:00:00', updatedon =now(), updatedby ='CDM-12100'
where placementid ='85b56f06-3599-40eb-a8c2-400e0001bdb0';

update placementrevision 
set exitdate ='2020-09-23 00:00:00', updatedon =now(), updatedby ='CDM-12100'
where placementrevisionid in ('71e21431-7290-4ca7-89de-a930fd54aa09','0f2f8416-5b32-4578-8a3d-3d7391dfa483');