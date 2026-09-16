CREATE OR REPLACE FUNCTION cjams.senuntimelyreasoncreteriaupdate(v_servicecaseid uuid, v_user_id character varying, v_inputsource character varying, v_inputsourceid uuid DEFAULT NULL::uuid)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 
-------------------------------------------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Manasa Kasula
-- Date Created : 01/08/2026
-- SEN- Untimely Completion Reason (CIDM-10984 - B-207269)

-- Argument(s): 1) IN v_servicecaseid - Service Case ID, 
-- 				2) IN v_user_id - User ID, 

-- Revision
-- 05/11/2026 - For SEN Timeline Calculation Logic consider 1st Intake narrative updated timestamp (-ve 96 hours) (CIDM-11398)
-------------------------------------------------------------------------------------------------------------
DECLARE
v_servicecasestartdate timestamp;
v_intakenumber character varying;
v_senstartdate timestamp;
v_f2fcontactuntimelydone boolean;
v_safecuntimelydone boolean;
v_mfirauntimelydone boolean;
v_progressnoteid uuid;
v_safecassessmentid uuid;
v_mfiraassessmentid uuid;
v_rec Record;
v_f2fcontactuntimelydonereason character varying;
v_otherf2fcomments text;
v_safecuntimelydonereason character varying;
v_othersafeccomments text;
v_mfirauntimelydonereason character varying;
v_othermfiracomments text;
v_newprogressnoteid uuid;
v_newf2fcontactuntimelydone boolean;
v_newsafecassessmentid uuid;
v_newsafecuntimelydone boolean;
v_newmfiraassessmentid uuid;
v_newmfirauntimelydone boolean;
v_rohsenuntimelycompletionreasonid uuid;

vs_case_type character varying;
vs_case_number character varying;
			

