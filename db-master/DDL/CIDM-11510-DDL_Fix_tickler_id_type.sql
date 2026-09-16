/*
   Issue Description: CIDM-11510
   Category/ Module  : Ticklers / Fiscal Unit Ticklers Dashboard
   Root cause:  CIDM-11277 DDL changed tb_ticklers.tickler_id from bigint to integer, causing
                stored procedures with RETURNS TABLE(tickler_id bigint) to fail with type mismatch error
   Reason why no related code fix: Column type needs to be restored to bigint to match lower env and SP signatures
   Status of the code fix if already submitted and expected prod fix date:
*/

ALTER TABLE cjams.tb_ticklers ALTER COLUMN tickler_id TYPE bigint;
ALTER SEQUENCE cjams.tb_ticklers_tickler_id_seq AS bigint;

ALTER TABLE cjams.tb_county_specific_unov_06172026 RENAME TO tb_county_specific_unov;
