DROP FUNCTION IF EXISTS cjams.crisp_load_inbound_interface(CHARACTER varying, DATE);

CREATE OR REPLACE FUNCTION cjams.crisp_load_inbound_interface(
    vs_batch_no character varying, 
    vdt_date date, 
    OUT vs_success_sw character varying, 
    OUT vl_output_sqlcode character varying, 
    OUT vs_message character varying
)
-- B-193551 - Immunet Interface (CRISP)
-- Description - To load CRISP Interface Data to CJAMS
-- Params: (::vs_batch_no CHARACTER varying, ::vdt_date date) eg ('1', current_date);
-- Note: For verbose logging, please set V_DEBUG FLAG under the helper variables as TRUE
-- Summary: 
    -- 1. Error handling for CRISP Inbound (Mandatory fields to process CRISP) 
    -- 2. Removed CRISP Ids activeflag will be marked as 0 in CJAMS
    -- 3. Process the crispcjamsflattened table, move the crispcjamsflattened table to Snapshot table.
        -- 3.1 We check for no changes scenarios and update it.
    -- 4. Generate the crispcjamsflattened table information.
    -- 5. If any one of flattened record in crispcjamsflattened is error, we update the crispinboundinterface as error
    -- 6. Insert all the records from crispcjamsflattened table if not exists in personimmunization already.
    -- 7. Loop through the crispcjamsflattened table
        -- 7.1 We check for no changes scenarios and update it.
        -- 7.2 If Immunization id is found, then we know it's already updated by CRISP interface. So update the source, audit columns
        -- 7.3 If immunization id is not found, we try to match an immunization id with vaccinationdt and vaccine type.
        -- 7.4 If found one, we update the immunizationid and not update the source columns.
        -- 7.5 If not, we mark it as 'DUPLICATE_REC_ELSE' - This status is a fallback for debugging.
    -- 8. Update the consolidated status from crispcjamsflattened table to crispinboundinterface table.
-- Note:
-- Records with immunization key not null in personimmunizationconfig are the only ones match with CRISP records.
-- The migrated personimmunizationconfigid can be found in old_id.
-- Revision(s):
----------------------------------------------------------------------------------------------------------- 
-- 09/13/2024: Print stats after SP run is done and fix the update on deletedids only if records exists
-- 11/14/2024: CIDM-9721 Slowness in delete, modify the remove block for better performance
-----------------------------------------------------------------------------------------------------------
 RETURNS record
 LANGUAGE plpgsql
AS $function$
DECLARE 
    CRISP_INBOUND_CNT               INTEGER;
    CRISP_INBOUND_CHILD_CNT         INTEGER;
    INBOUND_RECORD                  RECORD;
    PERSONIMMUID_RECORD             RECORD;
    STATS_RECORD                    RECORD;
    DELETED_CNT                     INTEGER DEFAULT 0;
    HIST_SW_SUCCESS                 VARCHAR;
    NOTIFICATION_SW_SUCCESS         VARCHAR;
    MAX_BATCH_DATE                  TIMESTAMP;
    CRISP_INBOUND_ROW_COUNT         BIGINT;
    CRISP_CHILD_INBOUND_CNT         BIGINT;
    CRISP_CHILD_INBOUND_ROW_COUNT   BIGINT;
    -- Helper variables
    V_RECORD_PERSONID               UUID;
    V_RECORD_IMMUNIZATION_ID        UUID;
    V_RECORD_SOURCESYSTEM           VARCHAR;
    V_DEBUG                         BOOLEAN DEFAULT TRUE;
    -- Error variables
    VS_OUTPUT_STATE             VARCHAR(5) DEFAULT '00000';
    VL_EXCEP_FLAG               INTEGER DEFAULT 0;
    VL_EXCEP_MESSAGE            VARCHAR DEFAULT '';
    VS_ERROR_DESC               VARCHAR DEFAULT '';
    VS_ERROR_CODE               VARCHAR DEFAULT '000';
