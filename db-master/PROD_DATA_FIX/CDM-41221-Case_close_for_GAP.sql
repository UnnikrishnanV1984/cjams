
/*
   Issue Description: CDM-41221
   Category/ Module  : Removing Duplicate ProgramArea from case and remove child history specific record
   Root cause: :Case was close for GAP for Eli Briscoe, Edward Briscoe and Malaya Payne on 04/26/2024, but it contiunes to be seen in chid removal tab
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
select cjamspid,* from person where cjamspid in ('3555640','3554824','200137654')--7177e6e3-27be-4984-bcf6-89657fe5a95b,2b915e77-9dd2-446f-983b-533a075a19d6
select personid,* from intakeservreqchildremoval where personid in ('7177e6e3-27be-4984-bcf6-89657fe5a95b','2b915e77-9dd2-446f-983b-533a075a19d6','9f7c8f6a-77ee-4448-a7e9-3668179383e1')
and servicecaseid = '2570a817-725f-4e13-94a9-000b8f5ed783' and activeflag = 0;
*/


/*
select cjamspid,* from person where cjamspid in ('3555640','3554824','200137654')--7177e6e3-27be-4984-bcf6-89657fe5a95b,2b915e77-9dd2-446f-983b-533a075a19d6
select personid,* from intakeservreqchildremoval where personid in ('7177e6e3-27be-4984-bcf6-89657fe5a95b','2b915e77-9dd2-446f-983b-533a075a19d6','9f7c8f6a-77ee-4448-a7e9-3668179383e1')
and servicecaseid = '2570a817-725f-4e13-94a9-000b8f5ed783' and activeflag = 1;
*/


UPDATE intakeservreqchildremoval 
SET updatedby = 'CDM-41221', 
	updatedon = now(), 
	activeflag = 0
WHERE intakeservreqchildremovalid 
	in ('3b305e68-0a8d-4eff-87c1-72b10a84462c',
	 'f3a2a323-a0ef-4905-8237-58bbde8094f5',
	 '5b949f9a-ac37-4b58-8aaa-84bb7d8fcfa6')
and servicecaseid = '2570a817-725f-4e13-94a9-000b8f5ed783'
and activeflag = 1;


/*
select * from cjams.intakeservreqchildremoval_history
where intakeservreqchildremovalid 
	in ('3b305e68-0a8d-4eff-87c1-72b10a84462c',
	 'f3a2a323-a0ef-4905-8237-58bbde8094f5',
	 '5b949f9a-ac37-4b58-8aaa-84bb7d8fcfa6')
and servicecaseid = '2570a817-725f-4e13-94a9-000b8f5ed783'
and activeflag = 1;
*/


UPDATE cjams.intakeservreqchildremoval_history 
SET updatedby = 'CDM-41221', 
	updatedon = now(), 
	activeflag = 0
WHERE intakeservreqchildremovalid 
	in ('3b305e68-0a8d-4eff-87c1-72b10a84462c',
	 'f3a2a323-a0ef-4905-8237-58bbde8094f5',
	 '5b949f9a-ac37-4b58-8aaa-84bb7d8fcfa6')
and servicecaseid = '2570a817-725f-4e13-94a9-000b8f5ed783'
and activeflag = 1;

--select objectid,* from routing 
--where objectid in  ('3b305e68-0a8d-4eff-87c1-72b10a84462c',
--	 'f3a2a323-a0ef-4905-8237-58bbde8094f5',
--	 '5b949f9a-ac37-4b58-8aaa-84bb7d8fcfa6')
--and activeflag = 1;

UPDATE routing 
SET updatedby = 'CDM-41221', 
	updatedon = now(), 
	activeflag = 0
where objectid in  ('3b305e68-0a8d-4eff-87c1-72b10a84462c',
	 'f3a2a323-a0ef-4905-8237-58bbde8094f5',
	 '5b949f9a-ac37-4b58-8aaa-84bb7d8fcfa6')
and activeflag = 1;


/*
select * from tb_client_eligibility where removal_id  in (253034, 194616,194617)
*/

update tb_client_eligibility 
set delete_sw = 'Y', 
	update_ts = now(), 
	update_user_id = 'CDM-41221' 
