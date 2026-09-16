/*
   Issue Description: CDM-30002
   Category/ Module  :
   Root cause: The Permanency Plan start date should be 11/30/2021 for Baleigh, Joseph, Karl, and Julisa.d and 
                Updated the establisheddate to 2021-11-30 05:00:00 in permanencyplanid table
   Pull request#
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 2023-11-30 05:00:00
update
	permanencyplan
set
	establisheddate = '2021-11-30 05:00:00',
	updatedon = now(),
	updatedby = 'CDM-30002'
where
	permanencyplanid in ('cd2f8901-8830-452a-9ca7-bb0b6c35c17c',
	'9b2d62a2-5e4c-48e9-8aee-69fee2b7aa2d',
	'5eef81d7-a2a3-4a2a-8de2-335cb9151bc3',
	'bbe83143-cde4-43da-b497-b9a30cc6a3b4');