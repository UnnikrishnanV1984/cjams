/*
   Issue Description: CDM-33030
   Category/ Module  :  
   Root cause:  in service plan Versions Approved By column is retrieved from updateby column which is causing issues
   Reason why no related code fix: adding 3 more column for snapshothist table
   Status of the code fix if already submitted and expected prod fix date: 
*/

ALTER TABLE cjams.snapshothist ADD COLUMN IF NOT EXISTS approvedby varchar(50);
COMMENT ON COLUMN cjams.snapshothist.approvedby IS 'Approved By User Id';

ALTER TABLE cjams.snapshothist ADD COLUMN IF NOT EXISTS requestedby varchar(50);
COMMENT ON COLUMN cjams.snapshothist.requestedby IS 'Submitted By User Id';

ALTER TABLE cjams.snapshothist ADD COLUMN IF NOT EXISTS requesteddate timestamp;
COMMENT ON COLUMN cjams.snapshothist.requesteddate IS 'Submitted Date';

