------------------------------------------------------------------------
-- Revision(s)
-- 05/06/2025 - Naveenkumar Chemutu - Insert dashboard task for active exisitng child removals (CIDM-10354)
-- 05/27/2025 - Naveenkumar Chemutu - Added validation for inserting activity task (CIDM-10354)


DO $$
declare


v_activityid uuid;
v_task_due_date DATE;
v_task_due_date_MS DATE;
v_task_due_date_HD DATE;
v_task_limit INT;
v_actiontype TEXT;
days_diff INT;
rec RECORD;
v_status TEXT;
v_completed_date DATE;
v_old_child_removal BOOLEAN := FALSE;
v_task2_date DATE;
v_business_days INT := 0;
v_check_date DATE;
v_year INTEGER;
v_holidays DATE[];  
v_next_year INTEGER;



Begin

	 FOR rec IN
		with temp_existing_removal_data as (
		select  pmsy.insertedon as lastmedicationentereddate,
			irl.personid ,irl.removaldate ,irl.intakeservreqchildremovalid as removal_id ,scc.servicecaseid ,scc.servicecasenumber ,
			'Condition/Disorder need update for ' || pr.firstname || ' ' || pr.lastname as healthdisorder_task_txt,
			'Medication sub-tab update is required for Client ' || pr.firstname || ' ' || pr.lastname as medicationpsychotropic_task_txt,
			irl.insertedby as userid	
			from 
		Intakeservreqchildremoval irl 
			JOIN servicecase scc on scc.servicecaseid = irl.servicecaseid AND scc.activeflag = 1 
			INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = irl.intakeservicerequestactorid and irl.activeflag  = 1
			inner join person pr on pr.personid = irl.personid  AND pr.activeflag = 1 
			LEFT JOIN LATERAL (
				SELECT *
				FROM personmedicpshychotropic pmpsy
				WHERE pmpsy.personid = irl.personid
				ORDER BY pmpsy.insertedon  DESC
				LIMIT 1
			) pmsy ON true
			where irl.exitdate is null and irl.activeflag =1
			and irl.removaldate is not null
			and ( select count(*) 
            from routing rur
	        where rur.objectid = irl.intakeservreqchildremovalid::character varying
	            and rur.eventcode = 'CHRR'
	            and rur.activeflag = 1
	            and rur.routingstatustypeid = '16'
	        ) > 0
			and IRL.intakeservreqchildremovalid not in (
				select distinct objectid from activity
			)) 
		select * from temp_existing_removal_data 
		    		
		
   loop

     if not exists (select activityid from cjams.activity where objectid = rec.removal_id::uuid limit 1) then
		INSERT INTO cjams.activity
		(activityid, description, activitystatustypekey, amactivityid, ammappingid, objectid, sourcedescription, activitytypekey, helptext, "sequence", activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", voidedby, voidedon, voidreasonid, groupsequence, iseditable)
		VALUES(gen_random_uuid()::uuid, 'Child Welfare - Service Case', NULL, NULL, NULL, rec.removal_id::uuid, 'Child Welfare - Service Case', 'ChildRemoval', 'Child Welfare - Service Case', 1, 1, 'CIDM-10354', now(), 'CIDM-10354', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL)
		RETURNING activityid INTO v_activityid;

  		v_task_due_date := rec.removaldate;
		v_year  := EXTRACT(YEAR FROM v_task_due_date);
		v_next_year := v_year + 1;  

		-- Dynamically generate U.S. federal holidays
		v_holidays := ARRAY[
			MAKE_DATE(v_year, 1, 1),                                   -- New Year's Day
			getnthweekday(v_year, 1, 1, 3),                              -- MLK Day (3rd Monday Jan)
			getnthweekday(v_year, 2, 1, 3),                              -- Presidents' Day (3rd Monday Feb)
			getlastweekday(v_year, 5, 1),                                -- Memorial Day (Last Monday May)
			MAKE_DATE(v_year, 6, 19),                                  -- Juneteenth
			MAKE_DATE(v_year, 7, 4),                                   -- Independence Day
			getnthweekday(v_year, 9, 1, 1),                              -- Labor Day (1st Monday Sep)
			getnthweekday(v_year, 10, 1, 2),                             -- Columbus Day (2nd Monday Oct)
			MAKE_DATE(v_year, 11, 11),                                 -- Veterans Day
			getnthweekday(v_year, 11, 4, 4),                             -- Thanksgiving (4th Thursday Nov)
			MAKE_DATE(v_year, 12, 25),                                  -- Christmas
			MAKE_DATE(v_next_year, 1, 1)                               -- New Year's Day (Next Year)
		];
	
			
			 -- Calculate the 5th business day from ad_removal_dt
			WHILE v_business_days < 5 LOOP
				v_task_due_date := v_task_due_date + INTERVAL '1 day';
				v_check_date := v_task_due_date::DATE;

				IF EXTRACT(DOW FROM v_check_date) NOT IN (0, 6) AND
				v_check_date NOT IN (SELECT unnest(v_holidays)) THEN
					v_business_days := v_business_days + 1;
				END IF;
			END LOOP;
		     
		       -- New child removal created with older date and first task is older than current date then setting first task date as current date.
			if v_task_due_date < current_date then
				v_task_due_date := current_date;	
				v_old_child_removal := TRUE;
			end if;

		 	-- setting initial duedate for HealthDisorder and MedicationPsychotropic
			v_task_due_date_MS := v_task_due_date;
			v_task_due_date_HD := v_task_due_date;
	
           
	  -- Loop through tasks for HealthDisorder, MedicationPsychotropic
	    FOR v_actiontype IN SELECT unnest(ARRAY['HealthDisorder', 'MedicationPsychotropic']) loop
	    
	     -- Determining number of tasks for each action
	        v_task_limit := CASE v_actiontype
	            WHEN 'HealthDisorder' THEN 2
	            WHEN 'MedicationPsychotropic' THEN 4
	        END;
	     
	          FOR i IN 0..(v_task_limit - 1) LOOP      
	          
	            -- defining task date for 2nd task onwords
	          if i != 0 and v_actiontype = 'MedicationPsychotropic' then              
	            if v_old_child_removal then
					--setting task dates based on child removal date cycle for child removals with past dates.				
					v_task_due_date_MS = (rec.removaldate::date + (INTERVAL '30 day' * (FLOOR((CURRENT_DATE - rec.removaldate::date) / 30) + i))); -- Task  2, 3, 4
				else 
					v_task_due_date_MS = rec.removaldate + (i * INTERVAL '30 days');  -- Task  2, 3, 4
				end if;
			  end if;

			   -- defining task date for 2nd task onwords for HealthDisorder
				if i != 0 and v_actiontype = 'HealthDisorder' then    
						v_task_due_date_HD = v_task_due_date_HD + (i * INTERVAL '90 days');  -- Task 1, 2
				end if;					
           
			 
			   -- updating task status and completion date if medication entry found in last 30 days
          
			 	IF rec.lastmedicationentereddate IS NOT NULL THEN
		            -- Check if recent medication entry exists AND falls within the same month as the current task date
		            IF EXTRACT(YEAR FROM rec.lastmedicationentereddate) = EXTRACT(YEAR FROM v_task_due_date_MS) AND
		               EXTRACT(MONTH FROM rec.lastmedicationentereddate) = EXTRACT(MONTH FROM v_task_due_date_MS) THEN
		                v_status := 'CRClosed';
		                v_completed_date := rec.lastmedicationentereddate;
		            ELSE
		                v_status := 'CROpen';
		                v_completed_date := NULL;
		            END IF;
		        ELSE
		            v_status := 'CROpen';
		            v_completed_date := NULL;
		        END IF;

					-- updating task status and completion date for HealthDisorder
				If v_actiontype = 'HealthDisorder' then				
					v_status := case when v_task_due_date_HD < current_date then 'CRInProgress' else 'CROpen' end;
					v_completed_date := NULL;
				end if;	
       
	         
	           -- Inserting records into activitytask table
	           INSERT INTO cjams.activitytask
				(activitytaskid, activityid, "name", description, helptext, amtaskid, assignedto, assignedon, activitytaskstatustypekey, activitytaskdispositiontypekey, activitytasktypekey, activityprioritytypekey, duedate, startdatetime, enddatetime, "location", outofoffice, reasonnotmet, "sequence", required, completeddate, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", voidedby, voidedon, voidreasonid, targetcompleteddate, assessmenttemplateid, assessmentid, taskcommunicationtypekey, taskdispositiontypekey, iscontinual, reminderdate, iseditable, notes, etl_userid, etl_load_date, supervisorstatus, status)
				VALUES(
					gen_random_uuid()::uuid, 
					v_activityid::uuid, 
					CASE v_actiontype
	                    WHEN 'HealthDisorder' THEN rec.healthdisorder_task_txt
	                    WHEN 'MedicationPsychotropic' THEN rec.medicationpsychotropic_task_txt
	                end,
	                CASE v_actiontype
	                    WHEN 'HealthDisorder' THEN 'HealthDisorder'
	                    WHEN 'MedicationPsychotropic' THEN 'MedicationPsychotropic'
	                end,				
					'Child Welfare - Service Case', 
					NULL, 
					rec.userid,
					now(), 
					v_status,
					NULL,
					CASE v_actiontype
	                    WHEN 'HealthDisorder' THEN 'HealthDisorder'
	                    WHEN 'MedicationPsychotropic' THEN 'MedicationPsychotropic'
	                end,	
					NULL, 
					CASE v_actiontype
                    WHEN 'HealthDisorder' THEN v_task_due_date_HD
                    WHEN 'MedicationPsychotropic' then v_task_due_date_MS                    	
                	end,					
					NULL, NULL, NULL, NULL, NULL, i, true, v_completed_date, 1, 'CIDM-10354', now(), 'CIDM-10354', now(), now(), NULL, 
					NULL, NULL, NULL, NULL, NULL, NULL,NULL,NULL, NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
	 			RAISE NOTICE 'end of loop %',v_task_due_date;
	        END LOOP;
	     END LOOP;  
		end if;
    END LOOP;

 
 END $$;