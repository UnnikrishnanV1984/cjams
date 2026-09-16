drop function if exists crisp_outbound_interface(CHARACTER varying, date);

CREATE OR REPLACE FUNCTION crisp_outbound_interface(
    vs_batch_no CHARACTER varying,
    vdt_date date,
    OUT vs_success_sw CHARACTER varying,
    OUT vl_output_sqlcode CHARACTER varying, 
    OUT vs_message CHARACTER varying
)
-------------------------------------------------------------
-- B-193551 - Immunet Interface (CRISP)
-- Description - To Create CRISP Interface data
-- Params: (::vs_batch_no CHARACTER varying, ::vdt_date date) eg ('1', current_date);
-- Summary:
    -- 1. If crispoutboundinterface has record, then insert all records to iss table.
    -- 2. Delete the crispoutboundinterface table
    -- 3. Insert all generated data to crispoutboundtable
-- Revision(s):
--------------------------------------------------------------
LANGUAGE plpgsql
AS $$
DECLARE
    CRISP_OUTBOUND_ROW_COUNT		BIGINT;
	CRISP_OUTBOUND_CNT 				BIGINT;
    CRISP_OUTBOUND_DISTINCT_CNT     BIGINT;
    VS_OUTPUT_STATE             	VARCHAR(5) DEFAULT '00000';
	VL_EXCEP_FLAG               	INTEGER DEFAULT 0;
	VL_EXCEP_MESSAGE            	VARCHAR DEFAULT '';
	VS_ERROR_DESC					VARCHAR DEFAULT '';
	VS_ERROR_CODE					VARCHAR DEFAULT '000';