BEGIN
    VS_BATCH_NO := CAST(VS_BATCH_NO AS int);
    RAISE NOTICE 'Start Time % ', timeofday();
    vl_output_sqlcode := '';
    VL_EXCEP_FLAG  := 0;
    VL_EXCEP_MESSAGE := '';
    SELECT max(tbsl.start_ts::timestamp) into MAX_BATCH_DATE FROM
                    tb_batch_log tbsl WHERE tbsl.batch_master_id = 107 and tbsl.batch_log_id = CAST(VS_BATCH_NO AS int);
    RAISE NOTICE 'Update BATCH NO for crispinboundinterface';
    UPDATE crispinboundinterface
    set 
        batchlogid = CAST(VS_BATCH_NO AS int)
    where batchlogid is null;

	RAISE NOTICE 'Pilot County update';
    if exists (
        select 1 from referencevalues where referencetypeid = 500502 and activeflag = 1 and value_text = 'State Wide' and ref_key = '9999'
        ) then RAISE NOTICE 'State Wide CRISP active; skipping PILOT County';
    else
        raise notice 'State Wide CRISP inactive; PILOT County update';
        UPDATE crispinboundinterface
            set activeflag = 0, status = 'NON_PILOT_COUNTY', comments = 'PILOT Program disabled for this record';

        update crispinboundinterface as ci
        set 
            activeflag = 1, status = null, comments = null
        from crispoutboundinterface as cout
        where ci.studentno = cout.patientid 
            and cout.batchlogid = (select max(batchlogid) from crispoutboundinterface)
            and exists
                    (select 1 from referencevalues where referencetypeid = 500502 and activeflag = 1 and value_text = cout.ldss);
    end if;

    CRISP_INBOUND_CNT := (SELECT CAST(COUNT(*) AS INTEGER) FROM crispinboundinterface where activeflag = 1);
    
    RAISE NOTICE 'No. of records in crispinboundinterface %', CRISP_INBOUND_CNT;
    RAISE NOTICE 'Running for batch no: %', VS_BATCH_NO;
    BEGIN
        RAISE NOTICE 'VALIDATION CHECKS %', timeofday();
        ---------------------------------------------------------
        -- Null Immunization ID: Mandatory column from CRISP interface for CJAMS
        ---------------------------------------------------------
       IF V_DEBUG then raise notice 'null immunization id check %', timeofday(); end if;
        with null_immunizationid as (
            select crispinboundinterfaceid as crispid,
                'INVALID_CRISP_DATA' as status,
                concat(coalesce(comments, ''), '| immunizationid is null | ') as comments
            from
                crispinboundinterface cit
            where 
                immunizationid is null
        )
        update crispinboundinterface as ct
        set 
            status = null_immunizationid.status,
            comments = coalesce(null_immunizationid.comments, ct.comments)
        from 
            null_immunizationid
        where
            ct.crispinboundinterfaceid  = null_immunizationid.crispid;
        IF V_DEBUG then raise notice 'null immunization id check end %', timeofday(); end if;
        ---------------------------------------------------------
        -- Null Student ID: Mandatory column from CRISP interface for CJAMS 
        -- (Relation with Person - personid, cjamspid)
        --------------------------------------------------------- 
       IF V_DEBUG then raise notice 'null student no check %', timeofday(); end if;
        with null_studentno as (
            select crispinboundinterfaceid as crispid,
                'INVALID_CRISP_DATA' as status,
                concat(coalesce(comments, ''), '| Studentno is null | ') as comments
            from
                crispinboundinterface cit
            where 
                studentno is null -- studentno is cjamspid
        )
        update crispinboundinterface as ct
        set 
            status = null_studentno.status,
            comments = coalesce(null_studentno.comments, ct.comments)
        from 
            null_studentno
        where
            ct.crispinboundinterfaceid  = null_studentno.crispid;
       IF V_DEBUG then raise notice 'null student no check end %', timeofday(); end if;
        ---------------------------------------------------------
        -- Null Vaccination Date: Mandatory column from CRISP interface for CJAMS 
        -- (Vaccination needs to be updated, else nullifiable data record.)
        ---------------------------------------------------------
        IF V_DEBUG then raise notice 'null vaccination dt check %',  timeofday(); end if;
        with null_vaccinationdt as (
            select cit.crispinboundinterfaceid as crispid,
                'INVALID_CRISP_DATA' as status,
                concat(coalesce(cit.comments, ''), '| Vaccinedt is null | ') as comments
            from
                crispinboundinterface cit
            where 
                cit.vaccinationdt is null
        )
        
        update crispinboundinterface as ct
        set 
            status = null_vaccinationdt.status,
            comments = coalesce(null_vaccinationdt.comments, ct.comments)
        from 
            null_vaccinationdt
        where
            ct.crispinboundinterfaceid  = null_vaccinationdt.crispid;
       IF V_DEBUG then raise notice 'null vaccination dt check end %', timeofday(); end if;
        ---------------------------------------------------------
        -- Null Last Updated Date: Mandatory column from CRISP interface for CJAMS
        -- CRISP will update this column if any new data record is added/updated.
        ---------------------------------------------------------
       IF V_DEBUG then raise notice 'null lastupdateddt check %', timeofday(); end if;
        with null_lastupdateddt as (
            select cit.crispinboundinterfaceid as crispid,
                'INVALID_CRISP_DATA' as status,
                concat(coalesce(cit.comments, ''), '| lastupdateddt is null | ') as comments
            from
                crispinboundinterface cit
            where 
                cit.lastupdateddt is null
        )
        update crispinboundinterface as ct
        set 
            status = null_lastupdateddt.status,
            comments = coalesce(null_lastupdateddt.comments, ct.comments)
        from 
            null_lastupdateddt
        where
            ct.crispinboundinterfaceid  = null_lastupdateddt.crispid;
       IF V_DEBUG then raise notice 'null lastupdateddt check end %', timeofday(); end if;
        ---------------------------------------------------------
        -- Null CVX Code: Mandatory column from CRISP interface for CJAMS
        -- Without CVX Code we can't map with personimmunizationconfig table (Vaccines)
        ---------------------------------------------------------
       IF V_DEBUG then raise notice 'null cvxcode check %' , timeofday(); end if;
        with null_cvxcode as (
            select cit.crispinboundinterfaceid as crispid,
                'INVALID_CRISP_DATA' as status,
                concat(coalesce(cit.comments, ''), '| cvxcode is null | ') as comments
            from
                crispinboundinterface cit
            where 
                cit.cvxcode is null or trim(cit.cvxcode) = ''
        )
        update crispinboundinterface as ct
        set 
            status = null_cvxcode.status,
            comments = coalesce(null_cvxcode.comments, ct.comments)
        from 
            null_cvxcode
        where
            ct.crispinboundinterfaceid  = null_cvxcode.crispid;
        IF V_DEBUG then raise notice 'null cvxcode check  end %', timeofday(); end if;
        
        ---------------------------------------------------------
        -- Unknown Client ID: studentno is unknown for CJAMS
        -- Provided studentno is not known for CJAMS system. (person table)
        ---------------------------------------------------------
        IF V_DEBUG then raise notice 'unknown studentno check %',timeofday(); end if;
        with invalid_studentno as (
            select cit.crispinboundinterfaceid as crispid,
                'PARENT_INVALID_STUDNO' as status,
                concat(coalesce(cit.comments, ''), '| studentno is not in CJAMS | ') as comments
            from 
                crispinboundinterface cit
            left join person pr on
                cit.studentno  = pr.cjamspid and pr.activeflag = 1
            where pr.cjamspid is null
                and cit.studentno is not null
        )
        update crispinboundinterface as ct
        set 
            status = coalesce(invalid_studentno.status, ct.status),
            comments = coalesce(invalid_studentno.comments, ct.comments)
        from 
            invalid_studentno
        where ct.crispinboundinterfaceid = invalid_studentno.crispid;
        IF V_DEBUG then raise notice 'unknown studentno check end %', timeofday(); end if;
        ---------------------------------------------------------
        -- Unknown CVX Code: CVX Code is unknown for CJAMS
        -- Provided CVX Code is not known for CJAMS system. (crispconfig table)
        ---------------------------------------------------------
        IF V_DEBUG then raise notice 'unknown cvx check %', timeofday(); end if;
        with invalid_cvxs as (
            select cit.crispinboundinterfaceid,
                case when cit.status is null then 'PARENT_INVALID_CVXCD' end as status,
                concat(coalesce(cit.comments, ''), '| cvxcode is not in CJAMS | ') as comments
            from
                crispinboundinterface cit
            left join crispconfig cc on 
                cit.cvxcode = cc.cvxcode
            where
                cc.cvxcode is null  
        )
        update crispinboundinterface as ct
        set 
            status = coalesce(invalid_cvxs.status, ct.status),
            comments = coalesce(invalid_cvxs.comments, ct.comments)
        from
            invalid_cvxs
        where ct.crispinboundinterfaceid = invalid_cvxs.crispinboundinterfaceid;
        IF V_DEBUG then raise notice 'unknown cvx check end %' ,timeofday(); end if;

        ---------------------------------------------------------
        -- Removed CRISP records - If the immunization id from the crisp is removed,
        -- we need to set those records activeflag as 0
        ---------------------------------------------------------
        IF V_DEBUG then raise notice 'deleted ids check %', timeofday(); end if;
        
        with crisp_removed_ids as (
            select distinct pim.sourcesystemprimarykey, pim.personimmunizationid
            from personimmunization pim 
                join person pr on pim.personid = pr.personid 
                inner join crispinboundinterface ci on ci.studentno = pr.cjamspid
            where pim.sourcesystem = 'CRISP' and not exists (select 1 from crispinboundinterface where studentno = pr.cjamspid and
                immunizationid = pim.sourcesystemprimarykey and activeflag = 1
            )
                and pim.activeflag = 1 and ci.activeflag = 1
        )
        select count(*) into DELETED_CNT from crisp_removed_ids;
        IF V_DEBUG then raise notice 'deleted ids count %', DELETED_CNT; end if;

        IF DELETED_CNT > 1 then
            with crisp_removed_ids as (
                select distinct pim.sourcesystemprimarykey, pim.personimmunizationid
                from personimmunization pim 
                    join person pr on pim.personid = pr.personid 
                    inner join crispinboundinterface ci on ci.studentno = pr.cjamspid
                where pim.sourcesystem = 'CRISP' and not exists (select 1 from crispinboundinterface where studentno = pr.cjamspid and
                    immunizationid = pim.sourcesystemprimarykey and activeflag = 1
                )
                    and pim.activeflag = 1 and ci.activeflag = 1
            )
            update personimmunization as pimc
            set 
                activeflag = 0,
                updatedby = 'CRISP_INBOUND',
                updatedon = now(),
                comments = concat('Record removed by CRISP | ', comments)
            where pimc.personimmunizationid in (select personimmunizationid from crisp_removed_ids);
        ELSE
            RAISE NOTICE 'deleted ids count is 0';
        END IF;
        IF V_DEBUG then raise notice 'deleted ids check end %' , timeofday(); end if;
        

        ---------------------------------------------------------
        -- Handle update(s) are handled in the common error block.
        -- All queries above are straightforward, so handling the error
        -- common error block instead of individual errors.
        ---------------------------------------------------------
        EXCEPTION WHEN OTHERS THEN
            VS_OUTPUT_STATE := SQLSTATE;
            VL_OUTPUT_SQLCODE := SQLERRM;
            VS_MESSAGE := 'Update FAILED on crispinboundinterface';    
            VL_EXCEP_FLAG := 1;
            VS_SUCCESS_SW := 'N';
        
            RAISE NOTICE 'crispinboundinterface UPDATE ERROR';
            -- Add it to error interface for better error debugging
            INSERT INTO interfaceserrorlog( 
                interfaceid, 
                currentruntimestamp, 
                batchnumber, 
                errorlineno, 
                errorcode, 
                errorsqlcode, 
                errordescription
            ) 
            VALUES (
                'CRISP_INBOUND', 
                current_timestamp, 
                CAST(VS_BATCH_NO AS int), 
                192, 
                VS_ERROR_CODE, 
                VL_OUTPUT_SQLCODE, 
                VS_ERROR_DESC
            );
        RETURN;
    END;    
    BEGIN
        CRISP_INBOUND_CHILD_CNT := (SELECT cast(count(*)AS integer) from crispcjamsflattenedinbound);
        
        RAISE NOTICE 'No. of count in crispcjamsflattenedinbound %', CRISP_INBOUND_CHILD_CNT;
        BEGIN
            IF CRISP_INBOUND_CHILD_CNT > 0 THEN
                INSERT INTO crispcjamsflattenedinbound_iss
                (
                    crispcjamsflattenedinboundid,
                    immunizationid,
                    personimmunizationconfigid,
                    personimmunizationid,
                    status,
                    crispinboundid,
                    vaccinationdate,
                    lastupdateddt,
                    cvxcode,
                    dose,
                    clientid,
                    agetype,
                    startdose,
                    enddose,
                    totaldose,
                    currentdose,
                    batchlogid
                ) SELECT
                    crispcjamsflattenedinboundid,
                    immunizationid,
                    personimmunizationconfigid, 
                    personimmunizationid,
                    status,
                    crispinboundid,
                    vaccinationdate,
                    lastupdateddt,
                    cvxcode,
                    dose,
                    clientid,
                    agetype,
                    startdose,
                    enddose,
                    totaldose,
                    currentdose,
                    batchlogid
                from crispcjamsflattenedinbound;

            
            delete from crispcjamsflattenedinbound;
            end if;


        EXCEPTION WHEN OTHERS THEN
            VS_OUTPUT_STATE := SQLSTATE;
            VL_OUTPUT_SQLCODE := SQLERRM;
            VS_MESSAGE := 'Error processing the crispcjamsflattenedinbound table';    
            VL_EXCEP_FLAG := 1;
            VS_SUCCESS_SW := 'N';
        RETURN;
        END;
        
        ------------------------------------------------------
        -- No Changes in Crispinboundinterface 
        -- Before processing the child table, we will find the sourcesystem,
        -- sourcesystemupdatetimestamp, vaccinationdt - meaning we have this date already.
        ------------------------------------------------------
        IF V_DEBUG THEN raise notice 'no change in crispinboundinterface %', timeofday(); END IF;
        update crispinboundinterface as ci
        set
            status = 'NO_CHANGE',
            comments = 'No update from CRISP'
        from personimmunization pimc
        where ci.immunizationid = pimc.sourcesystemprimarykey
        and ci.status is null and ci.comments is null
        and pimc.sourcesystem = 'CRISP' 
        and pimc.activeflag = 1
		and ci.activeflag = 1
        and pimc.sourcesystemupdatetimestamp = ci.lastupdateddt
        and DATE(ci.vaccinationdt) = DATE(pimc.immunizationdate);
        IF V_DEBUG THEN raise notice 'no change in crispinboundinterface end %', timeofday(); END IF;


        ---------------------------------------------
        -- Child table processing
        ---------------------------------------------
        IF V_DEBUG THEN raise notice 'child table processing %', timeofday(); END IF;
        BEGIN
            WITH childdata as (
                    select 
                    ci.immunizationid,
                    ci.immunizationid as personimmunizationid,
                    ci.status, --status
                    ci.crispinboundinterfaceid as crispinboundid,
                    ci.vaccinationdt as vaccinationdate,
                    ci.lastupdateddt as lastupdateddt,
                    ci.cvxcode,
                    ci.studentno as clientid,
                    pr.personid,
                    null -- dose
                    from crispinboundinterface ci
                        inner join person pr on
                        ci.studentno = pr.cjamspid 
                    where pr.activeflag = 1 and (ci.status is null or ci.status = 'NO_CHANGE') and ci.activeflag = 1
                )
                insert into crispcjamsflattenedinbound (
                                immunizationid,
                                personimmunizationconfigid,
                                status,
                                crispinboundid,
                                vaccinationdate,
                                lastupdateddt,
                                cvxcode,
                                clientid,
                                personid,
                                immunizationkey,
                                batchlogid
                            ) 
                SELECT 
                        cd.immunizationid,
                        pimc.personimmunizationconfigid,
                        cd.status, -- status,
                        cd.crispinboundid,
                        cd.vaccinationdate,
                        cd.lastupdateddt,
                        cd.cvxcode,
                        cd.clientid,
                        cd.personid,
                        cc.immunizationkey,
                        CAST(VS_BATCH_NO AS int)
               FROM childdata cd
                left join crispconfig cc
                  on cc.cvxcode = cd.cvxcode
                left join personimmunizationconfig pimc on pimc.immunizationkey = cc.immunizationkey
				where pimc.activeflag = 1 and cc.activeflag = 1;
                -- exclude the boosters, two shots, we consider all crisp covid vaccines as single shot.
                -- and pimc.personimmunizationconfigid not in (select personimmunizationconfigid from personimmunizationconfig where immunizationkey = 'CV19' and (description ilike '%Booster%' or description ilike '%Two Shot%')  and activeflag = 1);

            EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                VS_MESSAGE := 'Error processing the crispcjamsflattenedinbound table';    
                VL_EXCEP_FLAG := 1;
                VS_SUCCESS_SW := 'N';
            RETURN;
        end;
        IF V_DEBUG THEN raise notice 'child table processing end %', timeofday(); END IF;

        CRISP_INBOUND_CHILD_CNT := (SELECT cast(count(*)AS integer) from crispcjamsflattenedinbound);
        RAISE NOTICE 'crispcjamsflattenedinbound after insert %', CRISP_INBOUND_CHILD_CNT;

        ----------------------------------------------
        -- Duplicate records in child table based on the
        -- personid, personimmunizationconfigid, vaccinationdate, newdose
        ----------------------------------------------
        with child_duplicates as (
            select cc.personid, 
                cc.personimmunizationconfigid, 
                cc.vaccinationdate,
                cc.crispcjamsflattenedinboundid,
                row_number() over (partition by cc.personid, cc.personimmunizationconfigid, cc.vaccinationdate order by cc.status desc nulls last) as row_num
                from crispcjamsflattenedinbound cc
        )
        update cjams.crispcjamsflattenedinbound as c
        set status = 'DUPLICATE_CRISP_REC',
        comments = 'Same vaccine and date with different immunization id or CVX code. It will be loaded as duplicate record in CJAMS.'
        from child_duplicates cd
        where c.crispcjamsflattenedinboundid = cd.crispcjamsflattenedinboundid
        and cd.row_num > 1 and c.status is null;

       ----------------------------------------------
        -- if the personimmunizationconfigid is null, the reocrds will be rejected.
        ----------------------------------------------
        IF V_DEBUG THEN raise notice 'personimmunizationconfigid is null%', timeofday(); END IF;
        UPDATE crispcjamsflattenedinbound as c
        set 
            status = 'CONFIGID_NOT_FOUND',
            comments = concat('{"CONFIGID_NOT_FOUND": {"CVXCODE":"', c.cvxcode, '"}}')
        where
            c.personimmunizationconfigid is null and c.status is null;
        IF V_DEBUG THEN raise notice 'personimmunizationconfigid is null end %', timeofday(); END IF;

        -----------------------------------------------------
        -- update the child table for errors even if one is ERR
        -----------------------------------------------------
        IF V_DEBUG THEN raise notice 'error if one error in flattened'; END IF;
        update crispcjamsflattenedinbound 
        set status = 'CHILD_REJ_REL_CVX', 
        comments = concat('ERROR-CHILD_REJ_REL_CVX: CVXCODE - ', cvxcode,  ' CJAMSVAC - ' || immunizationkey, ' AGETYPE - '||agetype)
        where crispinboundid in (
            select ccfi.crispinboundid
                from crispcjamsflattenedinbound ccfi
                where ccfi.status is not null 
                group by ccfi.crispinboundid) 
        and status is null;
        IF V_DEBUG THEN raise notice 'error if one error in flattened end %', timeofday(); END IF;

        IF V_DEBUG THEN raise notice 'vacc_date update in child table... %', timeofday(); END IF;
        ---------------------------------------------------------------------
        -- VACC_DT_UPDATED - if the immunizationid is present, we just update the vaccination
        -- date
        ---------------------------------------------------------------------
        with vaccdt_updated_crispids as (
            update personimmunization pim
            set 
                immunizationdate = ci.vaccinationdate,
                sourcesystemupdatetimestamp = ci.lastupdateddt,
                updatedby = 'CRISP_INBOUND',
                updatedon = now()
            from crispcjamsflattenedinbound ci
            where ci.immunizationid = sourcesystemprimarykey
            and pim.sourcesystemprimarykey is not null
			and (pim.immunizationdate != ci.vaccinationdate)
            and pim.activeflag = 1
            and (pim.recordstatus != 1 or pim.recordstatus is null) -- we will ignore the rejected records to keep it as rejected.
            and pim.sourcesystem = 'CRISP'
            and pim.updatedby = 'CRISP_INBOUND'
            returning ci.crispcjamsflattenedinboundid
        )
        update crispcjamsflattenedinbound ci
        SET 
            status = 'VACC_DT_UPDATED',
            comments = 'CRISP sent updated vaccination date for an existing record.'
        from vaccdt_updated_crispids vuc
        where
            ci.crispcjamsflattenedinboundid = vuc.crispcjamsflattenedinboundid
            and status is null;
        IF V_DEBUG THEN raise notice 'vacc_date update in child table end... %', timeofday(); END IF;

        IF V_DEBUG THEN raise notice 'vacc_date insert in child table... %', timeofday(); END IF;
        ---------------------------------------------------------------------
        -- VACC_DT_UPDATED - if the immunizationid is present, we just update the vaccination
        -- date
        ---------------------------------------------------------------------
        with vaccdt_inserted_crispids as (
            INSERT INTO personimmunization (
	                personid, -- personid
	                immunizationdate,
	                personimmunizationconfigid,
	                sourcesystem,
	                sourcesystemprimarykey,
	                sourcesystemupdatetimestamp,
	                dose,
	                updatedby,
	                updatedon,
	                insertedby,
	                insertedon
	        ) 
            select  ci.personid,
                    ci.vaccinationdate,
                    ci.personimmunizationconfigid,
                    'CRISP',
                    ci.immunizationid,
                    ci.lastupdateddt,
                    case
                        -- covid vaccine dosage is considered as 'single shot vaccine'
                        when ci.personimmunizationconfigid = (select personimmunizationconfigid from personimmunizationconfig where immunizationkey = 'CV19' and activeflag = 1 and description ilike '%Single%'
                        ) then 'single'
                        else null
                    end as dose,
                    'CRISP_INBOUND', -- updatedby
                    now(), -- updatedon
                    'CRISP_INBOUND', -- insertedby
                    now()-- insertedon,
            from crispcjamsflattenedinbound ci
            join personimmunization pim
            on ci.immunizationid = pim.sourcesystemprimarykey
            where (pim.immunizationdate != ci.vaccinationdate)
            and pim.activeflag = 1
            and pim.recordstatus = 1
            and pim.sourcesystem = 'CRISP'
            and pim.sourcesystemprimarykey is not null
            and not exists (select 1 from personimmunization pim where pim.personid = ci.personid
	                                and pim.personimmunizationconfigid = ci.personimmunizationconfigid
	                                and DATE(pim.immunizationdate) = DATE(ci.vaccinationdate) and pim.activeflag = 1 and (pim.recordstatus != 1 or pim.recordstatus is null))
            returning sourcesystemprimarykey
        )
        update crispcjamsflattenedinbound as ct
            set
                status = 'SUCCESS',
                comments = concat('SUCCESS_VACC_UPDATE: CVXCODE - ', ct.cvxcode, ', CJAMSVAC -', ct.immunizationkey)
        from vaccdt_inserted_crispids
        where ct.immunizationid = sourcesystemprimarykey
        and ct.status is null;

        IF V_DEBUG THEN raise notice 'vacc_date insert in child table end... %', timeofday(); END IF;


        ----------------------------------------------
        -- if the currentdose count is 0, no record in CJAMS. Directly insert to personimmunization
        ----------------------------------------------
        IF V_DEBUG THEN raise notice 'inserting.... %', timeofday(); END IF;
        BEGIN
		with loadedrecords AS (
	            INSERT INTO personimmunization (
	                personid, -- personid
	                immunizationdate,
	                personimmunizationconfigid,
	                sourcesystem,
	                sourcesystemprimarykey,
	                sourcesystemupdatetimestamp,
	                dose,
	                updatedby,
	                updatedon,
	                insertedby,
	                insertedon
	            ) 
	            select  ct.personid,
	                    ct.vaccinationdate,
	                    ct.personimmunizationconfigid,
	                    'CRISP',
	                    ct.immunizationid,
	                    ct.lastupdateddt,
	                    case
	                        -- covid vaccine dosage is considered as 'single shot vaccine'
	                        when ct.personimmunizationconfigid = (select personimmunizationconfigid from personimmunizationconfig where immunizationkey = 'CV19' and activeflag = 1 and description ilike '%Single%'
                            ) then 'single'
	                        else null
	                    end as dose,
	                    'CRISP_INBOUND', -- updatedby
	                    now(), -- updatedon
	                    'CRISP_INBOUND', -- insertedby
	                    now()-- insertedby,
	                from crispcjamsflattenedinbound ct
	                where ct.status is null 
	                and ct.comments is null 
                    and not exists (select 1 from personimmunization pim where pim.personid = ct.personid
	                                and pim.personimmunizationconfigid = ct.personimmunizationconfigid
	                                and DATE(pim.immunizationdate) = DATE(ct.vaccinationdate) and pim.activeflag = 1 and (pim.recordstatus != 1 or pim.recordstatus is null))
                returning sourcesystemprimarykey
	        )
			update crispcjamsflattenedinbound as ct
                set
                    status = 'SUCCESS',
                    comments = concat('SUCCESS: CVXCODE - ', ct.cvxcode, ', CJAMSVAC -', ct.immunizationkey)
			from loadedrecords
			where ct.immunizationid = sourcesystemprimarykey
			and ct.status is null;

        EXCEPTION WHEN OTHERS THEN
            VS_OUTPUT_STATE := SQLSTATE;
            VL_OUTPUT_SQLCODE :=SQLERRM;
            VS_MESSAGE := 'Error processing the crispcjamsflattenedinbound insert';    
            VL_EXCEP_FLAG := 1;
            VS_SUCCESS_SW := 'N';
        RETURN;

        END;
        IF V_DEBUG THEN raise notice 'inserting end... %', timeofday(); END IF;

        ----------------------------------------------------------------------
        -- Update the vaccination dose correctly based on the vaccination date and dose
        ----------------------------------------------------------------------
        IF V_DEBUG THEN raise notice 'looping... %', timeofday(); END IF;
        CRISP_INBOUND_CNT := (SELECT CAST(COUNT(*) AS INTEGER) FROM crispcjamsflattenedinbound c
                   where c.status is null);
    
        RAISE NOTICE 'No. of records in crispinboundinterface looping %', CRISP_INBOUND_CNT;

        BEGIN
            FOR INBOUND_RECORD IN
                SELECT 
                    c.crispcjamsflattenedinboundid,
                    c.immunizationid,
                    c.personimmunizationconfigid,
                    c.vaccinationdate,
                    c.lastupdateddt,
                    c.cvxcode,
                    c.personid
                FROM crispcjamsflattenedinbound c
                where c.status is null
            LOOP
                ---------------------------------------------------------------------
                -- Check if vaccinatuon record already present in CJAMS. If so, we find the person and 
                -- update the personimmunization records for the user.
                -- Assumption: For a vaccine, we will have one vaccination date. (Same vaccine cannot have 2 doses on the same day.)
                ---------------------------------------------------------------------
                SELECT pim.personimmunizationid, pim.sourcesystem into V_RECORD_IMMUNIZATION_ID, V_RECORD_SOURCESYSTEM FROM
                    personimmunization pim WHERE 
                    pim.personid = INBOUND_RECORD.personid
                    AND pim.personimmunizationconfigid = INBOUND_RECORD.personimmunizationconfigid::uuid
                    and DATE (pim.immunizationdate) = DATE(INBOUND_RECORD.vaccinationdate)
					and pim.activeflag=1;
                IF (V_RECORD_IMMUNIZATION_ID) IS NOT NULL then
                    IF (V_RECORD_SOURCESYSTEM) IS NULL then
                        UPDATE personimmunization
                        SET 
                            sourcesystem = 'CRISP',
                            sourcesystemprimarykey = INBOUND_RECORD.immunizationid,
                            sourcesystemupdatetimestamp = INBOUND_RECORD.lastupdateddt
							,updatedon=now(), updatedby='CRISP_INBOUND' 
                        WHERE personimmunizationid = V_RECORD_IMMUNIZATION_ID and 
                        activeflag = 1;
                        UPDATE crispcjamsflattenedinbound 
                        SET 
                            status = 'UPDATED_CRISPID',
                            comments = 'Updated Existing CJAMS Record with Immunization ID'
                        where
                            crispcjamsflattenedinboundid = INBOUND_RECORD.crispcjamsflattenedinboundid;
                    ELSE
                        UPDATE crispcjamsflattenedinbound 
                        SET 
                            status = 'DUPLICATE_REC_ELSE',
                            comments = 'Duplicate record exists in CJAMS.'||coalesce(V_RECORD_SOURCESYSTEM,'NULL_SRC_SYS')
                        where
                            crispcjamsflattenedinboundid = INBOUND_RECORD.crispcjamsflattenedinboundid;
                    END IF;
                END IF; 
            END LOOP;
  
              -------------------------------------------------
                -- update the parent table (crispinboundtable) for errors
                -------------------------------------------------
                WITH status_counts AS (
                    SELECT crispinboundid,
                        status,
                        comments,
                        count(*) AS status_count
                    FROM crispcjamsflattenedinbound
                    GROUP BY crispinboundid, status, comments
                ), comments_summary AS (
                    SELECT crispinboundid,
                        string_agg(comments, ' , ') AS summary,
                        max(status) AS max_status
                    FROM status_counts 
                    GROUP BY crispinboundid 
                ),
                  status_summary AS (
                    SELECT crispinboundid, string_agg( status ,' - ') status 
                    FROM (
                        SELECT distinct crispinboundid, status
                        FROM status_counts
                        order by 1,2
                    ) ranked
                    group by 1
                )
                UPDATE crispinboundinterface AS ci
                SET 
                    COMMENTS = s.summary,
                    status  = m.status
                FROM comments_summary s
                JOIN status_summary m ON m.crispinboundid = s.crispinboundid
                WHERE ci.crispinboundinterfaceid = s.crispinboundid
                and ci.status is null;
        EXCEPTION WHEN OTHERS THEN
            VS_OUTPUT_STATE := SQLSTATE;
            VL_OUTPUT_SQLCODE :=SQLERRM;
            VS_MESSAGE := 'Error processing the crispcjamsflattenedinbound loop';    
            VL_EXCEP_FLAG := 1;
            VS_SUCCESS_SW := 'N';
        RETURN;
        END;
			raise notice 'Begin History update.% ', timeofday();
  
      BEGIN
            FOR PERSONIMMUID_RECORD IN
                SELECT p.personimmunizationid from personimmunization p where p.updatedby = 'CRISP_INBOUND'
                and p.updatedon > MAX_BATCH_DATE and p.activeflag = 1
            loop
                select hist.vs_success_sw into HIST_SW_SUCCESS FROM cjams.generate_audit_data('personimmunization', PERSONIMMUID_RECORD.personimmunizationid::uuid) as hist;
            END LOOP;
            EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE := SQLERRM;
                VS_MESSAGE := 'Error encountered while calling the audit history function loop';    
                VL_EXCEP_FLAG := 1;
                VS_SUCCESS_SW := 'N';
            RETURN;
        END;
			raise notice 'End History update.% ', timeofday();

    BEGIN
        FOR STATS_RECORD IN
            SELECT 
                COUNT(*) AS total, 
                COUNT(DISTINCT studentno) AS uniq,
                COUNT(CASE WHEN status = 'NON_PILOT_COUNTY' THEN 1 END) AS nonpilot,
                COUNT(CASE WHEN status <> 'NON_PILOT_COUNTY' THEN 1 END) AS pilot,
                COUNT(DISTINCT CASE WHEN status = 'NON_PILOT_COUNTY' THEN studentno END) AS nonpilot_dist,
                COUNT(DISTINCT CASE WHEN status <> 'NON_PILOT_COUNTY' THEN studentno END) AS pilot_dist
            FROM crispinboundinterface c
        LOOP
            RAISE NOTICE 'Inbound Records: % | Inbound Unique Records: % | Inbound Non Pilot Records: % | Inbound Pilot Records: % | Inbound Non Pilot Unique Records: % | Inbound Pilot Unique Records: %', STATS_RECORD.total, STATS_RECORD.uniq, STATS_RECORD.nonpilot, STATS_RECORD.pilot, STATS_RECORD.nonpilot_dist, STATS_RECORD.pilot_dist;
	    END LOOP;
    END;
  END;
    RAISE NOTICE 'VL_EXCEP_FLAG % ',VL_EXCEP_FLAG;
    IF  VL_EXCEP_FLAG != 1 THEN 
        VS_OUTPUT_STATE :='00000';
        VS_MESSAGE := 'THE RUN WAS SUCCESSFUL';
        VS_SUCCESS_SW := 'Y';
    else
        VS_SUCCESS_SW :='N'; 
    END IF;
    RAISE NOTICE 'END Time % ', timeofday();
    EXCEPTION WHEN OTHERS THEN
            VS_OUTPUT_STATE := SQLSTATE;
            VL_OUTPUT_SQLCODE :=SQLERRM;
            VS_MESSAGE := 'crisp_load_inbound_interface failed';    
            VL_EXCEP_FLAG := 1;
            VS_SUCCESS_SW := 'N';
        RETURN;
END;
$function$
;
