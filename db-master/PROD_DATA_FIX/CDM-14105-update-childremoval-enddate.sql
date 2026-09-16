-- CDM-14105 - Change child removal exit date
update intakeservreqchildremoval 
set exitdate = '2021-03-18 16:00:00', 
    updatedby = 'CDM-14105', 
    updatedon = now() 
where intakeservreqchildremovalid =  '99089081-b8f2-4964-a1e8-5f14ee95ecf6';

update personprogramarea 
set enddate = '2021-03-18 00:00:00',
    updatedby = 'CDM-14105', 
    updatedon = now()  
where personprogramid = 'a1b93e95-6041-4d14-a1eb-414eae032e97';
