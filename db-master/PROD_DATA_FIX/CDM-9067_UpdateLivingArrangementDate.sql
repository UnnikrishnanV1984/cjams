-- CDM-9067 - Update start date of living arrangement

update livingarrangement set livingstartdate = '2021-01-07 00:00:00', updatedby = 'CDM-9067', updatedon = now() where placementid ='73626c3e-b989-4804-81c3-69af9c7a4c50' and activeflag =1;