/*
   Issue Description: CDM-14950
   Category/ Module  :  
   Root cause: End dating person program for a closed case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update personprogramarea set enddate = '2021-07-01 00:00:00', updatedby = 'CDM-14950', updatedon = now() where personprogramid in ('ffdcf0ae-fd07-460a-8677-39c37b409a10','a5c166fc-040c-4d73-8cec-8021022c7686','bf16f3a4-4d16-4e1a-8c19-b68c29de5fa6','dd63f47e-18a8-4764-94fe-ed1933ddeadf');

