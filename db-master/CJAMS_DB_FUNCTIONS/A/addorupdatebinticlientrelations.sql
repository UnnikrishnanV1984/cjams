DROP FUNCTION IF EXISTS cjams.addorupdatebinticlientrelations(json);

CREATE OR REPLACE FUNCTION cjams.addorupdatebinticlientrelations(p_relation json)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
/*
    Add or update a binti client relation record. If an active record exists for the same child/relative/relationship key,
    move it to history, mark existing record inactive, then insert latest sync record.
    Revision(s):
    - 06/02/2026 - Yogeshvar - CIDM-11295: Initial creation for Binti social connection sync tracking.
*/
DECLARE
    v_child_cjamspid bigint;
    v_relative_personid uuid;
    v_relationshiptypekey varchar(50);
BEGIN
    v_child_cjamspid := COALESCE(NULLIF(p_relation->>'childcjamspid', ''), NULLIF(p_relation->>'child_cjamspid', ''))::bigint;
    v_relative_personid := COALESCE(NULLIF(p_relation->>'relativepersonid', ''), NULLIF(p_relation->>'relative_personid', ''))::uuid;
    v_relationshiptypekey := NULLIF(p_relation->>'relationshiptypekey', '');

    IF v_child_cjamspid IS NULL OR v_relative_personid IS NULL OR v_relationshiptypekey IS NULL THEN
        RAISE NOTICE 'Invalid input for addorupdatebinticlientrelations. child_cjamspid: %, relative_personid: %, relationshiptypekey: %',
            v_child_cjamspid, v_relative_personid, v_relationshiptypekey;
        RETURN FALSE;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM cjams.binticlientrelations
                WHERE childcjamspid = v_child_cjamspid
                    AND relativepersonid = v_relative_personid
          AND relationshiptypekey = v_relationshiptypekey
          AND activeflag = 1
    ) THEN
        INSERT INTO cjams.binticlientrelations_history (
            binticlientrelationsid,
                        childcjamspid,
                        childbinticlientid,
                        relativepersonid,
                        relativecjamspid,
            relationshiptypekey,
                        cjamsrelationship,
                        bintikinshiprelationship,
                        bintilineagetype,
                        bintirolelabel,
                        bintisocialconnectionid,
            syncstatus,
            syncedon,
            syncedby,
            externalapilogsid,
            activeflag,
            insertedby,
            insertedon,
            updatedby,
            updatedon
        )
        SELECT
            binticlientrelationsid,
            childcjamspid,
            childbinticlientid,
            relativepersonid,
            relativecjamspid,
            relationshiptypekey,
            cjamsrelationship,
            bintikinshiprelationship,
            bintilineagetype,
            bintirolelabel,
            bintisocialconnectionid,
            syncstatus,
            syncedon,
            syncedby,
            externalapilogsid,
            activeflag,
            insertedby,
            insertedon,
            updatedby,
            updatedon
        FROM cjams.binticlientrelations
                WHERE childcjamspid = v_child_cjamspid
                    AND relativepersonid = v_relative_personid
          AND relationshiptypekey = v_relationshiptypekey
          AND activeflag = 1;

        UPDATE cjams.binticlientrelations
           SET activeflag = 0,
               updatedby = p_relation->>'updatedby',
               updatedon = now()
         WHERE childcjamspid = v_child_cjamspid
                     AND relativepersonid = v_relative_personid
           AND relationshiptypekey = v_relationshiptypekey
           AND activeflag = 1;
    END IF;

    INSERT INTO cjams.binticlientrelations (
                childcjamspid,
                childbinticlientid,
                relativepersonid,
                relativecjamspid,
        relationshiptypekey,
                cjamsrelationship,
                bintikinshiprelationship,
                bintilineagetype,
                bintirolelabel,
                bintisocialconnectionid,
        syncstatus,
        syncedon,
        syncedby,
        externalapilogsid,
        insertedby,
        insertedon,
        updatedby,
        updatedon
    ) VALUES (
        v_child_cjamspid,
        COALESCE(NULLIF(p_relation->>'childbinticlientid', ''), NULLIF(p_relation->>'child_binti_clientid', '')),
        v_relative_personid,
        COALESCE(NULLIF(p_relation->>'relativecjamspid', ''), NULLIF(p_relation->>'relative_cjamspid', ''))::bigint,
        v_relationshiptypekey,
        COALESCE(NULLIF(p_relation->>'cjamsrelationship', ''), NULLIF(p_relation->>'cjams_relationship', '')),
        COALESCE(NULLIF(p_relation->>'bintikinshiprelationship', ''), NULLIF(p_relation->>'binti_kinship_relationship', '')),
        COALESCE(NULLIF(p_relation->>'bintilineagetype', ''), NULLIF(p_relation->>'binti_lineage_type', '')),
        COALESCE(NULLIF(p_relation->>'bintirolelabel', ''), NULLIF(p_relation->>'binti_role_label', '')),
        COALESCE(NULLIF(p_relation->>'bintisocialconnectionid', ''), NULLIF(p_relation->>'binti_social_connection_id', '')),
        NULLIF(p_relation->>'syncstatus', ''),
        CASE
            WHEN NULLIF(p_relation->>'syncedon', '') IS NULL THEN NULL
            ELSE (p_relation->>'syncedon')::timestamp
        END,
        NULLIF(p_relation->>'syncedby', ''),
        NULLIF(p_relation->>'externalapilogsid', '')::uuid,
        p_relation->>'insertedby',
        now(),
        p_relation->>'updatedby',
        now()
    );

    RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Error in addorupdatebinticlientrelations for child_cjamspid: %, relative_personid: %, relationshiptypekey: % - %',
        v_child_cjamspid, v_relative_personid, v_relationshiptypekey, SQLERRM;
    RETURN FALSE;
END;
$function$
;
