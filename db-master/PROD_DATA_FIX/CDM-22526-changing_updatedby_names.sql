/*
   Issue Description: CDM-22526
   Category/ Module  : Changing Updated by names
   Root cause: The program area for each of these three people shows that a worker from three different counties was the last to update.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update personprogramarea set updatedby = 'ccb47e64-c053-49d9-afe8-ed410def5d9e', updatedon = now() where personprogramid = '82527eb0-6c2a-4658-b92d-431fe94130c7';
update personprogramarea set updatedby = 'ccb47e64-c053-49d9-afe8-ed410def5d9e', updatedon = now() where personprogramid = 'db8b26ea-fd6e-4e31-a02c-4498b63effcb';

