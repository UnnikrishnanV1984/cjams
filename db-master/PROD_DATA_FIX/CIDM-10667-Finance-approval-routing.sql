/*
   Issue Description: CIDM-10667 Finanace approval routing
   We are trying to complete a final disbursement and one of the supervisors is missing from the approval path. 
   Shannon Chapman is not showing and it takes 3 people to complete a final disbursement. 
   A worker to initiate the final disbursement, a supervisor to complete the fund approval, and a second supervisor to complete the payment approval.
   Without Shannon Chapman as an option, we do not have enough people to complete the approval without overlapping roles. 
   Holly Truitt can switch to a worker level to initiate, but once Dave Beach does the funding approval, the system then only gives Holly Truitt as the approval for the payment side.
   There is no option for Shannon Chapman for either the funding or the payment approval. 
   Category/ Module  : Final disbursement
   Root cause: User not showing for the final disbursement 
   Fix Provided: Data fix to update the updated by user with correct user.
*/

update routing 
set tosecurityusersid = 'b7a94e0e-9f27-42ed-ac60-c0da8f3e3035',--b135541a-a02d-4a0a-8693-0055a58cc729
	updatedby = 'CIDM-10667',
	updatedon = now()
where routingid = 'beaa78fc-6cd6-48bf-91e6-27074f9d6f2d' 
	and objectid = '1046816'
	and activeflag =1;

update teammember 
set roletypekey = 'FNSFS',--CWSP
	updatedby = 'CIDM-10667',
	updatedon = now()
where teammemberid = '91311397-1699-4f74-a81b-0017ee81dd49' 
	and activeflag =1;

--select roletypekey ,* from teammember t  where teammemberid = '91311397-1699-4f74-a81b-0017ee81dd49'; -- updated to FNSFS so i can see the user in assign tab

update rolemapping 
set roleid = 1053, --36: CWSP
	updatedby = 'CIDM-10667',
	updatedon = now()
where principalid = '51854' and activeflag =1 and id = 170089007;

--additional CWSP role into userresource
INSERT INTO cjams.userresource
( userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES( 51854, 'fdc2849c-0a29-4b38-98eb-b08a461e883e'::uuid, 36, NULL, 1, 'CIDM-10667', now(), 'CIDM-10667', now(), true, true, true, NULL);

update userresource 
set activeflag = 0,
	updatedby = 'CIDM-10667',
	updatedon = now()
where userresourceid in ('233e218e-f6e7-4fe1-aa91-2923949be12a',
'9f29ddda-d7d4-463e-a252-4a1e347e6feb') and activeflag =1;

/*
permissiongroup:
2a2f16c1-3c3d-48cb-93ac-fb60956fa42a	1053
58888e9a-ad62-4a91-a92e-f6de0ed08936	1053
*/