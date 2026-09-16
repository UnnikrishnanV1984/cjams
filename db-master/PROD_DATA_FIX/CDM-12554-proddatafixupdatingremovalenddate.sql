-- 2021-03-31 13:00:00
update intakeservreqchildremoval i set exitdate = '2021-04-07 00:00:00', updatedby = 'CDM-12554', updatedon = now() 
where intakeservreqchildremovalid = '615042e3-da0a-47d5-8301-b4304025a8b5';

update permanencyplan p set enddate ='2021-04-07 00:00:00', updatedby = 'CDM-12554', updatedon = now() where 
permanencyplanid = '715a3bee-e1d8-44d4-8ff1-d08f9fc8bc91';

update personprogramarea set enddate = '2021-04-07 00:00:00', updatedby = 'CDM-12554', updatedon = now() where 
personprogramid = 'ab2d006d-2393-425c-9c1f-a4f77c7c0321';