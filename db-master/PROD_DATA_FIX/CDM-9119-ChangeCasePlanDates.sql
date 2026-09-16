-- CDM-9119 - Change case plan dates for the approved case plan

update snapshothist set fromdate = '2020-02-29', todate = '2020-08-25', updatedby = 'CDM-9119', updatedon = now() where id='35a5ebc8-92af-4993-9b54-9db091f2a932' and objectid = 'c1ccd818-e672-4a46-afb2-6807fabf5bdf' and activeflag = 1 and approvalstatus = 'Approved';
