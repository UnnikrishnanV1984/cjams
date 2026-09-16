/*
   Issue Description: CDM-24833
   Category/ Module  : Prod data fix on person program area
   Root cause: user wants to remove the records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update personprogramarea set activeflag = 0, updatedon = now(), updatedby = 'CDM-24833'
where personprogramid in ('087364fc-cd59-4814-8197-53e5c10565b1','19136500-0124-40b2-a596-5a43acf01307') and activeflag = 1 ;

--2022-05-02 00:00:00.000
update personprogramarea set startdate = '2022-04-27 00:00:00.000', updatedon = now(), updatedby = 'CDM-24833'
where personprogramid = '19136500-0124-40b2-a596-5a43acf01307';
