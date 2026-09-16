--CDM-36955--Review cases showing on Dashboard already
/* Issue Description:Dashboard that were already reviewed and approved. 
                     Can they be removed from my Review tab? 
                     MacKenzie Benner ID 4439124-Review ACA request 2/23/22. 
                     Already approved ACA in IV-E CJAMS case on 2/23/22 and opened in 
                     Adoption case.
                     Mariah Bickling ID 1710685-Review for FC Redet requested 1/4/21.
                     All Redets are already showing approved in IV-E CJAMS case.
                     Gabriella Brasure ID 200984742-Review for ACA request 11/7/23.
                    Already approved ACA in IV-E CJAMS case on 1/8/24 and opened in Adoption case.

-- Customer Email ID:shelley.vitelli@maryland.gov
-- Category/ Module: Title IV-E  
-- Root cause: In Dashboard Approval review cases are still shown for client ID's 
               #4439124-Review ACA request 2/23/22 
               #1710685-Review for FC Redet requested 1/4/21
               #200984742--Review for ACA request 11/7/23 
               due as pending record in routing table is still active.
-- Fix Provided: Datafix has been to soft delete approved IV-E record from pending Dashboard
-- Pull request# N/A

*/

select *from routing where objectid in ('95bfda4e-c7aa-4891-902b-49514eba3457',
                                        'f997522a-e44f-46d9-ab64-799db0144f02',
                                        '88aa38b8-2c70-42d0-b921-b30bca1ecf1d');


update routing
set activeflag=0 ,
	updatedon = now(),
	updatedby = 'CDM-36955' 
where objectid ='95bfda4e-c7aa-4891-902b-49514eba3457' and activeflag=1;    

update routing
set activeflag=0 ,
	updatedon = now(),
	updatedby = 'CDM-36955' 
where objectid ='f997522a-e44f-46d9-ab64-799db0144f02' and activeflag=1;   

update routing
set activeflag=0 ,
	updatedon = now(),
	updatedby = 'CDM-36955' 
where objectid ='88aa38b8-2c70-42d0-b921-b30bca1ecf1d' and activeflag=1;