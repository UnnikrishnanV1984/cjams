/*
   Issue Description: CDM-33565
   Category/ Module  : Prod data fix to Remove GapAnnual Review
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update gapannualreview set activeflag = 0, updatedon = now(), updatedby = 'CDM-33565' where gapannualreviewid in ('12817fb4-24c3-459b-a775-01afe08b64ef','8f895577-6cfd-47c7-91d6-d6959e5834bc','a9acd695-17ea-4fae-8a84-cc72bed8706b','0a039475-8b80-4fad-a7a2-4bf2263ab974') and activeflag = 1;
