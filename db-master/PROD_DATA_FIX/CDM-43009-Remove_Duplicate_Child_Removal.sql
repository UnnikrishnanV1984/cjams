/*
   Issue Description: CDM-43009
   Category/ Module  :  Child Removal History
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: raised an internal ticket for RCA (CIDM-9859)
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval 
set activeflag = 0, 
    updatedby = 'CDM-43009', 
    updatedon = now() 
where intakeservreqchildremovalid = '9936a78f-8892-43c3-8de0-a301a5f8f57a';

update intakeservreqchildremoval_history 
set activeflag = 0,
    updatedon  = now(), 
    updatedby  ='CDM-43009'
where intakeservreqchildremovalid = '9936a78f-8892-43c3-8de0-a301a5f8f57a'
      and activeflag = 1;

update routing 
set activeflag = 0, 
    updatedon  = now(), 
    updatedby  ='CDM-43009'
where objectid = '9936a78f-8892-43c3-8de0-a301a5f8f57a'
      and activeflag = 1;


update placement 
set intakeservreqchildremovalid = '6b4f6a9c-fdf3-438e-862f-cc124f074df1',
    updatedon =now(),
    updatedby  ='CDM-43009'
where intakeservreqchildremovalid =  '9936a78f-8892-43c3-8de0-a301a5f8f57a'
      and activeflag = 1;
