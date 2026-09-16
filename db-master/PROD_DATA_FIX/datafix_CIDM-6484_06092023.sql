-- CIDM-6484 - Removals ended in application but in active in backend
/*
-- Issue Description: 
   Child Removal Data issues  

-- Service case # 3295728 - e91f9aee-0d9d-425d-8417-6e0bdd2406ef
-- Draft removal of Inactive Person, this was fixed with CIDM-6980

-- Service Case # 211030010647 - c153ee62-ad80-4038-89d6-3df879a41a5b
-- Active Child Removal with Inactive Person (200800745	Angela	seri)
 
-- Service Case # 2020013301213 - bb0a06c3-7d04-4f15-8832-6a1dc0d0732f
-- Removal of the duplicate person, fixed with CDM-28694

-- Service Case # 2020027403301 - 9c8f1173-21cc-4ce1-aa43-10f1d80b6ef4
-- Not an issue, person is no more havign Child role
 
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: Child Removal Data issues
-- Fix Provided: Datafix has been promoted to soft delete the Active Child Removals where the Person records are inactive.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to soft delete the Active Removals where the Person records are inactive (CIDM-6484)
/*
250323	a969cd70-b172-40fb-aa27-ea1c61e45d02	200003996	Madison		Francis-Wise	20200510987
8317	3fc5d909-f586-4f23-ba6a-7e81e99e074f	1115302	TONIQUE	CLARICE	GRAY	3031034
104962	b5f76a75-af64-4959-8c24-a1175fcdc947	1115302	TONIQUE	CLARICE	GRAY	3031034
100089	a4630255-0131-4b48-90ef-1da13294469c	1890654	BABY GRIL		WHITE	3147498
47818	a066488d-3014-42a5-9363-b6e20e3a744e	1376215	DANIELLE	L	BLANGO	3127403
49298	108f8ee6-66bf-4b3a-bc1f-8fb371b23c3e	1604945	WENDY		CARPENTER	3092667
89729	53557053-5938-4d31-8628-d1720208f225	1748879	NATALIE		GRIFFITHS	3106177
89730	89cbeb07-91e2-4759-9e24-67c00bf0f67e	1748879	NATALIE		GRIFFITHS	3106177
100622	7a113b18-4144-4063-8886-0736708e0bf3	1898388	OCTAVIA	DUPLICATE	LENEROS	3078125
252687	e5ad23cf-fe8b-4723-8674-d5a6acdf7eba	200800745	Angela		seri	211030010647
250832	4cc9f778-f4c9-4018-b865-57db5aaa6210	200145909	Txxxxxx	xxxxxx	Txxxxxx	
*/

select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where intakeservreqchildremovalid 
	in (	'a969cd70-b172-40fb-aa27-ea1c61e45d02',
			'3fc5d909-f586-4f23-ba6a-7e81e99e074f',
			'b5f76a75-af64-4959-8c24-a1175fcdc947',
			'a4630255-0131-4b48-90ef-1da13294469c',
			'a066488d-3014-42a5-9363-b6e20e3a744e',
			'108f8ee6-66bf-4b3a-bc1f-8fb371b23c3e',
			'53557053-5938-4d31-8628-d1720208f225',
			'89cbeb07-91e2-4759-9e24-67c00bf0f67e',
			'7a113b18-4144-4063-8886-0736708e0bf3',
			'e5ad23cf-fe8b-4723-8674-d5a6acdf7eba',
			'4cc9f778-f4c9-4018-b865-57db5aaa6210'
		)
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval
set activeflag = 0, 
	updatedby = 'CIDM-6484',
	updatedon = now()
where intakeservreqchildremovalid 
	in (	'a969cd70-b172-40fb-aa27-ea1c61e45d02',
			'3fc5d909-f586-4f23-ba6a-7e81e99e074f',
			'b5f76a75-af64-4959-8c24-a1175fcdc947',
			'a4630255-0131-4b48-90ef-1da13294469c',
			'a066488d-3014-42a5-9363-b6e20e3a744e',
			'108f8ee6-66bf-4b3a-bc1f-8fb371b23c3e',
			'53557053-5938-4d31-8628-d1720208f225',
			'89cbeb07-91e2-4759-9e24-67c00bf0f67e',
			'7a113b18-4144-4063-8886-0736708e0bf3',
			'e5ad23cf-fe8b-4723-8674-d5a6acdf7eba',
			'4cc9f778-f4c9-4018-b865-57db5aaa6210'
		)
	and activeflag = 1;
	
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval_history
where intakeservreqchildremovalid 
	in ( 
			'a969cd70-b172-40fb-aa27-ea1c61e45d02',
			'3fc5d909-f586-4f23-ba6a-7e81e99e074f',
			'b5f76a75-af64-4959-8c24-a1175fcdc947',
			'a4630255-0131-4b48-90ef-1da13294469c',
			'a066488d-3014-42a5-9363-b6e20e3a744e',
			'108f8ee6-66bf-4b3a-bc1f-8fb371b23c3e',
			'53557053-5938-4d31-8628-d1720208f225',
			'89cbeb07-91e2-4759-9e24-67c00bf0f67e',
			'7a113b18-4144-4063-8886-0736708e0bf3',
			'e5ad23cf-fe8b-4723-8674-d5a6acdf7eba',
			'4cc9f778-f4c9-4018-b865-57db5aaa6210'
		)
	and activeflag  = 1;

update cjams.intakeservreqchildremoval_history
set activeflag = 0, 
	updatedby = 'CIDM-6484',
	updatedon = now()
