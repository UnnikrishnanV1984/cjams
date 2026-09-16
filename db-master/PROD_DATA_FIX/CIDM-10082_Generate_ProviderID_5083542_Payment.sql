/*  
Description: This ticket is creating for generating the provider payment for the correct provider after the data fix for ticket CDM-43552 is completed and validated in stg3.
Case ID: 3265611
Client ID: 4195652 (AALIYAH BROWN)
Provider ID: 5083542 (Katherine Dorsey)
Service Period: Aug 2024 to Nov 2024

Trigger under over for rate slabs:
e15e591c-88a8-468b-a502-0ee443514026 2024-08-14 2025-08-13
24042f2d-6961-48bd-88e6-aff70153a190 2023-08-14 2024-08-13

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Data issue, the payment has been created under the incorrect provider ID.
-- Fix Provided: Datafix has been promoted to create an AR for the incorrect provider (Lakeesha King / ID# 5055574) from August to November 2024 service period
Also, Trigger under over for rate slabs
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
/*
select gaprateid,ratestartdate, rateenddate, approvaldate,approvalstatustypekey,  updatedby, updatedon,*
	from cjams.gapratesrevision
where gaprateid  in('e15e591c-88a8-468b-a502-0ee443514026','24042f2d-6961-48bd-88e6-aff70153a190') 
	and approvalstatustypekey = '3047'
	and activeflag  = 1;

*/

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CIDM-10082',
	updatedon = now()
where gaprateid  in('e15e591c-88a8-468b-a502-0ee443514026','24042f2d-6961-48bd-88e6-aff70153a190') 
	and approvalstatustypekey = '3047'
	and activeflag  = 1;
	
/*
for validation call both of these SP one by one
select * from cjams.sp_under_over_pub(current_date);
select * from cjams.sp_afs_interfaces();
*/
