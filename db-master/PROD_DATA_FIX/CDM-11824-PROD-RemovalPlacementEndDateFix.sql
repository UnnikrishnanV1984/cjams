update placement p 
set enddatetime ='2021-03-18 00:00:00', updatedon =now(), updatedby ='CDM-11824'
where placementid in ('77f111bd-efcd-40be-b4d7-051bed23b90a',
'603e1ff9-b454-47f5-b53d-e61ecf35fe9a');

update placementrevision p 
set exitdate ='2021-03-18 00:00:00', updatedon =now(), updatedby ='CDM-11824'
where placementid in ('77f111bd-efcd-40be-b4d7-051bed23b90a',
'603e1ff9-b454-47f5-b53d-e61ecf35fe9a');

update intakeservreqchildremoval 
set exitdate ='2021-03-24 00:00:00', updatedon =now(), updatedby ='CDM-11824'
where intakeservreqchildremovalid ='5751dc5d-e9a4-402d-9524-0ca5abdb65aa';