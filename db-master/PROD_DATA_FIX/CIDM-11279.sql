--   Issue Description: CIDM-11279 - Client ID is showing null for Psychotropic medication request
--   Category/ Module  :  Psychotropic medication request
--   Root cause: Personid, age and couty data is empty for this record
--   Pull request# for code fix: NA
--   Reason why no related code fix: NA
--   Status of the code fix if already submitted and expected prod fix date: NA

update psychotropicmedications 
set personid ='3d835305-40e7-431e-8dda-8cf39259a3d8',
countytypekey='1e886503-ef0a-450c-8607-566c45fa75e4',
age='7 Years 2 month(s) 20 Day(s)',
updatedby = 'CIDM-11279', updatedon = now() 
where psychotropicid = 'cc720b68-22ba-432e-99a5-b4ad62191fb4';