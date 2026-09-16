CREATE OR REPLACE FUNCTION cjams.sp_cps_responsetimer_datafix(	as_user_id character varying, 
																OUT al_sqlcode integer, 
																OUT as_mess character varying
															  )
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 08/05/2022
-- To Trigger Response Timer Calculation on all the Open CPS-IR / CPS-AR Cases (CDM-24184)

-- Revision(s)
-- 08/17/2022 Vineet Tirodkar - Modifications to pass as_user_id to cpsresponsetimerupdate call (CDM-24170)
------------------------------------------------------------------------
Declare sqlcode int default 0;
Declare vu_intakeserviceid uuid;
Declare vs_servicerequestnumber character varying;
Declare vs_actiontype character varying;
Declare v_status text;
								
cur_cps_case record;
cur_cps_case_REFCURSOR REFCURSOR;

BEGIN
	if as_user_id is NULL then
		as_user_id := 'cwResponseTm';
	end if;
		
	DROP TABLE IF EXISTS ttb_cps_cases CASCADE;
	CREATE TEMPORARY TABLE ttb_cps_cases
		(	intakeserviceid	uuid, 
			servicerequestnumber character varying, 
			actiontype character varying 
		 ) ;
		
	insert into ttb_cps_cases ( intakeserviceid, servicerequestnumber, actiontype )
	select intakeserviceid, servicerequestnumber, actiontype
		from intakeservicerequest isr
	where isr.activeflag = 1
		and isr.actiontype in ( 'IR', 'AR' )
		and isr.responsetimer is null
		and teamtypekey = 'CW'
		and servicerequestnumber not like 'CW%'
		-- Unit Test	
		-- and isr.servicerequestnumber in ( '20190303013584', '20190304013589', '20190304013606', '20190305013613' )
	order by insertedon ;		

	OPEN cur_cps_case_REFCURSOR FOR
		select intakeserviceid, 
			servicerequestnumber, 
			actiontype			
		from ttb_cps_cases ;
	loop
		fetch cur_cps_case_REFCURSOR into cur_cps_case;
			exit when not found;
		
			-- Reset
			vu_intakeserviceid := NULL;
			vs_servicerequestnumber := NULL;
			vs_actiontype := NULL;
			
			vu_intakeserviceid := cur_cps_case.intakeserviceid;
			vs_servicerequestnumber := cur_cps_case.servicerequestnumber;
			vs_actiontype := cur_cps_case.actiontype;
			
			RAISE NOTICE 'vu_intakeserviceid >> %',vu_intakeserviceid;
			RAISE NOTICE 'vs_servicerequestnumber >> %',vs_servicerequestnumber;
			RAISE NOTICE 'vs_actiontype >> %',vs_actiontype;
			
			select * 
				from cjams.cpsresponsetimerupdate
					(	vu_intakeserviceid::uuid,
						as_user_id::character varying
					) into v_status ;
			
			RAISE NOTICE 'cpsresponsetimerupdate Return Status >> %',v_status;	
	END LOOP;	
	close cur_cps_case_REFCURSOR;	
	
	IF al_sqlcode <> -1 then
		al_sqlcode := 0;
		as_mess := 'Success';
	END IF;	
	
	DROP TABLE IF EXISTS ttb_cps_cases CASCADE;	  
END;

$function$
;
