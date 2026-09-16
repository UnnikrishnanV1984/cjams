/*
   Issue Description: CDM-32033
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



--8c533ce8-bc9e-4062-9d15-3e5b4421ab6c
--34791ec8-ec78-4fdd-9684-6595cffba780
--4f77059e-7efa-4df8-b810-67408df11399
--a6ab38ed-30ae-4e7f-a128-3ed343be9ea8
update documentproperties set insertedby = 'fc18350a-e495-49c7-929a-049679f0a228', updatedby = 'CDM-32033', updatedon = now()
where documentpropertiesid in ('80f51916-f8d9-4bc6-81d4-7f5e9bc19e94',
'7d5f5364-0300-44a6-b841-2b2e8abd5271',
'ed2bb4d2-501f-4a0b-bd2d-c69a69810b4b',
'27f4d6da-e10f-45a3-af5e-4702b04a5f5a');



--8c533ce8-bc9e-4062-9d15-3e5b4421ab6c
--34791ec8-ec78-4fdd-9684-6595cffba780
--4f77059e-7efa-4df8-b810-67408df11399
--a6ab38ed-30ae-4e7f-a128-3ed343be9ea8
update documentattachment set insertedby = 'fc18350a-e495-49c7-929a-049679f0a228', updatedby = 'CDM-32033', updatedon = now()
where documentpropertiesid in ('80f51916-f8d9-4bc6-81d4-7f5e9bc19e94',
'7d5f5364-0300-44a6-b841-2b2e8abd5271',
'ed2bb4d2-501f-4a0b-bd2d-c69a69810b4b',
'27f4d6da-e10f-45a3-af5e-4702b04a5f5a');