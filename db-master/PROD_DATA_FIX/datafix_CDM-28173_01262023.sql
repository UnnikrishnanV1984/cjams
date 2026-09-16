-- Changing Approved By Requested By 
--  Tellsha Harris to Megan Turner
-- Deborah DiEdoardo to Kathleen Chaney

select * from routing where objectid = 'd78ed920-e67b-4fbe-949e-764d6cb499e2' and fromsecurityusersid = 'e7bb6e8c-a164-41c3-8e81-89d5f8cd2b34'
and tosecurityusersid = 'e87cf311-d853-4c5e-b3c5-d62c896f45b9';

update routing set fromsecurityusersid = '73999176-0c94-4d08-9ef2-0efe966ce506',tosecurityusersid = 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f',
updatedby = 'CDM-28173', updatedon = now() where objectid = 'd78ed920-e67b-4fbe-949e-764d6cb499e2' and fromsecurityusersid = 'e7bb6e8c-a164-41c3-8e81-89d5f8cd2b34' 
and tosecurityusersid = 'e87cf311-d853-4c5e-b3c5-d62c896f45b9';


select * from routing where objectid = 'd78ed920-e67b-4fbe-949e-764d6cb499e2' and fromsecurityusersid = 'e87cf311-d853-4c5e-b3c5-d62c896f45b9' and 
tosecurityusersid = 'e7bb6e8c-a164-41c3-8e81-89d5f8cd2b34';

update routing set fromsecurityusersid = 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f',tosecurityusersid = '73999176-0c94-4d08-9ef2-0efe966ce506',
updatedby = 'CDM-28173', updatedon = now() where objectid = 'd78ed920-e67b-4fbe-949e-764d6cb499e2' and fromsecurityusersid = 'e87cf311-d853-4c5e-b3c5-d62c896f45b9' 
and tosecurityusersid = 'e7bb6e8c-a164-41c3-8e81-89d5f8cd2b34';
