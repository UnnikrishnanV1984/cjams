-- 2021-06-18 00:00:00
update placement set enddatetime = null, updatedby = 'CDM-14423', updatedon = now() where placementid = '8dba236a-42c0-47e8-979e-6ebe734607d6';
-- 2021-06-18 00:00:00	13:30
update placementrevision set exitdate = null,exittime = null, updatedby = 'CDM-14423', updatedon = now() where placementrevisionid = '189326b3-d3a9-4d04-a60c-a093857328c5';
