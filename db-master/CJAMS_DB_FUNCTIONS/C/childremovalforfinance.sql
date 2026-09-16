Drop function if exists cjams.childremovalforfinance(uuid,uuid,character varying,character varying);

CREATE OR REPLACE FUNCTION cjams.childremovalforfinance(	childremovalid uuid, 
															v_securityuserid uuid, 
															status character varying, 
															v_servicecaseid character varying
														)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 09/12/2022 Vineet Tirodkar - To fix duplicate Client Eligibility for the same Removal ID Issue (CIDM-5517)
-- 04/25/2023 Vineet Tirodkar - To fix Child Removal and IV-E Dates Discrepancies (CIDM-6945) 
-- 09-28-2023 Veera - To fix the null start date in tb_client_eligibility
------------------------------------------------------------------------------------------------------------	
DECLARE 
	--v_fiscal_category_cd character;
    v_client_id int8;
   	v_case_id int8;
	v_eligibility_id int8;
   	v_count integer;
	v_startdate date;
	v_enddate date;
	v_removailid int8;
	v_tousersid RECORD;
	v_username character varying;
	v_msg character varying;
	v_notifystatus character varying; 
BEGIN 
	
	RAISE NOTICE 'childremovalid:%', childremovalid;
	RAISE NOTICE 'securityusersid:%', v_securityuserid;
	RAISE NOTICE 'status:%', status;
	RAISE NOTICE 'caseid:%', v_servicecaseid;
	
	select removalid 
		into v_removailid  
	from intakeservreqchildremoval 
	where intakeservreqchildremovalid = childremovalid 
		and activeflag = 1 
	limit 1;

	SELECT  
		(	select p.cjamspid 
			from person p 
				join intakeservicerequestactor isra on isra.personid = p.personid 
					and isra.intakeservicerequestactorid = isrcr.intakeservicerequestactorid 
					and isrcr.activeflag = 1 
					and isra.activeflag = 1 
			order by isra.insertedon desc 
			limit 1
		), 
 
		case when isrcr.servicecaseid is not null then --'yes' else 'no' end 
	 		(select servicecasenumber::int8 
				from servicecase 
			 where servicecaseid=isrcr.servicecaseid order by insertedon desc limit 1)
		else 
			(select CASE WHEN substring(servicerequestnumber,1,2) = 'CW' THEN 
						substring(servicerequestnumber,3) 
					ELSE 
						servicerequestnumber 
					END::int8 
             from intakeservicerequest  
			 where intakeserviceid = isrcr.intakeserviceid 
			 order by insertedon desc 
			 limit 1
			)
		 end,
		 isrcr.removaldate::date,
  		 isrcr.exitdate::Date   
	into 
		v_client_id,
		v_case_id,
		v_startdate,
		v_enddate
	FROM cjams.intakeservreqchildremoval isrcr 
	where isrcr.intakeservreqchildremovalid = childremovalid ;

	RAISE NOTICE 'v_client_id:%', v_client_id;
	RAISE NOTICE 'v_case_id:%', v_case_id;
	RAISE NOTICE 'v_startdate:%', v_startdate;
	RAISE NOTICE 'v_enddate:%', v_enddate;

	-- Get Removal Exit date from Revision table
	SELECT removaldate,
		exitdate
	INTO v_startdate,
		v_enddate 
	FROM intakeservreqchildremoval_history 
	WHERE intakeservreqchildremovalid = childremovalid
		and "rowtype" = 'REVISION' 
		and activeflag =  1 
	ORDER BY updatedon desc 
	LIMIT 1;
	
	if(v_startdate is null) then
	    RAISE NOTICE 'v_startdate 98:%', v_startdate;
		SELECT removaldate INTO v_startdate 
	    FROM intakeservreqchildremoval 
	    WHERE intakeservreqchildremovalid = childremovalid
		and activeflag =  1 ;
	end if;

	if(v_enddate is null) then
	    RAISE NOTICE 'v_enddate 106:%', v_enddate;
		SELECT exitdate INTO v_enddate 
	    FROM intakeservreqchildremoval 
	    WHERE intakeservreqchildremovalid = childremovalid
		and activeflag =  1 ;
	end if;
	
	RAISE NOTICE 'REVISION v_startdate:%', v_startdate;
	RAISE NOTICE 'REVISION v_enddate:%', v_enddate;
	
	select eligibility_id
		into v_eligibility_id
	from tb_client_eligibility 
	where removal_id = v_removailid
		and delete_sw = 'N'
	order by create_ts 
	limit 1 ;
		
	-- client_id::int8 = v_client_id::int8 
	-- and case_id::int8 = v_case_id::int8 

	RAISE NOTICE 'v_count:%', v_count;

	if(v_eligibility_id > 0) then
		
		RAISE NOTICE 'v_count inside update:%', v_count;
 	
		update cjams.tb_client_eligibility  
		set start_dt = v_startdate,
			end_dt = v_enddate,
			-- removal_id = v_removailid,
			update_ts = now()
		where eligibility_id = v_eligibility_id
			and delete_sw = 'N';
		
	else
		RAISE NOTICE 'v_count inside insert:%', v_count;
	
		  INSERT INTO cjams.tb_client_eligibility 
            (start_dt, 
             end_dt, 
             eligibility_type_cd, 
             eligibility_status_cd, 
             client_id, 
             removal_id, 
             create_user_id, 
             update_user_id, 
             delete_sw, 
             adoption_id, 
             case_id, 
             data_valid_sw, 
             client_merge_id, 
             guardian_subsidy_id, 
             transactionid, 
             create_ts, 
             update_ts)   
		SELECT isrcr.removaldate::date,
			isrcr.returndate::Date,  
			'2931', 
			'2909', 
			(select p.cjamspid from person p where p.personid = isrcr.personid ), 
			v_removailid,
			isrcr.insertedby,
			isrcr.updatedby, 
			'N',
			0,
			case when isrcr.servicecaseid is not null then --'yes' else 'no' end 
				(select servicecasenumber::int8
					from servicecase 
				 where servicecaseid = isrcr.servicecaseid 
				 order by insertedon 
				 desc limit 1
				 )
			else 
				(select CASE WHEN substring(servicerequestnumber,1,2) = 'CW' THEN 
							substring(servicerequestnumber,3) 
						ELSE 
							servicerequestnumber 
						END::int8 
				from intakeservicerequest  
				where intakeserviceid = isrcr.intakeserviceid 
				order by insertedon desc 
				limit 1
				)
			 end as a,
			 null,
			 null,
			 null,
			 null,
			 now(),
			 now()
 		FROM cjams.intakeservreqchildremoval isrcr 
		where isrcr.intakeservreqchildremovalid = childremovalid ; 
		
		FOR v_tousersid IN 
			select up.securityusersid 
				from userprofile up 
					inner join teammemberassignment tma on tma.securityusersid = up.securityusersid
					inner join teammember tm on tm.teammemberid = tma.teammemberid 
			where up.teamtypekey = 'CW' 
				and tm.roletypekey = 'IVESV'
		loop
			SELECT COALESCE(lastname,'') || ', ' || COALESCE(firstname,'')
				into v_username 
			FROM userprofile 
			WHERE securityusersid::varchar = v_securityuserid::varchar;
			
			v_msg:= concat('Foster Care Initial Determination for client id ', v_client_id::text , ' is assigned by ', COALESCE( v_username,''));
			
			SELECT send_notIFication 
				INTO v_notIFystatus 
			FROM send_notIFication(	v_tousersid.securityusersid,
									v_securityuserid::varchar, 
									v_tousersid.securityusersid,
									'System', 
									'High', 
									v_msg, 
									v_msg, 
									v_servicecaseid
								  );
		end loop;	
	end if;

return 'Success';

END;

$function$;
