/*
   Issue Description: CDM-24809
   Category/ Module  : Program Assignment
   Root cause: user wants to end date OOH program assignment
   Pull request# for code fix: 6239
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update personprogramarea set enddate = '2022-06-08 00:00:00', updatedon = now(), updatedby = 'CDM-24809'
where personprogramid = '1e424858-0f64-40ae-b0e2-ec3dcbf8e04a';
