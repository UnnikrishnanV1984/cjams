/*
   Issue Description: CDM-43722 Need data fix to remove the GAP Subsidy rate dated 4/4/2024 - 4/3/2025.
                      Client ID: 3105698 (LILLIAN TEMPLEGARRITY)
                      Provider ID: 5078034 (Phyllis House)
   Category/ Module  : Permanency Plan (GAP)
   Root cause: duplicate subsidy rate slab created and user wants to get rid of it.
   Fix Provided: Data fix has been done to remove the GAP Subsidy rate dated 4/4/2024 - 4/3/2025.
   Data/Code fix ticket#: CDM-43722
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User error
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/

update gapagreementrate set activeflag =0, updatedby='CDM-43722', updatedon = now() where gapagreementrateid ='6d417065-2295-46db-8545-d108af7e35d5';
update gapratesrevision set activeflag =0, updatedby = 'CDM-43722', updatedon = now() where gaprateid ='6d417065-2295-46db-8545-d108af7e35d5';
update routing set 	activeflag =0, updatedby = 'CDM-43722', updatedon = now() where objectid ='6d417065-2295-46db-8545-d108af7e35d5';
