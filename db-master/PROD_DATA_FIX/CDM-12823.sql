update placement
set enddatetime = null, endtime = null, exitreasontypekey = null, exittypekey = null, updatedon = now(), updatedby = 'CDM-12823'
where placementid = '36c0956c-5f18-4cf8-94d0-8b63b8b2ca30';

update intakeservreqchildremoval
set exitdate = null, removalexitreason = null, updatedon = now(), updatedby = 'CDM-12823'
where personid = '5d4681bd-a3fa-40ee-a24a-351db0bd9dfd';