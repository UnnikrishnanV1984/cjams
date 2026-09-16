-- CDM-9334 - End date person program assignment and Child removal

update personprogramarea set enddate = '2020-06-23 14:24:45', updatedby = 'CDM-9334', updatedon = now() where personprogramid='5deb8287-cf46-4bae-a5a7-eb1bf583b735' and activeflag=1;

update intakeservreqchildremoval set exitdate = '2020-06-23 14:00:40', updatedby = 'CDM-9334', updatedon = now() where intakeservreqchildremovalid = '7f683633-439f-40ff-a269-2f5ee1a844cf';
