/*
   Issue Description: CDM-22929
   Category/ Module  : Contact Notes
   Root cause: user wants change time for the contact notes
   Pull request# for code fix:6482
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update progressnote
    set starttime = '2022-05-20 11:25:00', endtime = '2022-05-20 11:55:00', updatedby = 'CDM-22929', updatedon = now()
    where progressnoteid = 'db1a7656-f55c-4aec-8bac-588bc51a5494';