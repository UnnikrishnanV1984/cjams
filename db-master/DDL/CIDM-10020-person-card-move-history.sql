--------------------------------------
--Revision(s)
-- 02/06/2024 - CIDM-10020 - User story New table created for movepersonhistory
-----------------------------------------
DROP TABLE if exists cjams.moveperson_history;
CREATE TABLE cjams.moveperson_history (
    movepersonHistoryId uuid NOT NULL DEFAULT gen_random_uuid(),
    insertedby varchar(50) NOT NULL, 
    insertedon timestamp NOT NULL DEFAULT now(), 
    updatedby varchar(50) NOT NULL, 
    updatedon timestamp NOT NULL DEFAULT now(),
    fromUserId uuid NULL,
    toUserId uuid NULL,
    objectId varchar(50) NULL,
    endValue jsonb NULL, 
    status varchar(50) NULL, 
    activeflag int4 NULL DEFAULT 1,
    casetype varchar(50) NOT NULL, 
    actionDescription varchar(50) null,
    objecttype varchar(50) null,
    comments varchar(50) NULL,
    CONSTRAINT pk_moveperson_history PRIMARY KEY (movepersonHistoryId)
);

-- Column comments
COMMENT ON COLUMN cjams.moveperson_history.insertedby IS 'To store inserted by details';
COMMENT ON COLUMN cjams.moveperson_history.insertedon IS 'To store inserted on details';
COMMENT ON COLUMN cjams.moveperson_history.updatedby IS 'To store Updated by details';
COMMENT ON COLUMN cjams.moveperson_history.updatedon IS 'To store Updated on by details';
COMMENT ON COLUMN cjams.moveperson_history.fromUserId IS 'To store case worker by details';
COMMENT ON COLUMN cjams.moveperson_history.toUserId IS 'To store Supervisor details';
COMMENT ON COLUMN cjams.moveperson_history.objectId IS 'To store actor Id';
COMMENT ON COLUMN cjams.moveperson_history.endValue IS 'To store end date and comments';
COMMENT ON COLUMN cjams.moveperson_history.status IS 'To store status';
COMMENT ON COLUMN cjams.moveperson_history.activeflag IS 'To store activer or inactive';
COMMENT ON COLUMN cjams.moveperson_history.casetype IS 'To Store if it is a CPS or Non-CPS case';
COMMENT ON COLUMN cjams.moveperson_history.actionDescription IS 'To store description';
COMMENT ON COLUMN cjams.moveperson_history.objecttype IS 'To store actor';