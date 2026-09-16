/*   Issue Description: CDM-25755   */

update 	cjams.routing 
set 	activeflag =0,
		updatedby = 'CDM-25755', 
		updatedon =now() 
where  	routingid = '8fae0e7a-bb71-4da8-bb37-422816c6474a';


