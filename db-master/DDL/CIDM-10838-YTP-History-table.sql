
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 12/03/2025 Veera Nadimpalli - adding new table for YTP changes B-186271_CIDM-10838_stg2_YTPChecklist
------------------------------------------------------------------------------------------------------------	

DROP TABLE IF EXISTS cjams.youthtransitionplan_history;

CREATE TABLE cjams.youthtransitionplan_history (
    youthtransitionplanhistoryid uuid NOT NULL DEFAULT gen_random_uuid(),
    currentdata json,               -- Snapshot of the record after the change (new/current state)
    previousdata json,              -- Snapshot of the record before the change (old/previous state)
    modifieddata json,              -- JSON containing only the fields that changed (diff)
    rowtype character varying(20),  -- Type of change

    -- *** youthtransitionplan COLUMNS IN SAME ORDER ***
    youthtransitionplanid              uuid NOT NULL,                         -- FK: youth transition plan identifier
    summary_json                       jsonb NULL,                            -- Old plan summary section JSON
    youththoughts_json                 jsonb NULL,                            -- Old youth thoughts section JSON
    sracc_json                         jsonb NULL,                            -- Old SRACC section JSON
    health_json                        jsonb NULL,                            -- Old health section JSON
    moneymanagement_json               jsonb NULL,                            -- Old money management section JSON
    housing_json                       jsonb NULL,                            -- Old housing section JSON
    education_json                     jsonb NULL,                            -- Old education section JSON
    employment_json                    jsonb NULL,                            -- Old employment section JSON
    documentation_json                 jsonb NULL,                            -- Old documentation section JSON
    clientid                           uuid NOT NULL,                         -- Client identifier
    intakeserviceid                    uuid NOT NULL,                         -- Intake service identifier
    sevicecaseid                       uuid NULL,                             -- Service case identifier (nullable)
    insertedby                         character varying(50) NULL,            -- User who created the plan record
    updatedby                          character varying(50) NULL,            -- User who last updated the plan record
    insertedon                         timestamp without time zone NULL,      -- Created timestamp
    updatedon                          timestamp without time zone NULL,      -- Last updated timestamp
    approvaldate                       timestamp without time zone NULL,      -- Approval timestamp
    approvalstatuskey                  character varying(26) NULL,            -- Approval status key
    completiondate                     timestamp without time zone NULL,      -- Completion timestamp
    assessmentcompletiondate           timestamp without time zone NULL,      -- Assessment completion timestamp
    nextduedate                        timestamp without time zone NULL,      -- Next due date for plan review/update
    rejectionnote                      character varying(2000) NULL,          -- Rejection note/comments
    returnreason                       character varying(2000) NULL,          -- Return reason/comments
    caseworkername                     character varying(150) NULL,           -- Caseworker display name
    supervisorworkername               character varying(150) NULL,           -- Supervisor display name
    new_summary_json                   jsonb NULL,                            -- summary section JSON
    new_education_json                 jsonb NULL,                            -- education section JSON
    new_employ_json                    jsonb NULL,                            -- employment section JSON
    new_transportation_json            jsonb NULL,                            -- transportation section JSON
    new_documentation_json             jsonb NULL,                            -- documentation section JSON
    new_financial_empowerment_json     jsonb NULL,                            -- financial empowerment section JSON
    new_housing_json                   jsonb NULL,                            -- housing section JSON
    new_community_json                 jsonb NULL,                            -- community/resources section JSON
    new_health_json                    jsonb NULL,                            -- health section JSON
    new_connections_json               jsonb NULL,                            -- connections/supports section JSON
    new_meeting_json                   jsonb NULL,                            -- meeting/plan meeting details JSON
    copyofplanjson                     jsonb NULL,                            -- JSON copy/snapshot of plan 
    startdate                          timestamp without time zone NULL,      -- Plan start date
    enddate                            timestamp without time zone NULL,      -- Plan end date
    newfcgschecklistjson               jsonb NULL,                            -- FCGS checklist JSON 

    CONSTRAINT youthtransitionplan_history_pkey
        PRIMARY KEY (youthtransitionplanhistoryid)
);

