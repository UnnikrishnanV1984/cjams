update placement 
set enddatetime ='2020-08-03 12:00:00', endtime ='12:00', updatedon =now(), updatedby ='CDM-7741'
where placementid ='4e6ba463-7f71-47cc-9b9b-0a8cb3321646';

update intakeservreqchildremoval
set exitdate ='2020-08-03 12:00:00', updatedon =now(), updatedby ='CDM-7741'
where intakeservreqchildremovalid = '2a85edd7-4247-417a-983a-a28442be07f4';