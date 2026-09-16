/*
   Issue Description: CDM-31154
   Category/ Module  : Child Removal
   Root cause: user Need to update Start date and Delete the 2nd record which is duplicate
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


update cjams.Intakeservreqchildremoval set removaldate='2023-02-01 00:00:00' ,updatedon = now(), updatedby = 'CDM-31154' where intakeservreqchildremovalid='816a1b85-16df-48d2-b2a0-35aa35913639' and activeflag=1;

update cjams.Intakeservreqchildremoval set activeflag=0 ,updatedon = now(), updatedby = 'CDM-31154' where intakeservreqchildremovalid='036aca4d-3200-4112-a5e9-49fa3e669409' and activeflag=1;

update cjams.personprogramarea set activeflag=0 ,updatedon = now(), updatedby = 'CDM-31154' where personprogramid='e64f6db6-08a8-4e11-ad27-1ab20de417f0';

update tb_client_eligibility set  delete_sw='Y' ,update_ts = now(), update_user_id = 'CDM-31154' where removal_id = 272887;