BEGIN
        VS_BATCH_NO := VS_BATCH_NO;
        RAISE NOTICE 'Start: crisp_outbound_interface % ', timeofday();
        VL_EXCEP_FLAG  := 0;
        VL_EXCEP_MESSAGE := '';
        CRISP_OUTBOUND_CNT := (SELECT cast(count(*)AS integer) FROM crispoutboundinterface);
        
        
        -- RAISE NOTICE 'COUNT %', CRISP_OUTBOUND_CNT;
        ----------------------------------------------------------
        -- Only if the outboundinterface has any records, else we don't need to move
        -- from outboundinterface to outboundinterface_iss (history)
        ----------------------------------------------------------
        IF CRISP_OUTBOUND_CNT > 0 THEN
            BEGIN
                    INSERT INTO crispoutboundinterface_iss 
                    (
                        crispoutboundinterfaceid,
                        groupname,
                        memberstatus,
                        patientid, 
                        firstname, 
                        middlename,
                        lastname,
                        namesuffix, 
                        address1,
                        address2, 
                        city, 
                        state, 
                        zip,
                        birthdate,
                        gender,
                        ssnno,
                        homephone,
                        workphone,
                        cellphone,
                        practice,
                        location,
                        pcp,
                        npi,
                        taxid,
                        insurance,
                        aco,
                        accountnumber,
                        ensstartdate,
                        careprogram,
                        careprogramstartdt,
                        careprogramenddt,
                        caremanager,
                        caremanagerphone,
                        caremanageremail,
                        ldss,
                        casesupervisor,
                        casesupervisorphone,
                        casesupervisoremail, 
                        riskscore1,
                        riskmethodology1,
                        riskscore2,
                        riskmethodology2,
                        region,
                        directemail,
                        dochaloid,
                        followupdate,
                        appointmentmisseddate,
                        carealert,
                        assigningauthoritycode,
                        batchlogid,
                        insertedby, 
                        insertedon,
                        updatedby,
                        updatedon
                    ) SELECT
                        crispoutboundinterfaceid,
                        groupname,
                        memberstatus,
                        patientid, 
                        firstname, 
                        middlename,
                        lastname,
                        namesuffix, 
                        address1,
                        address2, 
                        city, 
                        state, 
                        zip,
                        birthdate,
                        gender,
                        ssnno,
                        homephone,
                        workphone,
                        cellphone,
                        practice,
                        location,
                        pcp,
                        npi,
                        taxid,
                        insurance,
                        aco,
                        accountnumber,
                        ensstartdate,
                        careprogram,
                        careprogramstartdt,
                        careprogramenddt,
                        caremanager,
                        caremanagerphone,
                        caremanageremail,
                        ldss,
                        casesupervisor,
                        casesupervisorphone,
                        casesupervisoremail,
                        riskscore1,
                        riskmethodology1,
                        riskscore2,
                        riskmethodology2,
                        region,
                        directemail,
                        dochaloid,
                        followupdate,
                        appointmentmisseddate,
                        carealert,
                        assigningauthoritycode,
                        batchlogid,
                        insertedby, 
                        insertedon,
                        updatedby,
                        updatedon
                    FROM crispoutboundinterface;

            
                EXCEPTION WHEN OTHERS then
                    VS_OUTPUT_STATE := SQLSTATE;
                    VL_OUTPUT_SQLCODE := SQLERRM;
                    VS_MESSAGE := 'INSERT FAILED FROM crispoutboundinterface_iss';    
                    VL_EXCEP_FLAG := 1;
                    VS_ERROR_DESC := 'crispoutboundinterface_iss Insert Failed';
                    VS_ERROR_CODE := '000';
        
                    RAISE NOTICE 'crispoutboundinterface_iss INSERT Failed % | Batch No.  % | Check interfaceserrorlog Table for more info', VL_OUTPUT_SQLCODE, VS_BATCH_NO;
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
                        'CRISP_OUTBOUND_SP', 
                        current_timestamp, 
                        VS_BATCH_NO, 
                        484, 
                        VS_ERROR_CODE, 
                        VL_OUTPUT_SQLCODE, 
                        VS_ERROR_DESC
                    );
                RETURN;             
            END;
            -----------------------------------------------
            -- Delete the main table for loading new table.
            -----------------------------------------------
            BEGIN
                DELETE FROM crispoutboundinterface;
            EXCEPTION WHEN OTHERS then
                    VS_OUTPUT_STATE := SQLSTATE;
                    VL_OUTPUT_SQLCODE := SQLERRM;
                    VS_MESSAGE := 'delete FAILED FROM crispoutboundinterface';     
                    VL_EXCEP_FLAG := 1;
                    VS_ERROR_CODE := '000';
                    VS_SUCCESS_SW := 'N';
                    RAISE NOTICE 'delete FAILED FROM crispoutboundinterface % | Batch No: % | Check interfaceserrorlog Table for more info ', VL_OUTPUT_SQLCODE , VS_BATCH_NO;
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
                            'CRISP_OUTBOUND_SP', 
                            current_timestamp, 
                            VS_BATCH_NO, 
                            484, 
                            VS_ERROR_CODE, 
                            VL_OUTPUT_SQLCODE, 
                            VS_ERROR_DESC
                        );
            END;
        END IF;
    
       BEGIN
            with removals as (
                    select groupname,
                        memberstatus,
                        patientid,
                        firstname,
                        middlename,
                        lastname,
                        namesuffix,
                        address1,
                        address2,
                        city,
                        state,
                        zip,
                        birthdate,
                        gender,
                        ssn,
                        homephone,
                        workphone,
                        cellphone,
                        practice,
                        location,
                        pcp,
                        npi,
                        taxid,
                        insurance,
                        aco,
                        accountnumber,
                        ensstartdate,
                        careprogram,
                        careprogramstartdt,
                        careprogramenddt,   
                        (select up.fullname 
                            from userprofile up
                        where up.securityusersid = tab.toworkeridno
                        ) as caremanager,
                        (select NULLIF(regexp_replace(upf.phonenumber, '\D','','g'), '')
                            from userprofilephonenumber upf
                        where upf.securityusersid = tab.toworkeridno
                            and upf.activeflag = 1 
                        order by upf.insertedon desc
                        limit 1
                        ) as caremanagerphone,
                        (select up.email 
                            from userprofile up
                        where up.securityusersid = tab.toworkeridno
                        ) as caremanageremail,
                        NULL as riskscore1,
                        NULL as riskmethodology1,
                        NULL as riskscore2,
                        NULL as riskmethodology2,
                        NULL as region,
                        NULL as directemail,
                        NULL as dochaloid,
                        NULL as followupdate,
                        NULL as appointmentmisseddate,
                        NULL as carealert,
                        NULL as assigningauthoritycode,
                        intakeservreqchildremovalid,
                        removal_date, 
                        removal_exit_date,
                        personid,
                        LDSS as ldss,
                        (select sup.fullname 
                            from userprofile up,
                                userprofile sup
                        where up.securityusersid = tab.toworkeridno
                            and sup.securityusersid = up.supervisorid
                        ) as casesupervisor,
                        (select NULLIF(regexp_replace(upf.phonenumber, '\D','','g'), '')
                            from userprofile up,
                                userprofile sup,
                                userprofilephonenumber upf
                        where up.securityusersid = tab.toworkeridno
                            and upf.securityusersid = up.supervisorid
                        order by upf.insertedon desc
                        limit 1
                        ) as casesupervisorphone,
                        (select sup.email 
                            from userprofile up,
                                userprofile sup
                        where up.securityusersid = tab.toworkeridno
                            and sup.securityusersid = up.supervisorid
                        ) as casesupervisoremail
                    from (  
                    select NULL as groupname,
                        NULL as memberstatus,
                        pr.cjamspid as patientid,
                        pr.firstname as firstname,
                        pr.middlename as middlename,
                        pr.lastname as lastname,
                        NULL as namesuffix,
                        '' as address1,
                        '' as address2,
                        '' as city,
                        '' as state,
                        '' as zip,
                        pr.dob::date as birthdate,
                        (case when pr.gendertypekey = 'M' Then	-- Male
                            'MALE' 
                        when pr.gendertypekey = 'TGIF' Then -- Transgender- Identifies as Female
                            'MALE' 
                        when pr.gendertypekey = 'TGIM' Then -- Transgender- Identifies as Male
                            'FEMALE' 
                        when pr.gendertypekey = 'F' Then -- Female  
                            'FEMALE' 
                        else
                            null -- O Other
                        end ) as gender,
                        NULLIF(regexp_replace(pr.ssnno, '\D','','g'), '') as ssn,
                        NULL as homephone,
                        NULL as	workphone,
                        NULL as cellphone,
                        NULL as practice,
                        NULL as location,
                        NULL as pcp,
                        NULL as npi,
                        NULL as taxid,
                        NULL as insurance,
                        NULL as aco,
                        (select prn.medicarenumber
                            from personhealthinsurance prn 
                        where prn.personid = pr.personid 
                            and prn.activeflag  = 1
                            and prn.insurancetype = 'MEDIC' -- Medicaid
                        order by prn.insertedon desc
                        limit 1) as accountnumber,
                        NULL as ensstartdate,
                        NULL as careprogram,
                        NULL as careprogramstartdt,
                        NULL as careprogramenddt,
                        coalesce(
                            (select c1.toworkeridno 
                                from caseassignment c1,
                                    caseassignmentactor c2,
                                    intakeservicerequestactor icr
                            where c1.objectid = rm.servicecaseid
                                and c1.caseassignmentid = c2.caseassignmentid
                                and icr.intakeservicerequestactorid = c2.intakeservicerequestactorid
                                and icr.personid = pr.personid
                                and lower(c1.responsibilitytypekey) = 'child'
                                and c1.activeflag = 1
                                and c2.activeflag = 1
                                and icr.activeflag = 1
                                and c1.enddate is null
                            order by c1.startdate desc  
                            limit 1
                            ),
                            (	select c1.toworkeridno 
                                    from caseassignment c1
                                where c1.objectid = rm.servicecaseid
                                    and lower(c1.responsibilitytypekey) = 'family'
                                    and c1.activeflag = 1
                                    and c1.enddate is null
                                order by c1.startdate desc  
                                limit 1 
                            ) 
                        ) as toworkeridno,
                        NULL as riskscore1,
                        NULL as riskmethodology1,
                        NULL as riskscore1,
                        NULL as riskmethodology2,
                        NULL as region,
                        NULL as directemail,
                        NULL as dochaloid,
                        NULL as followupdate,
                        NULL as appointmentmisseddate,
                        NULL as carealert,
                        NULL as assigningauthoritycode,
                        rm.intakeservreqchildremovalid,
                        rm.removaldate::date as removal_date, 
                        rm.exitdate::date as removal_exit_date,
                        rm.personid,
                        ( select c.countyname 
                            from caseassignment ca  
                                join county c on c.countyid:: character varying = ca.toldssid::character varying
                          where ca.objectid = rm.servicecaseid
                             and lower(ca.responsibilitytypekey) = 'family'
                                and ca.activeflag = 1
                          order by ca.insertedon desc
                          limit 1
                         ) as LDSS                  
                    from intakeservreqchildremoval rm
                        join person pr on pr.personid = rm.personid 
                            and pr.activeflag  = 1
                    where rm.activeflag  = '1'
                        and rm.removaldate is not null
                        and rm.exitdate is null
                        and ( select count(*) 
                                from routing rur
                            where rur.objectid = rm.intakeservreqchildremovalid::character varying
                                and rur.eventcode = 'CHRR'
                                and rur.activeflag = 1
                                and rur.routingstatustypeid = '16'
                            ) > 0
                        -- Unit Test
                        -- and rm.intakeservreqchildremovalid  = '006051d5-81c9-4a8b-af06-3c7cd8c0adee' 
                    ) tab ),
                    placements as (
                    select *,
                            (case when provadd.adr_format_cd = 'S' then 
                                coalesce(provadd.adr_street_tx,'') || ' ' ||
                                coalesce((	select coalesce(value_tx,'') 
										from tb_picklist_values 
									where trim(picklist_value_cd) in (trim(provadd.adr_pre_dir_cd)) 
										and picklist_type_id = '69'),'') || ' ' ||
								coalesce(provadd.adr_street_nm,'') || ' ' ||
								coalesce((	select coalesce(value_tx,'') 
                                        from tb_picklist_values 
                                    where trim(picklist_value_cd) in ( trim(provadd.adr_street_suffix_cd) ) 
                                        and picklist_type_id = '212'
                                ),'')
                            when provadd.adr_format_cd = 'R' then
                                coalesce('Rural Rte','') || ' ' ||
                                coalesce(provadd.adr_street_tx,'') || ' ' ||
                                (case when provadd.adr_box_no is not null then
                                    'Box Number ' || coalesce(provadd.adr_box_no :: character varying,'')
                                end)
                            when provadd.adr_format_cd = 'F' then
                                coalesce(provadd.adr_foreign_tx,'')
                            when provadd.adr_format_cd = 'P' then   
                                coalesce('PO Box','')  || ' ' ||
                                    coalesce(provadd.adr_box_no :: character varying,'')
                            when lgr.streetname is null then
                                'Unknown'
                            else -- LA
                                lgr.streetname      
                            end) as "address1",
                            
                            (case when tab_plc.provider_id is not null and provadd.adr_format_cd = 'S' then 
                                coalesce((	select value_tx 
                                                from tb_picklist_values 
                                            where trim(picklist_value_cd) in (trim(provadd.adr_unit_type_cd) )
                                            and picklist_type_id = '250'
                                        ),'') || ' ' ||
                                        coalesce(provadd.adr_unit_no_tx,'') 
                            when tab_plc.provider_id is not null and provadd.adr_format_cd = 'F' then           
                                provadd.adr_country_tx
                            else -- LA  
                                lgr.streettext  
                            end ) as "address2",
                            
                        (case when tab_plc.provider_id is not null then
                                provadd.adr_city_nm 
                            else -- LA
                                lgr.cityname
                            end ) as "city",

                            (case when tab_plc.provider_id is not null and provadd.adr_format_cd = 'F' then 
                                null
                            when tab_plc.provider_id is not null then   
                                provadd.adr_state_cd 
                            else   -- LA 
                                lgr.statetypekey    
                            end) as "state",
                            
                            (case when tab_plc.provider_id is not null and provadd.adr_format_cd = 'F' then
                                provadd.adr_postal_code_tx::character varying
                            when tab_plc.provider_id is not null then
                                provadd.adr_zip5_no::character varying 
                            else -- LA
                                lgr.zip5no::character varying   
                            end) as "zip",
                        -- Get the active placement as provider placement, else the living arrangement.
                        RANK() OVER(PARTITION BY tab_plc.intakeservreqchildremovalid
                                    order by
                                    (case when tab_plc.placement_exit_date is null 
                                        and tab_plc.provider_id is NOT null then 
                                            1 
                                     when tab_plc.placement_exit_date is null 
                                        and tab_plc.provider_id is null then 
                                            2 
                                     else 
                                            3     
                                    end)
                                    , tab_plc.placement_entry_date desc
                                    , tab_plc.alternateid desc
                            ) as placement_rnk
                    from (
                    select 'Public Provider Placement' as "Placement Type",
                        pl.alternateid,
                        pl.altproviderid as provider_id,
                        pl.startdatetime::date as placement_entry_date,
                        pl.enddatetime::date as placement_exit_date,
                        rm.intakeservreqchildremovalid,
                        null::uuid as livingid
                    from removals rm,
                        placement pl
                    WHERE pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
                        and pl.activeflag = 1
                        and COALESCE(pl.isvoided, 0) <> 1 
                        and pl.altproviderid is not null
                        and pl.contractprogramid is null -- Public Provider Placement
                        and (SELECT count(*) 
                                FROM routing
                            WHERE routing.routingstatustypeid = 16 
                                AND routing.eventcode::text = 'PLTR'::text 
                                AND routing.activeflag = 1 
                                AND routing.objectid::text = pl.placementid::character varying::text
                            ) > 0
                    union all
                    select 'Private Provider Placement' as "Placement Type",
                        pl.alternateid,
                        coalesce(cpa.altproviderid, pl.altproviderid) as provider_id,
                        coalesce(cpa.entrydt::date, pl.startdatetime::date) as placement_entry_date,
                        coalesce(cpa.exitdt::date,	pl.enddatetime::date) as placement_exit_date,
                        rm.intakeservreqchildremovalid,
                        null::uuid as livingid
                    from removals rm,
                        placement pl
                        left join placementcpahomes cpa on cpa.placementid = pl.placementid
                            and cpa.activeflag = 1
                            and cpa.entrydt is not null
                            and cpa.exitdt is null
                    WHERE pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
                        and pl.activeflag = 1
                        and COALESCE(pl.isvoided, 0) <> 1 
                        and pl.altproviderid is not null
                        and pl.contractprogramid is not null -- Private Provider Placement
                        and (SELECT count(*) 
                                FROM routing
                            WHERE routing.routingstatustypeid = 16 
                                AND routing.eventcode::text = 'PLTR'::text 
                                AND routing.activeflag = 1 
                                AND routing.objectid::text = pl.placementid::character varying::text
                            ) > 0 
                    union all   
                    select 'Living Arrangement' as "Placement Type",
                        pl.alternateid,
                        NULL as provider_id,
                        pl.startdatetime::date as placement_entry_date,
                        pl.enddatetime::date as placement_exit_date,
                        rm.intakeservreqchildremovalid,
                        la.livingid 
                    from removals rm,
                        placement pl,
                        livingarrangement la
                    where rm.personid = pl.personid
                        and pl.placementid = la.placementid
                        and pl.activeflag = 1
                        and la.activeflag = 1
                        and pl.altproviderid is null
                        and ( SELECT count(*) AS count
                                FROM routing
                            WHERE routing.routingstatustypeid = 16 
                                AND routing.eventcode::text = 'PLTR'::text 
                                AND routing.activeflag = 1 
                                AND routing.objectid::text = pl.placementid::character varying::text
                            ) > 0 
                        and pl.startdatetime::date <= coalesce(rm.removal_exit_date, current_date)
                        and (pl.enddatetime is null or pl.enddatetime::date >= rm.removal_date)
                        and btrim(la.livingarrangementtypekey) NOT In ('32944', 'PLMT', 'RNW', 'UNK', 'HMLS', 'ADPN')
                    ) tab_plc 
                        left join prov.tb_provider_addresses provadd on provadd.parent_key_id::bigint = tab_plc.provider_id
                            and provadd.delete_sw  = 'N'
                            and provadd.adr_type_cd = '3357' -- Provider location
                            and provadd.adr_default_sw = 'Y'
                        left join livingarrangement lgr on lgr.livingid  = tab_plc.livingid     
                            and lgr.activeflag = 1
                    order by tab_plc.intakeservreqchildremovalid, tab_plc.placement_entry_date desc 
            )       
            insert into crispoutboundinterface (
                groupname,
                memberstatus,
                patientid,
                firstname,
                middlename,
                lastname,
                namesuffix,
                address1,
                address2,
                city,
                state,
                zip,
                birthdate,
                gender,
                ssnno,
                homephone,
                workphone,
                cellphone,
                practice,
                location,
                pcp,
                npi,
                taxid,
                insurance,
                aco,
                accountnumber,
                ensstartdate,
                careprogram,
                careprogramstartdt,
                careprogramenddt,
                caremanager,
                caremanagerphone,
                caremanageremail,
                ldss,
                casesupervisor,
                casesupervisorphone,
                casesupervisoremail,
                riskscore1,
                riskmethodology1,
                riskscore2,
                riskmethodology2,
                region,
                directemail,
                dochaloid,
                followupdate,
                appointmentmisseddate,
                carealert,
                assigningauthoritycode,
                batchlogid,
                activeflag,
                insertedby, 
                insertedon,
                updatedby,
                updatedon   
            ) 
                    select rem.groupname,
                            rem.memberstatus,
                            rem.patientid,
                            rem.firstname,
                            rem.middlename,
                            rem.lastname,
                            rem.namesuffix,
                            coalesce(prpl.address1, 'Unknown') as address1,
                            prpl.address2,
                            prpl.city,
                            prpl.state,
                            prpl.zip,
                            rem.birthdate,
                            rem.gender,
                            rem.ssn,
                            rem.homephone,
                            rem.workphone,
                            rem.cellphone,
                            rem.practice,
                            rem.location,
                            rem.pcp,
                            rem.npi,
                            rem.taxid,
                            rem.insurance,
                            rem.aco,
                            rem.accountnumber,
                            rem.ensstartdate::timestamp,
                            rem.careprogram,
                            rem.careprogramstartdt::timestamp,
                            rem.careprogramenddt::timestamp,    
                            rem.caremanager,
                            rem.caremanagerphone,
                            rem.caremanageremail,
                            rem.ldss,
                            rem.casesupervisor,
                            rem.casesupervisorphone,
                            rem.casesupervisoremail,
                            rem.riskscore1,
                            rem.riskmethodology1,
                            rem.riskscore2,
                            rem.riskmethodology2,
                            rem.region,
                            rem.directemail,
                            rem.dochaloid,
                            rem.followupdate::timestamp,
                            rem.appointmentmisseddate::timestamp,
                            rem.carealert,
                            rem.assigningauthoritycode,
                            vs_batch_no::bigint,
                            1,
                            'CRISP_ADMIN',
                            now(),
                            'CRISP_ADMIN',
                            now()
                        from removals rem
                            left join placements prpl 
                                on rem.intakeservreqchildremovalid = prpl.intakeservreqchildremovalid
                                    and prpl.placement_rnk = 1
                        order by rem.patientid;

            
            CRISP_OUTBOUND_ROW_COUNT := (SELECT cast(count(*)AS integer) FROM crispoutboundinterface);
            CRISP_OUTBOUND_DISTINCT_CNT := (SELECT cast(count(distinct(patientid)) AS integer) FROM crispoutboundinterface);
            RAISE NOTICE 'TOTAL NUMBER IN OUTBOUND FILE: % | DISTINCT NUMBER %', CRISP_OUTBOUND_ROW_COUNT, CRISP_OUTBOUND_DISTINCT_CNT;
    
            EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE := SQLERRM;
                VS_MESSAGE := 'INSERT FAILED FROM crispoutboundinterface_iss';    
                VL_EXCEP_FLAG := 1;
                VS_SUCCESS_SW := 'N';
                RAISE NOTICE 'crispoutboundinterface_iss INSERT % | Batch No % | Check interfaceserrorlog Table for more info', VL_OUTPUT_SQLCODE, VS_BATCH_NO;
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
                        'CRISP_OUTBOUND_SP', 
                        current_timestamp, 
                        VS_BATCH_NO, 
                        484, 
                        VS_ERROR_CODE, 
                        VL_OUTPUT_SQLCODE, 
                        VS_ERROR_DESC
                    );
            RETURN;
        END;
    IF  VL_EXCEP_FLAG != 1 THEN 
        VS_OUTPUT_STATE :='00000';
        VS_MESSAGE := 'THE RUN WAS SUCCESSFUL';
        VS_SUCCESS_SW := 'Y';
    ELSE
        VS_SUCCESS_SW :='N'; 
    END IF;
    RAISE NOTICE 'END: crisp_outbound_interface % ', timeofday();
    EXCEPTION WHEN OTHERS THEN
        VS_OUTPUT_STATE := SQLSTATE;
        VL_OUTPUT_SQLCODE :=SQLERRM;
        VS_MESSAGE := 'crisp_outbound_interface failed';    
        VL_EXCEP_FLAG := 1;
        VS_SUCCESS_SW := 'N';
    RETURN;
END;
$$;