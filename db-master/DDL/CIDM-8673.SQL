alter table Intakeservicerequestcourthearing ADD COLUMN if not exists changeofpermanency boolean;

COMMENT ON COLUMN cjams.Intakeservicerequestcourthearing.changeofpermanency IS 'to save change of permanency';

alter table Intakeservicerequestcourthearing ADD COLUMN if not exists datenoticehearing date;

COMMENT ON COLUMN cjams.Intakeservicerequestcourthearing.datenoticehearing IS 'to save date notice hearing';

DROP TABLE IF EXISTS cjams.meetingrecordinghearingdetail;

CREATE TABLE cjams.meetingrecordinghearingdetail (
	meetingrecordinghearingdetailid uuid NOT NULL DEFAULT gen_random_uuid(),
	meetingrecordingid uuid NULL,
	clientid uuid NULL,
	intakeservicerequestcourthearingid uuid NULL,
	insertedon timestamp  NULL DEFAULT now(),
	insertedby varchar(50)  NULL,
	updatedon timestamp NULL,
	updatedby varchar(50)  null,
	activeflag int4 NOT NULL DEFAULT 1,
	CONSTRAINT pkmeetingrecordinghearingdetailid PRIMARY KEY (meetingrecordinghearingdetailid)
);


COMMENT ON COLUMN cjams.meetingrecordinghearingdetail.meetingrecordinghearingdetailid IS 'to save meetingrecording hearing detail id ';
COMMENT ON COLUMN cjams.meetingrecordinghearingdetail.meetingrecordingid IS 'to save meetingrecording meeting recording id ';
COMMENT ON COLUMN cjams.meetingrecordinghearingdetail.clientid IS 'to save meetingrecording client id ';
COMMENT ON COLUMN cjams.meetingrecordinghearingdetail.intakeservicerequestcourthearingid IS 'to save meetingrecording intake service request court hearing id ';
COMMENT ON COLUMN cjams.meetingrecordinghearingdetail.insertedon IS 'to save meetingrecording hearing inserted on ';
COMMENT ON COLUMN cjams.meetingrecordinghearingdetail.insertedby IS 'to save meetingrecording hearing inserted by ';
COMMENT ON COLUMN cjams.meetingrecordinghearingdetail.updatedon IS 'to save meetingrecording hearing updated on ';
COMMENT ON COLUMN cjams.meetingrecordinghearingdetail.updatedby IS 'to save meetingrecording hearing updated by ';
COMMENT ON COLUMN cjams.meetingrecordinghearingdetail.activeflag IS 'to save meetingrecording hearing active flag ';