BEGIN
    select scd.statusdate 
        into v_servicecasestartdate
    from servicecase sc 
    inner join servicecasedisposition scd on scd.servicecaseid = sc.servicecaseid and scd.activeflag = 1
    where sc.servicecaseid = v_servicecaseid and sc.activeflag = 1 and scd.dispositioncode != 'Closed'
    order by scd.insertedon asc limit 1; 

    For v_rec in select per.personid, per.substanceexposednewbornsourceid
        from actor a 
        inner join person per on per.personid = a.personid and per.activeflag = 1 and per.substanceexposednewbornflag = 1 and per.dateofdeath is null 
        where a.servicecaseid = v_servicecaseid and a.activeflag = 1
    loop
	
		/*
        select coalesce((isn.jsondata -> 'General'->>'narrativeUpdatedDate')::timestamp,(isn.jsondata -> 'General'->>'RecivedDate')::timestamp,s.startdate,i.narrativeupdateddate,i.receivedtime,i2.intakedaterecieved, i2.reporteddate,v_servicecasestartdate) 
            into v_senstartdate
        from person per 
        left join intakesnapshot isn on isn.intakenumber = per.substanceexposednewbornsourceid and isn.activeflag = 1
        left join servicecase s on (s.servicecasenumber = per.substanceexposednewbornsourceid or s.servicecaseid::varchar  = per.substanceexposednewbornsourceid) and s.activeflag = 1
        left join intakeservicerequest i on (i.servicerequestnumber = per.substanceexposednewbornsourceid or i.intakeserviceid ::varchar  = per.substanceexposednewbornsourceid) and i.activeflag = 1
        left join intakeservicerequest i2 on (i.servicerequestnumber is null and s.servicecasenumber is null and isn.intakenumber is null)
			and (i2.servicerequestnumber = 'CW' || per.substanceexposednewbornsourceid ) and i2.activeflag = 1
        where per.activeflag = 1 and per.substanceexposednewbornflag = 1 and per.personid = v_rec.personid;
		*/
		
			
		select *
		from 
			(
			select (case when ac.intakenumber is not null then 
					'Intake'
				when ac.intakeserviceid is not null then 
					'CPS'
				when ac.servicecaseid is not null then 
					'Service'
				end) as case_type,
				(case when ac.intakenumber is not null then 
					ac.intakenumber::character varying
				when ac.intakeserviceid is not null then 
					ac.intakeserviceid::character varying
				when ac.servicecaseid is not null then 
					ac.servicecaseid::character varying
				end) as case_number
			from actor ac,
				intakeservicerequestactor acr,
				intakeservicerequest isr
			where ac.actorid = acr.actorid 
				and coalesce(isr.teamtypekey, 'CW') = 'CW'
				and (isr.intakenumber = ac.intakenumber or isr.intakeserviceid = ac.intakeserviceid or isr.servicecaseid = ac.servicecaseid )
				and ac.activeflag = 1
				and acr.activeflag = 1
				and ac.personid = v_rec.personid
				-- and ac.intakenumber is not null 
			order by (case when ac.intakenumber is not null then 1 when ac.intakeserviceid is not null then 2 else 3 end)::integer,
				ac.insertedon
			limit 1
			) tab
		into vs_case_type,
			vs_case_number ;
		
		
		If vs_case_type = 'Intake' then 
			select coalesce((isn.jsondata -> 'General'->>'narrativeUpdatedDate')::timestamptz AT TIME ZONE 'America/New_York',
					(isn.jsondata -> 'General'->>'RecivedDate')::timestamp)
				into v_senstartdate
			from intakesnapshot isn 
			where isn.intakenumber = vs_case_number
				and isn.activeflag = 1 ;
				
			if v_senstartdate is null then 
				select coalesce(i2.intakedaterecieved, i2.reporteddate) 
					into v_senstartdate
				from intakeservicerequest i2 
				where i2.intakenumber = vs_case_number 
					and i2.activeflag = 1 ;
			end if;

        elseif vs_case_type = 'CPS' then
			select coalesce(isr.intakedaterecieved, isr.reporteddate)
				into v_senstartdate
			from intakeservicerequest isr
			where ( isr.intakeserviceid::character varying = vs_case_number
					or	
					isr.servicerequestnumber = vs_case_number
				   )
				and isr.activeflag = 1 ;
		-- else -- case type Service Case or NULL	v_senstartdate := v_servicecasestartdate ;
		end if;
		
		If v_senstartdate is null then 
			v_senstartdate := v_servicecasestartdate ;
		end if;
		
        select rsuc.f2fcontactuntimelydone, rsuc.safecuntimelydone, rsuc.mfirauntimelydone,rsuc.progressnoteid,rsuc.safecassessmentid,rsuc.mfiraassessmentid ,
            f2fcontactuntimelydonereason, otherf2fcomments,safecuntimelydonereason,othersafeccomments,mfirauntimelydonereason,othermfiracomments,rohsenuntimelycompletionreasonid  
            into v_f2fcontactuntimelydone, v_safecuntimelydone, v_mfirauntimelydone, v_progressnoteid, v_safecassessmentid, v_mfiraassessmentid,
            v_f2fcontactuntimelydonereason,v_otherf2fcomments,v_safecuntimelydonereason,v_othersafeccomments,v_mfirauntimelydonereason,v_othermfiracomments, v_rohsenuntimelycompletionreasonid
        from cjams.rohsenuntimelycompletionreasons rsuc where rsuc.servicecaseid = v_servicecaseid and rsuc.personid = v_rec.personid and rsuc.activeflag = 1;
        
		-- Case Closure Implementation   
        IF(v_inputsource = 'caseclosure')
        THEN
            --- F2F Contact made timely check 
            select pn.progressnoteid, (case when pn.starttime <= (v_senstartdate + interval '48 hours') then false else true end) 
            into v_newprogressnoteid, v_newf2fcontactuntimelydone
            FROM progressnote pn 
            where pn.entitytypeid in 
                (v_servicecaseid::character varying,
                (SELECT intakeserviceid:: character varying FROM intakeservicerequest isr
                WHERE servicecaseid =v_servicecaseid::uuid AND activeflag =1 and intakeserviceid is not null order by isr.updatedon desc LIMIT 1),
                (SELECT DISTINCT intakenumber:: character varying FROM intakeservicerequest
                WHERE servicecaseid =v_servicecaseid::uuid and intakenumber is not null LIMIT 1)
                )
                and pn.activeflag = 1 and coalesce(pn.attemptindicator, false) <> true -- Completed
                and pn.starttime >= (v_senstartdate - interval '96 hours')
                AND EXISTS (
                    SELECT 1 
                    FROM progressnotetype pt 
                    WHERE pt.progressnotetypeid = pn.progressnotetypeid 
                    AND lower(pt.progressnotetypekey) in ('initialfacetoface', 'face to face') 
                )
                AND EXISTS (
                    SELECT 1 
                    FROM contactparticipant cp
                    JOIN intakeservicerequestactor insr2 
                    ON insr2.intakeservicerequestactorid = cp.intakeservicerequestactorid
                    WHERE cp.progressnoteid = pn.progressnoteid AND cp.activeflag = 1 AND insr2.personid = v_rec.personid
                )
            order by pn.starttime;

            v_f2fcontactuntimelydone := v_newf2fcontactuntimelydone;
            v_progressnoteid := v_newprogressnoteid;

            IF(v_f2fcontactuntimelydone = false) then 
                v_f2fcontactuntimelydonereason:= null;
                v_otherf2fcomments:= null;
            END IF;

            -- Safec Assessment added timely check  
            select sa.assessmentid , (case when sa.dateassessmentinitiated <= (v_senstartdate + interval '48 hours') then false else true end) 
                into v_newsafecassessmentid, v_newsafecuntimelydone 
            from
            (select a.assessmentid, (a.submissiondata->>'dateassessmentinitiated')::timestamp as dateassessmentinitiated
            from assessment a
            where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
            and (a.submissiondata->>'dateassessmentinitiated')::timestamp >= (v_senstartdate - interval '96 hours')     
            and a.assessmentstatustypekey = 'Accepted'
            AND EXISTS (
                    SELECT 1 
                    FROM assessmenttemplate a2 
                    WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                    AND a2.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' 
                )
                AND EXISTS (
                    SELECT 1 
                    FROM assessmentactor a3
                    join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                    WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
                ) 
            union all
            select a.assessmentid, asub.datavalue::timestamp as dateassessmentinitiated
            from assessment a
            inner join assessmentsubmission asub on a.assessmentid = asub.assessmentid and asub.datakey = 'dateassessmentinitiated' and asub.activeflag = 1
            where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
            and asub.datavalue::timestamp >= (v_senstartdate - interval '96 hours') and a.assessmentstatustypekey = 'Accepted'     
            and asub.datavalue is not null and asub.datavalue != ''
            AND EXISTS (
                    SELECT 1 
                    FROM assessmenttemplate a2 
                    WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                    AND a2.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' 
                )
            AND EXISTS (
                SELECT 1 
                FROM assessmentactor a3
                join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
            )) sa      
            order by dateassessmentinitiated;

            v_safecuntimelydone := v_newsafecuntimelydone;
            v_safecassessmentid := v_newsafecassessmentid;

            IF(v_safecuntimelydone = false) then 
                v_safecuntimelydonereason:= null;
                v_othersafeccomments:= null;
            END IF;
            -- MFIRA Assessment timely check 
            select sa.assessmentid , (case when sa.dateassessmentinitiated <= (v_senstartdate + interval '30 days') then false else true end) 
            into v_newmfiraassessmentid, v_newmfirauntimelydone
            from
            (select a.assessmentid, (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp as dateassessmentinitiated
            from assessment a
            where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
            and (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp >= (v_senstartdate - interval '96 hours')
            and a.assessmentstatustypekey = 'Accepted'
            AND EXISTS (
                SELECT 1 
                FROM assessmenttemplate a2 
                WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                AND a2.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
            )
            AND EXISTS (
                SELECT 1 
                FROM assessmentactor a3
                join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
            )  
            union all
            select a.assessmentid, sc.datavalue::timestamp as dateassessmentinitiated
            from assessment a
            inner join assessmentsubmission asub on a.assessmentid = asub.assessmentid and asub.datakey = 'familyHOUSEHOLD' and asub.activeflag = 1 and asub.iscollection=2
            inner join submissioncollection sc on asub.assessmentsubmissionid=sc.assessmentsubmissionid and sc.datakey = 'assessmentInitDate' and sc.activeflag = 1
            where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
            and (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp >= (v_senstartdate - interval '96 hours')
            and a.assessmentstatustypekey = 'Accepted' and sc.datavalue is not null and sc.datavalue != ''
            AND EXISTS (
                SELECT 1 
                FROM assessmenttemplate a2 
                WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                AND a2.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
            )
            AND EXISTS (
                SELECT 1 
                FROM assessmentactor a3
                join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
            )) sa 
            order by dateassessmentinitiated;

            v_mfirauntimelydone := v_newmfirauntimelydone;
            v_mfiraassessmentid := v_newmfiraassessmentid;

            IF(v_mfirauntimelydone = false) then 
                v_mfirauntimelydonereason:= null;
                v_othermfiracomments:= null;
            END IF;

        --- F2F Contact made timely check 
        ELSIF(v_inputsource = 'contactnote')
        THEN
            select pn.progressnoteid, (case when pn.starttime <= (v_senstartdate + interval '48 hours') then false else true end) 
                into v_newprogressnoteid, v_newf2fcontactuntimelydone
            FROM progressnote pn 
            where pn.entitytypeid in 
                (v_servicecaseid::character varying,
                (SELECT intakeserviceid:: character varying FROM intakeservicerequest isr
                WHERE servicecaseid =v_servicecaseid::uuid AND activeflag =1 and intakeserviceid is not null order by isr.updatedon desc LIMIT 1),
                (SELECT DISTINCT intakenumber:: character varying FROM intakeservicerequest
                WHERE servicecaseid =v_servicecaseid::uuid and intakenumber is not null LIMIT 1)
                )
                and pn.activeflag = 1 and coalesce(pn.attemptindicator, false) <> true -- Completed
                and pn.starttime >= (v_senstartdate - interval '96 hours')
                AND EXISTS (
                    SELECT 1 
                    FROM progressnotetype pt 
                    WHERE pt.progressnotetypeid = pn.progressnotetypeid 
                    AND lower(pt.progressnotetypekey) in ('initialfacetoface', 'face to face') 
                )
                AND EXISTS (
                    SELECT 1 
                    FROM contactparticipant cp
                    JOIN intakeservicerequestactor insr2 
                    ON insr2.intakeservicerequestactorid = cp.intakeservicerequestactorid
                    WHERE cp.progressnoteid = pn.progressnoteid AND cp.activeflag = 1 AND insr2.personid = v_rec.personid
                )
            order by pn.starttime;

            v_f2fcontactuntimelydone := v_newf2fcontactuntimelydone;
            v_progressnoteid := v_newprogressnoteid;

            IF(v_f2fcontactuntimelydone = false) then 
                v_f2fcontactuntimelydonereason:= null;
                v_otherf2fcomments:= null;
            END IF;
        -- Safec Assessment added timely check 
        ELSIF(v_inputsource = 'SAFE-C')
        THEN
            select sa.assessmentid , (case when sa.dateassessmentinitiated <= (v_senstartdate + interval '48 hours') then false else true end) 
                into v_newsafecassessmentid, v_newsafecuntimelydone 
            from
            (select a.assessmentid, (a.submissiondata->>'dateassessmentinitiated')::timestamp as dateassessmentinitiated
            from assessment a
            where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
            and (a.submissiondata->>'dateassessmentinitiated')::timestamp >= (v_senstartdate - interval '96 hours')     
            and a.assessmentstatustypekey = 'Accepted'
            AND EXISTS (
                    SELECT 1 
                    FROM assessmenttemplate a2 
                    WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                    AND a2.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' 
                )
                AND EXISTS (
                    SELECT 1 
                    FROM assessmentactor a3
                    join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                    WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
                ) 
            union all
            select a.assessmentid, asub.datavalue::timestamp as dateassessmentinitiated
            from assessment a
            inner join assessmentsubmission asub on a.assessmentid = asub.assessmentid and asub.datakey = 'dateassessmentinitiated' and asub.activeflag = 1
            where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
            and asub.datavalue::timestamp >= (v_senstartdate - interval '96 hours') and a.assessmentstatustypekey = 'Accepted'     
            and asub.datavalue is not null and asub.datavalue != ''
            AND EXISTS (
                    SELECT 1 
                    FROM assessmenttemplate a2 
                    WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                    AND a2.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' 
                )
            AND EXISTS (
                SELECT 1 
                FROM assessmentactor a3
                join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
            )) sa      
            order by dateassessmentinitiated; 

            If(v_newsafecuntimelydone is null) then 
                select a.assessmentid , (case when (a.submissiondata->>'dateassessmentinitiated')::timestamp <= (v_senstartdate + interval '48 hours') then false else true end) 
                    into v_newsafecassessmentid, v_newsafecuntimelydone 
                from assessment a
                where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
                and (a.submissiondata->>'dateassessmentinitiated')::timestamp >= (v_senstartdate - interval '96 hours')     
                and a.assessmentstatustypekey = 'Review'
                AND EXISTS (
                    SELECT 1 
                    FROM assessmenttemplate a2 
                    WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                    AND a2.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' 
                )
                AND EXISTS (
                    SELECT 1 
                    FROM assessmentactor a3
                    join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                    WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
                )   
                order by (a.submissiondata->>'dateassessmentinitiated')::timestamp;  
            End IF;     

            v_safecuntimelydone := v_newsafecuntimelydone;
            v_safecassessmentid := v_newsafecassessmentid;

            IF(v_safecuntimelydone = false) then 
                v_safecuntimelydonereason:= null;
                v_othersafeccomments:= null;
            END IF;
        -- MFIRA Assessment timely check 
        ELSIF(v_inputsource = 'MFIRA')
        THEN
            select sa.assessmentid , (case when sa.dateassessmentinitiated <= (v_senstartdate + interval '30 days') then false else true end) 
            into v_newmfiraassessmentid, v_newmfirauntimelydone
            from
            (select a.assessmentid, (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp as dateassessmentinitiated
            from assessment a
            where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
            and (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp >= (v_senstartdate - interval '96 hours')
            and a.assessmentstatustypekey = 'Accepted'
            AND EXISTS (
                SELECT 1 
                FROM assessmenttemplate a2 
                WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                AND a2.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
            )
            AND EXISTS (
                SELECT 1 
                FROM assessmentactor a3
                join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
            )  
            union all
            select a.assessmentid, sc.datavalue::timestamp as dateassessmentinitiated
            from assessment a
            inner join assessmentsubmission asub on a.assessmentid = asub.assessmentid and asub.datakey = 'familyHOUSEHOLD' and asub.activeflag = 1 and asub.iscollection=2
            inner join submissioncollection sc on asub.assessmentsubmissionid=sc.assessmentsubmissionid and sc.datakey = 'assessmentInitDate' and sc.activeflag = 1
            where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
            and (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp >= (v_senstartdate - interval '96 hours')
            and a.assessmentstatustypekey = 'Accepted' and sc.datavalue is not null and sc.datavalue != ''
            AND EXISTS (
                SELECT 1 
                FROM assessmenttemplate a2 
                WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                AND a2.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
            )
            AND EXISTS (
                SELECT 1 
                FROM assessmentactor a3
                join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
            )) sa 
            order by dateassessmentinitiated;

            If(v_newmfirauntimelydone is null) then 
                select a.assessmentid , (case when (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp <= (v_senstartdate + interval '30 days') then false else true end) 
                    into v_newmfiraassessmentid, v_newmfirauntimelydone
                from assessment a
                where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))                
                and (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp >= (v_senstartdate - interval '96 hours')
                and a.assessmentstatustypekey = 'Review'
                AND EXISTS (
                    SELECT 1 
                    FROM assessmenttemplate a2 
                    WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                    AND a2.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
                )
                AND EXISTS (
                    SELECT 1 
                    FROM assessmentactor a3
                    join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                    WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
                )   
                order by (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp;
            End IF;
           
            v_mfirauntimelydone := v_newmfirauntimelydone;
            v_mfiraassessmentid := v_newmfiraassessmentid;

            IF(v_mfirauntimelydone = false) then 
                v_mfirauntimelydonereason:= null;
                v_othermfiracomments:= null;
            END IF;

        ELSIF(v_inputsource = 'overduereasonpopup')
        THEN

            --- F2F Contact made timely check 
            select pn.progressnoteid, (case when pn.starttime <= (v_senstartdate + interval '48 hours') then false else true end) 
            into v_newprogressnoteid, v_newf2fcontactuntimelydone
            FROM progressnote pn 
            where pn.entitytypeid in 
                (v_servicecaseid::character varying,
                (SELECT intakeserviceid:: character varying FROM intakeservicerequest isr
                WHERE servicecaseid =v_servicecaseid::uuid AND activeflag =1 and intakeserviceid is not null order by isr.updatedon desc LIMIT 1),
                (SELECT DISTINCT intakenumber:: character varying FROM intakeservicerequest
                WHERE servicecaseid =v_servicecaseid::uuid and intakenumber is not null LIMIT 1)
                )
                and pn.activeflag = 1 and coalesce(pn.attemptindicator, false) <> true -- Completed
                and pn.starttime >= (v_senstartdate - interval '96 hours')
                AND EXISTS (
                    SELECT 1 
                    FROM progressnotetype pt 
                    WHERE pt.progressnotetypeid = pn.progressnotetypeid 
                    AND lower(pt.progressnotetypekey) in ('initialfacetoface', 'face to face') 
                )
                AND EXISTS (
                    SELECT 1 
                    FROM contactparticipant cp
                    JOIN intakeservicerequestactor insr2 
                    ON insr2.intakeservicerequestactorid = cp.intakeservicerequestactorid
                    WHERE cp.progressnoteid = pn.progressnoteid AND cp.activeflag = 1 AND insr2.personid = v_rec.personid
                )
            order by pn.starttime;

            v_f2fcontactuntimelydone := v_newf2fcontactuntimelydone;
            v_progressnoteid := v_newprogressnoteid;

            IF(v_f2fcontactuntimelydone = false) then 
                v_f2fcontactuntimelydonereason:= null;
                v_otherf2fcomments:= null;
            END IF;

            -- Safec Assessment added timely check  
            select sa.assessmentid , (case when sa.dateassessmentinitiated <= (v_senstartdate + interval '48 hours') then false else true end) 
                into v_newsafecassessmentid, v_newsafecuntimelydone 
            from
            (select a.assessmentid, (a.submissiondata->>'dateassessmentinitiated')::timestamp as dateassessmentinitiated
            from assessment a
            where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
            and (a.submissiondata->>'dateassessmentinitiated')::timestamp >= (v_senstartdate - interval '96 hours')     
            and a.assessmentstatustypekey = 'Accepted'
            AND EXISTS (
                    SELECT 1 
                    FROM assessmenttemplate a2 
                    WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                    AND a2.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' 
                )
                AND EXISTS (
                    SELECT 1 
                    FROM assessmentactor a3
                    join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                    WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
                ) 
            union all
            select a.assessmentid, asub.datavalue::timestamp as dateassessmentinitiated
            from assessment a
            inner join assessmentsubmission asub on a.assessmentid = asub.assessmentid and asub.datakey = 'dateassessmentinitiated' and asub.activeflag = 1
            where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
            and asub.datavalue::timestamp >= (v_senstartdate - interval '96 hours') and a.assessmentstatustypekey = 'Accepted'     
            and asub.datavalue is not null and asub.datavalue != ''
            AND EXISTS (
                    SELECT 1 
                    FROM assessmenttemplate a2 
                    WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                    AND a2.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' 
                )
            AND EXISTS (
                SELECT 1 
                FROM assessmentactor a3
                join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
            )) sa      
            order by dateassessmentinitiated; 

            If(v_newsafecuntimelydone is null) then 
                select a.assessmentid , (case when (a.submissiondata->>'dateassessmentinitiated')::timestamp <= (v_senstartdate + interval '48 hours') then false else true end) 
                    into v_newsafecassessmentid, v_newsafecuntimelydone 
                from assessment a
                where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
                and (a.submissiondata->>'dateassessmentinitiated')::timestamp >= (v_senstartdate - interval '96 hours')     
                and a.assessmentstatustypekey = 'Review'
                AND EXISTS (
                    SELECT 1 
                    FROM assessmenttemplate a2 
                    WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                    AND a2.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' 
                )
                AND EXISTS (
                    SELECT 1 
                    FROM assessmentactor a3
                    join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                    WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
                )   
                order by (a.submissiondata->>'dateassessmentinitiated')::timestamp;  
            End IF;     

            v_safecuntimelydone := v_newsafecuntimelydone;
            v_safecassessmentid := v_newsafecassessmentid;

            IF(v_safecuntimelydone = false) then 
                v_safecuntimelydonereason:= null;
                v_othersafeccomments:= null;
            END IF;

            -- MFIRA Assessment timely check 
            select sa.assessmentid , (case when sa.dateassessmentinitiated <= (v_senstartdate + interval '30 days') then false else true end) 
            into v_newmfiraassessmentid, v_newmfirauntimelydone
            from
            (select a.assessmentid, (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp as dateassessmentinitiated
            from assessment a
            where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
            and (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp >= (v_senstartdate - interval '96 hours')
            and a.assessmentstatustypekey = 'Accepted'
            AND EXISTS (
                SELECT 1 
                FROM assessmenttemplate a2 
                WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                AND a2.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
            )
            AND EXISTS (
                SELECT 1 
                FROM assessmentactor a3
                join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
            )  
            union all
            select a.assessmentid, sc.datavalue::timestamp as dateassessmentinitiated
            from assessment a
            inner join assessmentsubmission asub on a.assessmentid = asub.assessmentid and asub.datakey = 'familyHOUSEHOLD' and asub.activeflag = 1 and asub.iscollection=2
            inner join submissioncollection sc on asub.assessmentsubmissionid=sc.assessmentsubmissionid and sc.datakey = 'assessmentInitDate' and sc.activeflag = 1
            where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))
            and (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp >= (v_senstartdate - interval '96 hours')
            and a.assessmentstatustypekey = 'Accepted' and sc.datavalue is not null and sc.datavalue != ''
            AND EXISTS (
                SELECT 1 
                FROM assessmenttemplate a2 
                WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                AND a2.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
            )
            AND EXISTS (
                SELECT 1 
                FROM assessmentactor a3
                join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
            )) sa 
            order by dateassessmentinitiated;

            If(v_newmfirauntimelydone is null) then 
                select a.assessmentid , (case when (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp <= (v_senstartdate + interval '30 days') then false else true end) 
                    into v_newmfiraassessmentid, v_newmfirauntimelydone
                from assessment a
                where a.activeflag = 1 and (a.servicecaseid = v_servicecaseid or a.objectid IN (SELECT isr.intakeserviceid FROM intakeservicerequest isr WHERE isr.servicecaseid = v_servicecaseid))                
                and (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp >= (v_senstartdate - interval '96 hours')
                and a.assessmentstatustypekey = 'Review'
                AND EXISTS (
                    SELECT 1 
                    FROM assessmenttemplate a2 
                    WHERE a2.assessmenttemplateid = a.assessmenttemplateid 
                    AND a2.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
                )
                AND EXISTS (
                    SELECT 1 
                    FROM assessmentactor a3
                    join intakeservicerequestactor i on i.intakeservicerequestactorid = a3.intakeservicerequestactorid and i.activeflag = 1
                    WHERE a3.assessmentid = a.assessmentid and a3.activeflag = 1 AND i.personid = v_rec.personid
                )   
                order by (a.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::timestamp;
            End IF;

            v_mfirauntimelydone := v_newmfirauntimelydone;
            v_mfiraassessmentid := v_newmfiraassessmentid;

            IF(v_mfirauntimelydone = false) then 
                v_mfirauntimelydonereason:= null;
                v_othermfiracomments:= null;
            END IF;

        End IF;

        IF(v_rohsenuntimelycompletionreasonid is null) then 

            INSERT INTO cjams.rohsenuntimelycompletionreasons
            (rohsenuntimelycompletionreasonid, servicecaseid, personid, startdate, f2fcontactuntimelydone, safecuntimelydone, mfirauntimelydone, progressnoteid, safecassessmentid, mfiraassessmentid, insertedby, insertedon, 
            updatedby, updatedon, activeflag, f2fcontactuntimelydonereason, otherf2fcomments, safecuntimelydonereason, othersafeccomments, mfirauntimelydonereason, othermfiracomments)
            VALUES(gen_random_uuid(), v_servicecaseid,v_rec.personid,v_senstartdate,v_f2fcontactuntimelydone,v_safecuntimelydone,v_mfirauntimelydone,v_progressnoteid,v_safecassessmentid,v_mfiraassessmentid,v_user_id,now(),
            v_user_id,now(),1,v_f2fcontactuntimelydonereason,v_otherf2fcomments,v_safecuntimelydonereason,v_othersafeccomments,v_mfirauntimelydonereason,v_othermfiracomments);

        Else 

            UPDATE cjams.rohsenuntimelycompletionreasons
            SET f2fcontactuntimelydone=v_f2fcontactuntimelydone, safecuntimelydone=v_safecuntimelydone, mfirauntimelydone=v_mfirauntimelydone, progressnoteid=v_progressnoteid, safecassessmentid=v_safecassessmentid, 
            mfiraassessmentid=v_mfiraassessmentid, updatedby=v_user_id, updatedon=now(), f2fcontactuntimelydonereason=v_f2fcontactuntimelydonereason, otherf2fcomments=v_otherf2fcomments, safecuntimelydonereason=v_safecuntimelydonereason, 
            othersafeccomments=v_othersafeccomments, mfirauntimelydonereason=v_mfirauntimelydonereason, othermfiracomments=v_othermfiracomments
            WHERE rohsenuntimelycompletionreasonid=v_rohsenuntimelycompletionreasonid;
            
        END IF;
       
    END LOOP;

    Update cjams.rohsenuntimelycompletionreasons rsuc
    set activeflag = 0, updatedby= v_user_id, updatedon = now()
    where personid in (select p.personid from cjams.person p 
                        inner join actor a on a.personid = p.personid and a.activeflag = 1 
                        where p.activeflag = 1 and coalesce(p.substanceexposednewbornflag,0) = 0 and a.servicecaseid = v_servicecaseid)
	and rsuc.servicecaseid = v_servicecaseid and rsuc.activeflag = 1;
	
	RETURN 'Success';
    
    -- Handling exceptions
	EXCEPTION WHEN OTHERS then
	BEGIN
		RETURN sqlerrm::character varying; 
	END; 
END;

$function$
;
