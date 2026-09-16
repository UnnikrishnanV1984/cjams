/*	
	Issue Description: CDM-41988
   Category/ Module  : Missing payments
   Root cause: Missing payment for the following months in foster care:May 20-May 31June 1-June 30July1-July 31August1 -August 9.
   All placements were validated however, no payments were issued. Placement structure was changed from regular foster care to pre-finalize on May 21. 
   The provider is: Reine Marcelin. The child is: Angel Elvir Cruz. The adoption was finalized on august 9, 2024. 
   Pull request# for datafix: 6028
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

/*
select ratestructureid,alternateid,* from placement where placementid = '8cd6e030-7d3e-4549-af0c-a99a48cf1c3d'; -- alt.ID: 1889887;
SELECT service_nm,* FROM tb_Services WHERE tb_Services.service_id in (11709,10) 
select update_ts,update_user_id,* from tb_placement_validation where placement_id = 1889887 and delete_sw = 'N';
-- alt.ID == placement_id
*/

update placement
set ratestructureid = 10,
updatedby = 'CDM-41988',
updatedon = now()
where placementid = '8cd6e030-7d3e-4549-af0c-a99a48cf1c3d';


update tb_placement_validation
set update_ts = now(),
update_user_id = 'CDM-41988'
where placement_id = 1889887 and delete_sw = 'N';