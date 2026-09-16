--Reverting changes for CDM-12557
update intakeservicerequest i set servicecaseid = '902242c7-0745-4726-83f8-328c02ff69e9',updatedby = 'CDM-12930', updatedon = now() 
where servicerequestnumber = '2021098099596' and intakeserviceid = '1865f231-a5d0-4236-b4b7-bab79864c5e9';

update servicecasedisposition set activeflag = 1, updatedon = now(),updatedby = 'CDM-12930' where servicecasedispositionid = '081e3602-3b19-4fc0-bd2c-16c1918b919c';