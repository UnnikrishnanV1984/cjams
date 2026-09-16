

ALTER TABLE cjams.permanencyplan ADD COLUMN IF NOT EXISTS actualdata json null;
ALTER TABLE cjams.permanencyplan ADD COLUMN IF NOT EXISTS permanencyplanremainssame bool null;
ALTER TABLE cjams.permanencyplan ADD COLUMN IF NOT EXISTS permanencyplanremainssamedate timestamp null;
ALTER TABLE cjams.permanencyplan ADD COLUMN IF NOT EXISTS reviewdate timestamp NULL;


ALTER TABLE cjams.permanencyplanhistory ADD COLUMN IF NOT EXISTS primarypermanencytype varchar(25) NULL;
ALTER TABLE cjams.permanencyplanhistory ADD COLUMN IF NOT EXISTS concurrentpermanencytype varchar(25) NULL;
ALTER TABLE cjams.permanencyplanhistory ADD COLUMN IF NOT EXISTS  permanencyplanremainssame bool NULL;
ALTER TABLE cjams.permanencyplanhistory ADD COLUMN IF NOT EXISTS  reviewdate timestamp NULL;

ALTER TABLE cjams.permanencyplan_history ADD COLUMN IF NOT EXISTS reviewdate timestamp NULL;



COMMENT ON COLUMN permanencyplan.actualdata IS 'To save permanencyplan actualdata ';
COMMENT ON COLUMN permanencyplan.permanencyplanremainssame IS 'To save permanencyplanremainssame value ';
COMMENT ON COLUMN permanencyplan.permanencyplanremainssamedate IS 'To save permanencyplanremainssamedate value ';
COMMENT ON COLUMN permanencyplan.reviewdate IS 'To save reviewdate value ';
COMMENT ON COLUMN permanencyplanhistory.primarypermanencytype IS 'To save primarypermanencytype value ';
COMMENT ON COLUMN permanencyplanhistory.concurrentpermanencytype IS 'To save concurrentpermanencytype value ';
COMMENT ON COLUMN permanencyplanhistory.permanencyplanremainssame IS 'To save permanencyplanremainssame value ';
COMMENT ON COLUMN permanencyplanhistory.reviewdate IS 'To save reviewdate value ';
COMMENT ON COLUMN permanencyplan_history.reviewdate IS 'To save reviewdate value ';





