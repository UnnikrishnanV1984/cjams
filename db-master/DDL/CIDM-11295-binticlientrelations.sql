-- Table: cjams.binticlientrelations
DROP TABLE IF EXISTS cjams.binticlientrelations;
CREATE TABLE IF NOT EXISTS cjams.binticlientrelations (
    binticlientrelationsid uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
    childcjamspid int8 NOT NULL,
    childbinticlientid varchar(50) NULL,
    relativepersonid uuid NOT NULL,
    relativecjamspid int8 NULL,
    relationshiptypekey varchar(50) NOT NULL,
    cjamsrelationship varchar(255) NULL,
    bintikinshiprelationship varchar(100) NULL,
    bintilineagetype varchar(50) NULL,
    bintirolelabel varchar(150) NULL,
    bintisocialconnectionid varchar(50) NULL,
    syncstatus varchar(30) NULL,
    syncedon timestamp NULL,
    syncedby varchar(50) NULL,
    externalapilogsid uuid NULL,
    activeflag int4 DEFAULT 1 NOT NULL,
    insertedby varchar(50) NOT NULL,
    insertedon timestamp DEFAULT now() NOT NULL,
    updatedby varchar(50) NULL,
    updatedon timestamp DEFAULT now() NULL
);

COMMENT ON TABLE cjams.binticlientrelations IS 'Tracks CJAMS to Binti social connection sync status for child relations.';
COMMENT ON COLUMN cjams.binticlientrelations.childcjamspid IS 'CJAMSPID of the child in scope for family finding.';
COMMENT ON COLUMN cjams.binticlientrelations.childbinticlientid IS 'Binti child id used for social connection sync.';
COMMENT ON COLUMN cjams.binticlientrelations.relativepersonid IS 'Related personid from CJAMS actorrelationship.';
COMMENT ON COLUMN cjams.binticlientrelations.relativecjamspid IS 'Related CJAMSPID from person table.';
COMMENT ON COLUMN cjams.binticlientrelations.relationshiptypekey IS 'CJAMS relationship type key.';
COMMENT ON COLUMN cjams.binticlientrelations.cjamsrelationship IS 'CJAMS relationship description.';
COMMENT ON COLUMN cjams.binticlientrelations.bintikinshiprelationship IS 'Mapped Binti kinship-relationship value.';
COMMENT ON COLUMN cjams.binticlientrelations.bintilineagetype IS 'Mapped Binti lineage-type value.';
COMMENT ON COLUMN cjams.binticlientrelations.bintirolelabel IS 'Display label for mapped Binti role.';
COMMENT ON COLUMN cjams.binticlientrelations.bintisocialconnectionid IS 'Binti social connection id from create API response.';
COMMENT ON COLUMN cjams.binticlientrelations.syncstatus IS 'Sync status, for example SYNCED or FAILED.';
COMMENT ON COLUMN cjams.binticlientrelations.syncedon IS 'Timestamp when relationship was synced with Binti.';
COMMENT ON COLUMN cjams.binticlientrelations.syncedby IS 'Security user id or system user who performed sync.';
COMMENT ON COLUMN cjams.binticlientrelations.externalapilogsid IS 'Reference to external API logs for sync call.';
COMMENT ON COLUMN cjams.binticlientrelations.activeflag IS 'Active Flag. 1 - Active, 0 - Inactive';
