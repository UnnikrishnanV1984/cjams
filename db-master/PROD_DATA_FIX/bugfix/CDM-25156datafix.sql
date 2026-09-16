/* CDM-25156 :Not our case */

update  cjams.routing
set 	fromsecurityusersid = '50714e61-37fc-4274-a3e4-88313c081498',
		tosecurityusersid = 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f',
		teamid = 'f367fc82-9044-4f74-a40e-6d96db9e8625',
		updatedby = 'CDM-25156', 
		updatedon =now() 
where objectid = '14562bec-6cff-4eac-bc31-255ccf094117' and routingid = '4c6cddf1-a030-40a0-8854-ecc8396727c5';