where intakeservreqchildremovalid 
	in (	'a969cd70-b172-40fb-aa27-ea1c61e45d02',
			'3fc5d909-f586-4f23-ba6a-7e81e99e074f',
			'b5f76a75-af64-4959-8c24-a1175fcdc947',
			'a4630255-0131-4b48-90ef-1da13294469c',
			'a066488d-3014-42a5-9363-b6e20e3a744e',
			'108f8ee6-66bf-4b3a-bc1f-8fb371b23c3e',
			'53557053-5938-4d31-8628-d1720208f225',
			'89cbeb07-91e2-4759-9e24-67c00bf0f67e',
			'7a113b18-4144-4063-8886-0736708e0bf3',
			'e5ad23cf-fe8b-4723-8674-d5a6acdf7eba',
			'4cc9f778-f4c9-4018-b865-57db5aaa6210'
		)
	and activeflag = 1;
	
select routingid, eventcode, routingstatustypeid,activeflag, updatedby, updatedon  
	from cjams.routing  
where objectid 
	in (	'a969cd70-b172-40fb-aa27-ea1c61e45d02',
			'3fc5d909-f586-4f23-ba6a-7e81e99e074f',
			'b5f76a75-af64-4959-8c24-a1175fcdc947',
			'a4630255-0131-4b48-90ef-1da13294469c',
			'a066488d-3014-42a5-9363-b6e20e3a744e',
			'108f8ee6-66bf-4b3a-bc1f-8fb371b23c3e',
			'53557053-5938-4d31-8628-d1720208f225',
			'89cbeb07-91e2-4759-9e24-67c00bf0f67e',
			'7a113b18-4144-4063-8886-0736708e0bf3',
			'e5ad23cf-fe8b-4723-8674-d5a6acdf7eba',
			'4cc9f778-f4c9-4018-b865-57db5aaa6210'
		)
	and activeflag = 1;

update cjams.routing
set activeflag = 0, 
	updatedby = 'CIDM-6484',
	updatedon = now()
where objectid 
	in (	'a969cd70-b172-40fb-aa27-ea1c61e45d02',
			'3fc5d909-f586-4f23-ba6a-7e81e99e074f',
			'b5f76a75-af64-4959-8c24-a1175fcdc947',
			'a4630255-0131-4b48-90ef-1da13294469c',
			'a066488d-3014-42a5-9363-b6e20e3a744e',
			'108f8ee6-66bf-4b3a-bc1f-8fb371b23c3e',
			'53557053-5938-4d31-8628-d1720208f225',
			'89cbeb07-91e2-4759-9e24-67c00bf0f67e',
			'7a113b18-4144-4063-8886-0736708e0bf3',
			'e5ad23cf-fe8b-4723-8674-d5a6acdf7eba',
			'4cc9f778-f4c9-4018-b865-57db5aaa6210'
		)
	and activeflag = 1;
	
	
-- IV-E
select eligibility_period_id, event_start_dt, event_end_dt,  delete_sw, update_user_id, update_ts  
	from cjams.tb_eligibility_events  
where eligibility_period_id  
	in ( select eligibility_period_id  
			from tb_eligibility_period 
		where eligibility_id  
			in ( select eligibility_id  
					from tb_client_eligibility 
				where removal_id in (250323, 8317, 104962, 100089, 47818, 49298, 89729, 89730, 100622, 252687, 250832)
					and delete_sw = 'N'
			   ) 
			and delete_sw  = 'N'
		)
	and delete_sw  = 'N';
	

update cjams.tb_eligibility_events
set delete_sw = 'Y',
	update_user_id = 'CIDM-6484',
	update_ts = now()
where eligibility_period_id  
	in ( select eligibility_period_id  
			from tb_eligibility_period 
		where eligibility_id  
			in ( select eligibility_id  
					from tb_client_eligibility 
				where removal_id in (250323, 8317, 104962, 100089, 47818, 49298, 89729, 89730, 100622, 252687, 250832)
					and delete_sw = 'N'
			   ) 
			and delete_sw  = 'N'
		)
	and delete_sw  = 'N';
	
select eligibility_id, start_dt, end_dt,  delete_sw, update_user_id, update_ts  
	from cjams.tb_eligibility_period 
where eligibility_id  
	in ( select eligibility_id  
			from tb_client_eligibility 
		 where removal_id in (250323, 8317, 104962, 100089, 47818, 49298, 89729, 89730, 100622, 252687, 250832)
			and delete_sw = 'N'
		)
	and delete_sw  = 'N';

update cjams.tb_eligibility_period
set delete_sw = 'Y',
	update_user_id = 'CIDM-6484',
	update_ts = now()
where eligibility_id  
	in ( select eligibility_id  
			from tb_client_eligibility 
		 where removal_id in (250323, 8317, 104962, 100089, 47818, 49298, 89729, 89730, 100622, 252687, 250832)
			and delete_sw = 'N'
		)
	and delete_sw  = 'N';

select eligibility_id, case_id, client_id, delete_sw, update_user_id, update_ts  
	from tb_client_eligibility 
where removal_id in (250323, 8317, 104962, 100089, 47818, 49298, 89729, 89730, 100622, 252687, 250832)
	and delete_sw = 'N';
	
update cjams.tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CIDM-6484',
	update_ts = now()
where removal_id in (250323, 8317, 104962, 100089, 47818, 49298, 89729, 89730, 100622, 252687, 250832)
	and delete_sw = 'N';