COMMENT ON TABLE cjams.youthtransitionplan_history IS
'History/audit table for cjams.youthtransitionplan. Stores current/previous snapshots and modified field diff.';

COMMENT ON COLUMN cjams.youthtransitionplan_history.youthtransitionplanhistoryid IS 'Surrogate primary key for each history/audit row.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.currentdata IS 'Snapshot of audited fields after the change (new/current state).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.previousdata IS 'Snapshot of audited fields before the change (old/previous state).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.modifieddata IS 'Field-level diff JSON (only changed fields).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.rowtype IS 'Row type for audit trail (Created/Updated/Approved/Rejected/Pending/Revision/etc.).';

COMMENT ON COLUMN cjams.youthtransitionplan_history.youthtransitionplanid IS 'FK to youthtransitionplan.youthtransitionplanid (parent record id).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.summary_json IS 'Legacy summary section JSON (old plan format).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.youththoughts_json IS 'Legacy youth thoughts section JSON (old plan format).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.sracc_json IS 'Legacy SRACC section JSON (old plan format).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.health_json IS 'Legacy health section JSON (old plan format).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.moneymanagement_json IS 'Legacy money management section JSON (old plan format).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.housing_json IS 'Legacy housing section JSON (old plan format).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.education_json IS 'Legacy education section JSON (old plan format).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.employment_json IS 'Legacy employment section JSON (old plan format).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.documentation_json IS 'Legacy documentation section JSON (old plan format).';

COMMENT ON COLUMN cjams.youthtransitionplan_history.clientid IS 'Client id (tenant/application client).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.intakeserviceid IS 'Intake service id.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.sevicecaseid IS 'Service case id (nullable based on workflow).';

COMMENT ON COLUMN cjams.youthtransitionplan_history.insertedby IS 'User id that created the plan record.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.updatedby IS 'User id that last updated the plan record.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.insertedon IS 'Created timestamp from the main record.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.updatedon IS 'Last updated timestamp from the main record.';

COMMENT ON COLUMN cjams.youthtransitionplan_history.approvaldate IS 'Approval timestamp (if approved).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.approvalstatuskey IS 'Approval status key (Draft/Submitted/Returned/Approved/etc.).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.completiondate IS 'Completion timestamp for the plan.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.assessmentcompletiondate IS 'Assessment completion timestamp for the plan.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.nextduedate IS 'Next due date for plan review/update.';

COMMENT ON COLUMN cjams.youthtransitionplan_history.rejectionnote IS 'Rejection note/comments entered by reviewer/supervisor.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.returnreason IS 'Return reason/comments entered by reviewer/supervisor.';

COMMENT ON COLUMN cjams.youthtransitionplan_history.caseworkername IS 'Caseworker display name (denormalized for display/reporting).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.supervisorworkername IS 'Supervisor display name (denormalized for display/reporting).';

COMMENT ON COLUMN cjams.youthtransitionplan_history.new_summary_json IS 'New-format summary section JSON.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.new_education_json IS 'New-format education section JSON.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.new_employ_json IS 'New-format employment section JSON.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.new_transportation_json IS 'New-format transportation section JSON.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.new_documentation_json IS 'New-format documentation section JSON.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.new_financial_empowerment_json IS 'New-format financial empowerment section JSON.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.new_housing_json IS 'New-format housing section JSON.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.new_community_json IS 'New-format community/resources section JSON.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.new_health_json IS 'New-format health section JSON.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.new_connections_json IS 'New-format connections/supports section JSON.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.new_meeting_json IS 'New-format meeting details section JSON.';

COMMENT ON COLUMN cjams.youthtransitionplan_history.copyofplanjson IS 'Full JSON copy/snapshot of the plan (copy/print/export use).';
COMMENT ON COLUMN cjams.youthtransitionplan_history.startdate IS 'Plan start date.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.enddate IS 'Plan end date.';
COMMENT ON COLUMN cjams.youthtransitionplan_history.newfcgschecklistjson IS 'FCGS checklist JSON payload captured on the plan.';    