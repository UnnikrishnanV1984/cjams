-- 2021-05-26 00:00:00
update placement set enddatetime = '2021-05-25 00:00:00', updatedby = 'CDM-13876', updatedon = now() where placementid ='501061f0-22d8-48a2-95b4-2d844242a5ee';
update placementrevision set exitdate = '2021-05-25 00:00:00', updatedby = 'CDM-13876', updatedon = now() where placementid ='501061f0-22d8-48a2-95b4-2d844242a5ee' and activeflag = 1;
