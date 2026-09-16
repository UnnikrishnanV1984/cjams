/*
   Issue Description: CIDM-6980
   Category/ Module  : Child Removal
   Root cause: Soft deleting the removal record for the person where person is still not in case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.intakeservreqchildremoval
SET activeflag = 0, updatedby = 'CIDM-6980', updatedon = now()
WHERE intakeservreqchildremovalid in ('0f17c823-5312-4fb1-b401-f30cbf7f827e','f528e32d-a424-43f8-a160-095dbfdf83e0',
'8585524e-8854-45aa-8b86-328b39c04055','eda9c9d4-577e-411f-b885-5963cda62168','a07c8245-471e-43c6-8ce4-5baea651ae5b',
'c523f47c-3e49-42dd-8a47-2f0db8503e66','5360e908-ece7-4aaf-8727-ec00d5a76f3c','9aa61f86-198f-4cdb-8787-0cbde69ec3f4',
'1d5a3678-c801-4b95-9952-a081eecd46e4','4e78f5de-8aae-410b-99bc-9be35755c125','962e2f78-a65a-4796-b0e6-5062f3d4d8f6');
