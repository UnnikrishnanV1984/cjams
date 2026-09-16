-- CDM-10742 - remove end date for child removal and program assignment

update intakeservreqchildremoval set exitdate =null, updatedby ='CDM-10742', updatedon = now()  where intakeservreqchildremovalid ='dfdfb750-f1f5-4f08-b79b-eb93cfd21a12' and activeflag =1;
update personprogramarea set enddate =null, updatedby ='CDM-10742', updatedon = now()  where personprogramid ='dd1d3df4-aa68-4b61-a9d1-8c6feeb0c5fa' and activeflag =1;