where removal_id in (253034, 194616,194617) --200137654, 3555640,3554824
	and delete_sw = 'N' ;	


----- removing OOH record as requested
/*
select * from personprogramarea where personprogramid in ('02b25d65-bf89-43f9-87d7-b65f5c1c34ca','73c5f617-b161-448a-a296-8c046f31d675') and activeflag = 1;
*/

update personprogramarea
SET updatedby = 'CDM-41221', 
	updatedon = now(), 
	activeflag = 0
where personprogramid in ('02b25d65-bf89-43f9-87d7-b65f5c1c34ca','73c5f617-b161-448a-a296-8c046f31d675')
and activeflag = 1;

--- REMOVE SUPENSION 
/*
select * from gapsuspension g  where gapsuspensionid in ('09fe788e-b2cb-42e0-aa6c-c06e843a635c','70c5fc40-fc56-46bf-99e8-cdcb902e11a6')--"EDWARD BRISCOE","ELI BRISCOE"
*/

update gapsuspension
set activeflag = 0,
	updatedby = 'CDM-41221', 
	updatedon = now() 
where gapsuspensionid in ('09fe788e-b2cb-42e0-aa6c-c06e843a635c','70c5fc40-fc56-46bf-99e8-cdcb902e11a6')
	and activeflag = 1 ;	

/*
select * from gapsuspensionrevision g where suspensionid in ('09fe788e-b2cb-42e0-aa6c-c06e843a635c','70c5fc40-fc56-46bf-99e8-cdcb902e11a6')
*/
update gapsuspensionrevision
set activeflag = 0,
	updatedby = 'CDM-41221', 
	updatedon = now() 
where suspensionid in ('09fe788e-b2cb-42e0-aa6c-c06e843a635c','70c5fc40-fc56-46bf-99e8-cdcb902e11a6')
	and activeflag = 1 ;

/*
select * from routing r  where objectid in ('09fe788e-b2cb-42e0-aa6c-c06e843a635c','70c5fc40-fc56-46bf-99e8-cdcb902e11a6')
*/
update routing
set activeflag = 0,
	updatedby = 'CDM-41221', 
	updatedon = now() 
where objectid in ('09fe788e-b2cb-42e0-aa6c-c06e843a635c','70c5fc40-fc56-46bf-99e8-cdcb902e11a6')
	and eventcode = 'GASR'
	and activeflag = 1 ;
	

-- 4. Remove the provider Account Receivable (overpayment) records - balance will be zero
--    Provider ID: 6129182 (Kendra Baldwin) receivable_id: 1254660

/*
select receivable_detail_id,* from tb_receivable_detail where receivable_id = 1254660
-- client id 3555640 and 3554824
*/

update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-41221'
where delete_sw = 'N'
	and receivable_detail_id 
	in ( select receivable_detail_id
			from tb_receivable_detail
		 where receivable_id = 1254660
			and receivable_ts::date = '2024-08-08'::date
			and delete_sw = 'N'
		);
	
update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-41221'
where receivable_id = 1254660
	and receivable_ts::date = '2024-08-08'::date
	and delete_sw = 'N' ;
	

-- Update Provider AR Balances & Payment Plan
update tb_receivable_header rh
set balance_no 
		= coalesce(( select sum(rd.receivable_balance_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	receivable_original_amount_no 
		= coalesce(( select sum(rd.amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),					  
	written_off_amount_no
		= coalesce(( select sum(rd.written_off_amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	update_ts = now(),
	update_user_id = 'CDM-41221'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1254660 ;


-- 	Update Payment Plan
update tb_payment_plan pp
set current_receivable_amount 
		= coalesce(( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ),0),
    amount_no 
		= coalesce(((( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ) * pp.percentage_no ) / 100 ),0),
    update_ts = now(),
	update_user_id = 'CDM-41221'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1254660 ;


-- Delete AR  Ticker 
/*
select * from tb_receivable_header trh  where receivable_id = 1254660
select * from tb_ticklers tt where entity_key_id  =6129182;-- 3555640,3554824 providerID is the entity_key_id
*/

update tb_ticklers 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-41221'
where tickler_id in (30166077,30166078) -- two client id 3555640 and 3554824
	and delete_sw  = 'N' ;	