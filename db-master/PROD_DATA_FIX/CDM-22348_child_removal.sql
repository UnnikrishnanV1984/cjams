/*
   Issue Description: CDM-22348
   Category/ Module  : Child removal
   Root cause: Duplicate child removal
   Pull request# for code fix: 
   Explanantion: User wants to remove the child removal duplicates from the system
*/

update personprogramarea 
set activeflag = 0,
    updatedby = 'CDM-22348',
    updatedon = now()
where personprogramid ='ed227075-fd84-4de5-b9cf-7035bc8ae492';

update intakeservreqchildremoval 
set activeflag = 0,
    updatedby = 'CDM-22348',
    updatedon = now()
where intakeservreqchildremovalid ='a60f333d-bbda-401a-ad34-21fe6cea9079';

update placement 
set intakeservreqchildremovalid = '1b5ba7f2-1e3d-4b88-9f1a-de2ddfd7a44a',
    updatedby = 'CDM-22348',
    updatedon = now()
where intakeservreqchildremovalid ='a60f333d-bbda-401a-ad34-21fe6cea9079';

update routing 
set activeflag = 0,
    updatedby = 'CDM-22348',
    updatedon = now()
where routingid = '78c9aa23-918e-4e60-8cd8-3d7a3dfa6c6e';
