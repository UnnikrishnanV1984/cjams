/*
   Issue Description: CDM-16385
   Category/ Module  : Child removal
   Root cause: Duplicate child removal
   Pull request# for code fix: 
   Explanantion: User wants to remove the child removal duplicates from the system
*/

update personprogramarea 
set activeflag = 0,
    updatedby = 'CDM-16385',
    updatedon = now()
where personprogramid in ('050a97af-7f86-4a04-ab61-ad5cbe39f5b5', 'c02be002-a375-43bc-b301-a3ad18548385', 'f7cf1462-dec0-4b37-9c04-460259a90435');

update intakeservreqchildremoval 
set activeflag = 0,
    updatedby = 'CDM-16385',
    updatedon = now()
where intakeservreqchildremovalid in ('c7d38065-7c9d-4c92-b3c8-c8bd250d1f23','899d6143-a4dc-42c6-8d88-812eaebfd6d9', 'e28b9ad0-74c3-4065-9520-286d36811a8a');

update routing 
set activeflag = 0,
    updatedby = 'CDM-16385',
    updatedon = now()
where objectid in ('c7d38065-7c9d-4c92-b3c8-c8bd250d1f23','899d6143-a4dc-42c6-8d88-812eaebfd6d9', 'e28b9ad0-74c3-4065-9520-286d36811a8a');
