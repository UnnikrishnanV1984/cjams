/*
   Issue Description: CDM-24833
   Category/ Module  : duplicate personprograms 
   Root cause: user wants to remove the duplicate person programs
   Pull request# for code fix: 5461
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personprogramarea set activeflag = 0, updatedon = now(), updatedby = 'CDM-24833'
where personprogramid in ('087364fc-cd59-4814-8197-53e5c10565b1','19136500-0124-40b2-a596-5a43acf01307','1a8839eb-6509-4ed2-afcd-7c2701106fab') and activeflag = 0 ;

update personprogramarea set objectid  = '4e1c0c3b-60b1-46e0-bcb1-705ec1cfb1bb', entityid = '211030012878', updatedon = now(), updatedby = 'CDM-24833'
where personprogramid = 'cfef851f-3029-40e2-ac96-d32e4782e141';