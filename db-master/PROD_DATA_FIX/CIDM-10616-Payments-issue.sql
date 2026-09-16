/*
Issue Description: Adoption Subsidy Payment Issue
Category/Module: Payments issue
Root cause: Provider # 5033807 category has been updated from the provider side and need to run the Finance batch from CW side to pay the adoption subsidy for June 2025 service.
Fix provided: Data fix has been done to update latest payments associated with this provider to trigger the finance batch.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Provider category has been updated and data fix is needed to resolve it.
*/


-- select adoptionagreementid ,*from adoptioncaseagreement a where adoptioncaseid in ('f9b9bf82-7d75-42db-80b5-d5626de290f2','c22de8b3-7db5-4d23-a7ef-8451cb9863fd','221a3d46-48f7-487d-b2f0-2591886dbc6a','6cb48144-bd38-4281-a4a5-ebe713cc4969','15df06fa-6032-47c0-86cc-7e63b5414bc6','b7fc45db-7698-4466-b394-8020399da21d','9020564f-33e3-491e-880f-ee7cc57edbb6','a74901ec-7994-420f-bb40-82977bf4b06f')


-- select *from adoptioncase where adoptioncasenumber in ('221040018420','221040018157','221040018826','221040018411','231040232294','231040232327','3233548','3233547')

--Updating the latest subsidy rate to trigger under over batch.

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CIDM-10616'
where adoptionagreementrateid in ('b4384f03-d150-4e36-9248-5fc384e4a3d7','72b44a41-3d9c-45c9-b5f8-2bd01033ab91','b340dde5-9c1a-40d5-b3d6-9d3caa3e9d92','9875574f-5809-4b63-95cb-38a927a2c50c','32c1c69a-f240-4066-98f7-9bd4fe3127a7','3ac51e87-91af-4a07-a8fd-11d45381151c','664b43c1-d24e-45a1-b37e-a51c4d59d0e2','a01fce38-d234-498e-87d9-b40d2626184f')
and activeflag = 1;    