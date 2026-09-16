-- CDM-10234 - Remove referral and the associated investigation

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-10234',updatedon = now() where intakeserviceid ='1d47986c-c1ec-44cc-916a-830e48d05e3b' and activeflag = 1; 
update investigation set activeflag = 0, updatedby = 'CDM-10234',updatedon = now() where intakeserviceid ='1d47986c-c1ec-44cc-916a-830e48d05e3b' and activeflag = 1; 