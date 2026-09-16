-- DROP FUNCTION cjams.sp_interfaces_status_monitoring(in date, out text, out int4, out varchar);

CREATE OR REPLACE FUNCTION cjams.sp_interfaces_status_monitoring(adt_date date, OUT as_email_mess text, OUT al_out_sqlcode integer, OUT as_out_mess character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 11/08/2023

-- CJAMS CW - Daily Interfaces Status Monitoring (CIDM-8124)

-- Revision(s)
-- 11/16/2023 - Modifications to fix the CJAMS - E&E Outbound and Inbound logic (CIDM-8124_R1)
--				To Capture Summary of Interfaces Status Monitoring	(CIDM-8124_R2)
-- 11/20/2023 - Modifications to the query of Monday morning Summary of Interfaces Status Monitoring (CIDM-8124_R3)
-- 05/24/2024 - Agathya - Modified to capture message specific to CJAMS to ENE Outbound file generation failed. (CIDM-8906)
------------------------------------------------------------------------
Declare sqlcode int default 0;

Declare vl_sqlcode integer default 0;
Declare vs_mess character varying default 'Success';

Declare vs_ref_key character varying;
Declare vs_value_text character varying;
Declare vs_batch_no character varying;
Declare vs_value_temp_text character varying;

Declare vl_displayorder integer;

Declare vl_data_count integer;
Declare vs_interface_status character varying;
Declare vs_weekend_email_mess character varying;

cur_intr_refvalues_record record;
cur_intr_refvalues_REFCURSOR REFCURSOR;
	
BEGIN
	if adt_date is NULL then
		adt_date := current_date;
	end if;
	
	
	-- Initial Value
	as_email_mess := '';
	
	-- RAISE NOTICE 'Daily Interfaces Status Monitoring - Start';
	
	OPEN cur_intr_refvalues_REFCURSOR FOR
		select ref_key, 
			value_text,
			displayorder	
		from referencevalues 
		where referencetypeid = 591 
			and activeflag = 1
			and ref_key <> 'INTSUM'
		order by displayorder 
		;  
	loop
	fetch cur_intr_refvalues_REFCURSOR into cur_intr_refvalues_record;
		exit when not found;

		-- Reset
		vs_ref_key := NULL;
		vs_value_text := NULL;
		vl_displayorder := NULL;
		vl_data_count := NULL;
		vs_batch_no := NULL;
		vs_interface_status := NULL;
		
		vs_ref_key := cur_intr_refvalues_record.ref_key;
		vs_value_text := cur_intr_refvalues_record.value_text;
		vl_displayorder := cur_intr_refvalues_record.displayorder;
			
		-- CJAMS To CSMS - New referral Success	
		if vs_ref_key = 'NSCSMS' then	
			
			select count(*) 
				into vl_data_count 
			from ivecsesoutbounddata
			where insertedon between (adt_date::date - 1 || ' ' || '06:00:00 AM')::timestamp
				and (adt_date::date || ' ' || '06:00:00 AM')::timestamp
				and csmsreferralid is not null
				and (outputjson ->> 'message')::character varying = 'Successfully Created Referral'
			;
			
			vl_data_count := COALESCE(vl_data_count, 0);
			
			vs_value_text := replace(vs_value_text, '<??>', vl_data_count::character varying);
			
		-- CJAMS's new referral requests failed to interface with CSMS			
		elseif vs_ref_key = 'NFCSMS' then	
			
			select count(*)
				into vl_data_count 
			from ivecsesoutbounddata
			where insertedon between (adt_date::date - 1 || ' ' || '06:00:00 AM')::timestamp
						and (adt_date::date || ' ' || '06:00:00 AM')::timestamp
				and (inputjson ->> 'ivdRecordType')::character varying = 'NAPP'
				and csmsfailureflag = true
				and activeflag = 1
			;

			vl_data_count := COALESCE(vl_data_count, 0);
			
			vs_value_text := replace(vs_value_text, '<??>', vl_data_count::character varying);
			
		-- CJAMS has sent the Updated referral requests successfully for <??> clients to CSMS.
		elseif vs_ref_key = 'USCSMS' then
			
			select count(*)
				into vl_data_count 
			from ivecsesoutbounddata
			where insertedon between (adt_date::date - 1 || ' ' || '06:00:00 AM')::timestamp
						and (adt_date::date || ' ' || '06:00:00 AM')::timestamp
				-- and csmsreferralid is not null
				and (outputjson ->> 'message')::character varying = 'Updated Referral Successfully'
			;
			
			vl_data_count := COALESCE(vl_data_count, 0);
			
			vs_value_text := replace(vs_value_text, '<??>', vl_data_count::character varying);
			
		-- <??> CJAMS's updated referral requests failed to interface with CSMS.
		elseif vs_ref_key = 'UFCSMS' then
		
			select count(*) 
				into vl_data_count 
			from ivecsesoutbounddata
			where insertedon between (adt_date::date - 1 || ' ' || '06:00:00 AM')::timestamp
						and (adt_date::date || ' ' || '06:00:00 AM')::timestamp
				and (inputjson ->> 'ivdRecordType')::character varying in ('UPDT','UPDT-E','UPDT-P')
				and csmsfailureflag = true
				and activeflag = 1 
			;
			
			vl_data_count := COALESCE(vl_data_count, 0);
			
			vs_value_text := replace(vs_value_text, '<??>', vl_data_count::character varying);
			
		-- CJAMS Outbound Batch # <?>, CJAMS has sent the data for <??> clients to E&E.
		elseif vs_ref_key = 'OBENE' then
			
			if adt_date::date = current_date then
				
				if EXTRACT(isodow from date (now()::date))::integer between 2 and 6 then
					/*
					vs_value_text := NULL;
					
					select (case when successful_sw = 'P' and runstatus = 'P' then
								'CJAMS is waiting on the response for outbound batch # '||  batchnumber || ' from ENE.'
							end) 
						into vs_value_text	
					from cjams.interfacesruntimeslog
					where interfaceid = 'ENE_OUTBOUND'
					order by currentruntimestamp desc
					limit 1 ;
				
					IF vs_value_text is null then 
					*/
						select distinct batch_seq_no 
							into vs_batch_no 
						from eneoutboundinterface 
						where batch_run_ts::date = now()::date - 1 ; 
						
						if vs_batch_no is not null then
							select count(distinct cis_client_id) 
								into vl_data_count
							from eneoutboundinterface 
							where batch_run_ts::date = now()::date - 1; 
							
							vl_data_count := COALESCE(vl_data_count, 0);
							
							vs_value_text := replace(vs_value_text, '<?>', vs_batch_no::character varying);
							vs_value_text := replace(vs_value_text, '<??>', vl_data_count::character varying);
														
						else
							vl_data_count = -1;
							vs_value_text := 'CJAMS has NOT sent any outbound batch to ENE.'; 
						end if;
						
					-- end if;	
				else
					vl_data_count = -1;
					vs_value_text := 'CJAMS To E&E Outbound batch is scheduled to run on Monday to Friday only.';
				end if;
			else
				vl_data_count = -1;
				vs_value_text := 'Input date is NOT current date for CJAMS To E&E Outbound batch.'; 
			end if;	
			
		-- E&E Interim Batch # <?>, E&E has sent the data for <??> clients to CJAMS.
		elseif vs_ref_key = 'IBENE' then
		
			if adt_date::date = current_date then
			
				if EXTRACT(isodow from date (now()::date))::integer between 2 and 6 then
				
					vs_value_temp_text:= NULL;
					
					select (case when bl.comments_tx is not null and btrim(bl.comments_tx) <> '' 
								and btrim(bl.comments_tx) <> 'E&E Inbound Job COMPLETED SUCCESSFULLY' then
									btrim(bl.comments_tx)
							end) 
						into vs_value_temp_text
					from tb_batch_log bl,
							tb_batch_master bm
					where bl.batch_master_id = bm.batch_master_id
						and BL.start_ts::date = now()::date 
						and bm.batch_master_id = 67 ;
				
					If vs_value_temp_text is NULL then 
						if ( select count(*)
								from eneinboundtxt a
							 where a.insertedon::date = now()::date 
							) = 0 then 
							vl_data_count = -1;
							vs_value_text := 'E&E Inbound File does not exist.'; 
							
						else		 
							if ( select count(*)
									from(select distinct (substring(a.text,4,22)) as ts,
											substring(a.text,30,5) as bno
										from eneinboundtxt a
										where a.insertedon::date = now()::date 
										) as tab1
									where tab1.bno like '5%'
								) = 0 then 
								vl_data_count = -1;
								vs_value_text := 'E&E did not send the Interim Batch to CJAMS.';
							else
								if (select count(*)
									from(select distinct (substring(a.text,4,22)) as ts,
											substring(a.text,30,5) as bno
										from eneinboundtxt a
										where a.insertedon::date = now()::date 
										) as tab1
									where tab1.bno like '5%'
									) > 0 then
									
										select tab1.bno 
											into vs_batch_no 
										from ( select distinct (substring(a.text,4,22)) as ts,
													substring(a.text,30,5) as bno
											   from eneinboundtxt a
											   where a.insertedon::date = now()::date 
											  ) as tab1
										where tab1.bno like '5%' ;	
											
										select count(distinct cis_client_id)
											into vl_data_count
										from (
										select substring(b.text,30,5) as bno,
												substring(b.text,51,2) as record_type,
												substring(b.text,42,9) as cis_client_id
										from eneinboundtxt b
										where substring(b.text,30,5) like '5%'
											and substring(b.text,51,2) <> 'HE'
											and substring(b.text,51,2) is not null
											-- and substring(b.text,51,2) <> '02'
											and substring(b.text,51,2) <> ''
											and b.insertedon::date = now()::date 	
										order by b.old_id::integer
										) a ;
										
										vs_value_text := replace(vs_value_text, '<?>', vs_batch_no::character varying);
										vs_value_text := replace(vs_value_text, '<??>', vl_data_count::character varying);
								else	
									vl_data_count = -1;								
									vs_value_text := 'E&E has NOT sent any inbound batch to ENE.'; 
								end if;
							end if;
						end if;	
					else
						vs_value_text := vs_value_temp_text ;
						vl_data_count = -1;	
					end if;
				else
					vl_data_count = -1;
					vs_value_text := 'E&E To CJAMS Inbound batch is scheduled to run on Monday to Friday only.';
				end if;
			else
				vl_data_count = -1;
				vs_value_text := 'Input date is NOT current date for E&E To CJAMS Inbound batch.'; 
			end if;		
			
		-- E&E has sent the success response for CJAMS Outbound Batch # <?>
		elseif vs_ref_key = 'OBRENE' then
			
			vl_data_count := -1;
			vs_batch_no := NULL;
			
			if adt_date::date = current_date then
				if EXTRACT(isodow from date (now()::date))::integer between 2 and 6 then
					
					if ( select count(*)
							from cjams.tb_batch_log
						where batch_master_id = 69 
							and run_dt = now()::date
							and comments_tx like '%E&E Reject File exists%' 
						) > 0 then	
					
						select distinct 'CJAMS Outbound Batch # ' || batch_seq_no || ' was rejected by the E&E.'
							into vs_value_text
						from eneoutboundinterface ;
								
					else
					
						vs_value_text := NULL ;
					
						select (case when successful_sw = 'P' and runstatus = 'P' then
									'CJAMS is waiting on the response for outbound batch # '
									||  (case when length(batchnumber::character varying) < 5 then
											lpad((batchnumber::character varying), 5,'0')
										else	
											batchnumber::character varying
										end )
									|| ' from ENE.'
								end) 
							into vs_value_text	
						from cjams.interfacesruntimeslog
						where interfaceid = 'ENE_OUTBOUND'
						order by currentruntimestamp desc
						limit 1 ;
					
						IF vs_value_text is null then 
							if ( select count(*)
									from cjams.tb_batch_log
								where batch_master_id = 69 
									and run_dt = now()::date
								) > 0 then	
								
									-- Start - Changes by Agathya to change the message when the outbound file generation failed in CJAMS. 
									if batch_seq_no is null or btrim(batch_seq_no) ='' then 
									vs_value_text := 'CJAMS has NOT sent any outbound batch to ENE.';
									else
									-- End
									select distinct 'E&E has sent the success response for CJAMS Outbound Batch # ' || batch_seq_no 
										into vs_value_text
									from eneoutboundinterface ;
									end if ; -- add - Changes by Agathya to change the message when the outbound file generation failed in CJAMS. 
							else
								vs_value_text := NULL; -- for not to capture				
							end if;	
						else
							vl_data_count = -1;		
						end if;	
					end if;	
				else
					vl_data_count := -1;
					vs_value_text := 'E&E To CJAMS Inbound batch is scheduled to run on Monday to Friday only.';
				end if;
			else
				vl_data_count = -1;
				vs_value_text := 'Input date is NOT current date for E&E To CJAMS Inbound batch success response check.'; 
			end if;	
			
		-- CJAMS has sent the data for <??> Out-of-Home clients to Citizens Review Board for Children (CRBC).
		elseif vs_ref_key = 'OBCRB' then
		
			select count(*) 
				into vl_data_count 
			from interfacecrboutbound
			where create_ts::date = adt_date::date ;
			
			-- Look into 
			if vl_data_count = 0 then
				select count(*) 
					into vl_data_count 
				from cjams.interfacecrboutboundiss
				where create_ts::date = adt_date::date ;
			end if;	
			
			vl_data_count := COALESCE(vl_data_count, 0);	
			
			vs_value_text := replace(vs_value_text, '<??>', vl_data_count::character varying);
		end if;	
		
		/*
		If vl_data_count >= 0 then 
			if vs_batch_no is not null then 
				-- RAISE NOTICE 'vs_value_text 1 % ', vs_value_text;
				vs_value_text := replace(vs_value_text, '<?>', vs_batch_no);
				-- RAISE NOTICE 'vs_value_text 2 % ', vs_value_text;
				vs_value_text := replace(vs_value_text, '<??>', vl_data_count::character varying);
				-- RAISE NOTICE 'vs_value_text 3 % ', vs_value_text;
			else
				vs_value_text := replace(vs_value_text, '<??>', vl_data_count::character varying);
			end if;
		end if ;
		*/
		
		vs_interface_status := vs_value_text;
			
		if vs_interface_status is not null then
			INSERT INTO cjams.interfacestatusmonitoring
				(	run_date, interface_ref_key, interface_status_text, interface_data_count, 
					displayorder, insertedby, insertedon, updatedby, updatedon, activeflag
				)
			VALUES
				(	adt_date::date, vs_ref_key, vs_interface_status, vl_data_count, 
					vl_displayorder, 'cjams_batch_user', now(), 'cjams_batch_user', now(), 1
				);

			vl_sqlcode := SQLCODE;
			if vl_sqlcode < 0 then
				vs_mess := 'Error in capturing the data for # ' || vs_ref_key;
				-- vl_sqlcode := -1;
				ROLLBACK;
				exit;
			else
				vl_sqlcode := 0;
			end if ;
			
			If as_email_mess = '' then
				as_email_mess :=  vs_interface_status ;
			else
				as_email_mess :=  as_email_mess || chr(10) || vs_interface_status ;
			end if;	
		end if; 
		
	END LOOP;	
	
	close cur_intr_refvalues_REFCURSOR;
		
	-- Capture Summary 
	if EXTRACT(isodow from date (now()::date))::integer = 1 then
		select STRING_AGG(tab.interface_status_text, chr(10))
		from (
			(select 'CJAMS has sent the new referral requests successfully for ' ||	
				sum(coalesce(interface_data_count, '0')::bigint) || ' clients to CSMS.'  as interface_status_text
				from cjams.interfacestatusmonitoring
			where run_date::date between current_date - 2 and current_date 
				and activeflag  = 1
				and interface_ref_key = 'NSCSMS'
			union all
			select sum(coalesce(interface_data_count, '0')::bigint) || 
					'  CJAMS''s new referral requests failed to interface with CSMS.'
				from cjams.interfacestatusmonitoring
			where run_date::date between current_date - 2 and current_date 
				and activeflag  = 1
				and interface_ref_key = 'NFCSMS'
			union all
			select 'CJAMS has sent the Updated referral requests successfully for ' ||
				sum(coalesce(interface_data_count, '0')::bigint) || ' clients to CSMS.'
				from cjams.interfacestatusmonitoring
			where run_date::date between current_date - 2 and current_date 
				and activeflag  = 1
				and interface_ref_key = 'USCSMS'
			union all
			select sum(coalesce(interface_data_count, '0')::bigint) || 
					' CJAMS''s updated referral requests failed to interface with CSMS.'
				from cjams.interfacestatusmonitoring
			where run_date::date between current_date - 2 and current_date 
				and activeflag  = 1
				and interface_ref_key = 'UFCSMS'
			union all 
			select interface_status_text
				from cjams.interfacestatusmonitoring
			where run_date::date = current_date - 2 
				and activeflag  = 1
				and interface_ref_key = 'OBENE'
			union all
			select interface_status_text
				from cjams.interfacestatusmonitoring
			where run_date::date = current_date - 2 
				and activeflag  = 1
				and interface_ref_key = 'IBENE'
			union all
			select (case when comments_tx like '%E&E Reject File exists%' then
							(select distinct 'CJAMS Outbound Batch # ' || batch_seq_no from eneoutboundinterface)
									|| ' was rejected by the E&E.'
					else
							'E&E has sent the success response for ' ||
							(select distinct 'CJAMS Outbound Batch # ' || batch_seq_no from eneoutboundinterface)
					end ) as ENE_TO_CJAMS
			from cjams.tb_batch_log
			where run_dt = current_date - interval '2 days'
			and batch_master_id  = 69
			union all 
			select 'CJAMS has sent the data for ' || sum(coalesce(interface_data_count, '0')::bigint) 
					|| ' Out-of-Home clients to Citizens Review Board for Children (CRBC).'
				from cjams.interfacestatusmonitoring
			where run_date::date between current_date - 2 and current_date 
				and activeflag  = 1
				and interface_ref_key = 'OBCRB'
				)
		) tab
		into vs_weekend_email_mess ;
		
		INSERT INTO cjams.interfacestatusmonitoring
			(	run_date, interface_ref_key, interface_status_text, interface_data_count, 
				displayorder, insertedby, insertedon, updatedby, updatedon, activeflag
			)
		VALUES
			(	adt_date::date, 'INTSUM', vs_weekend_email_mess, 'N/A', 
				vl_displayorder, 'cjams_batch_user', now(), 'cjams_batch_user', now(), 1
			);	
	else
	
		INSERT INTO cjams.interfacestatusmonitoring
			(	run_date, interface_ref_key, interface_status_text, interface_data_count, 
				displayorder, insertedby, insertedon, updatedby, updatedon, activeflag
			)
		VALUES
			(	adt_date::date, 'INTSUM', as_email_mess, 'N/A', 
				vl_displayorder, 'cjams_batch_user', now(), 'cjams_batch_user', now(), 1
			);	
	end if;		
	-- RAISE NOTICE 'Daily Interfaces Status Monitoring - End';
	
	al_out_sqlcode := vl_sqlcode;
	as_out_mess := vs_mess;
	
END;

$function$
;
