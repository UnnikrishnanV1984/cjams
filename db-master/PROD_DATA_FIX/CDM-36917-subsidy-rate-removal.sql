/*
   Issue Description: CDM-36917
   Category/ Module  : Agreement Rate
   Root cause: User requested to remove subsity rate
   Resolution: Provided data fix for emoval of subsity rate in review.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



select * from adoptioncaseagreementrate  where adoptionagreementrateid = 'da1d2cc3-5aba-4034-8414-332d23985b1d' and adoptionagreementid = '58585247-beb4-4171-b343-1ee18a1a9aa4';

update cjams.adoptioncaserevision set activeflag =0, updatedby ='CDM-36917', updatedon = now()
where adoptionagreementrateid = 'da1d2cc3-5aba-4034-8414-332d23985b1d' and adoptionagreementid = '58585247-beb4-4171-b343-1ee18a1a9aa4';

select * from adoptioncaseagreementrate where adoptionagreementrateid = 'da1d2cc3-5aba-4034-8414-332d23985b1d' and adoptionagreementid = '58585247-beb4-4171-b343-1ee18a1a9aa4';

UPDATE cjams.adoptioncaseagreementrate
set activeflag =0, updatedby ='CDM-36917', updatedon = now()
where adoptionagreementrateid = 'da1d2cc3-5aba-4034-8414-332d23985b1d' and adoptionagreementid = '58585247-beb4-4171-b343-1ee18a1a9aa4';