------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 05/23/2014 Amiya Pradhan - CPS Response Timer Update CIDM-8867: B-175011- Closing AR/IR cases without completed initial contact 
------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS cjams.intakeservicerequest  
ADD COLUMN IF NOT EXISTS untimely boolean default false;

ALTER TYPE cjams.getdsdsactionsummarydtls_type DROP ATTRIBUTE IF EXISTS  untimely;
ALTER TYPE cjams.getdsdsactionsummarydtls_type ADD ATTRIBUTE untimely boolean; 

-- Column comments

COMMENT ON COLUMN cjams.intakeservicerequest.untimely IS 'untimely closed case boolean value stored in this column for the intakeservicerequest table';
COMMENT ON COLUMN cjams.getdsdsactionsummarydtls_type.untimely IS 'added untimely attribute for the getdsdsactionsummarydtls_type type';