
-- Category/ Module: Assessment 
-- Root cause: Submissionid is missing  
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 




update assessment set submissionid ='f0e2d6c7-34dc-4243-a5b9-454d54d2af04' where assessmentid ='d8511c14-61f0-4857-99dd-d92a0179adcf';


--Removing Duplicate records

update assessment set activeflag =0, updatedby ='CDM-30950', updatedon = now()

where assessmentid in ('24861884-2358-498e-9bae-95c69543b416','5ed27f3d-6497-4a8e-97fd-ea09f5fb5b49','9637af8a-e089-4b0d-9f8c-bdc65295fe7a',
'872d48dd-f09e-4052-b5cb-f5d075e88751', 'aeaee9b9-7ef5-42d4-83d2-803a1e207eee','d8511c14-61f0-4857-99dd-d92a0179adcf','ae13590c-3c46-4c11-8a19-81dc39bca9cb');