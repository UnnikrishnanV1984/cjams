DROP TABLE IF EXISTS defecttracking.releasenotes;
CREATE TABLE defecttracking.releasenotes (
	releasenotesid uuid NOT NULL DEFAULT gen_random_uuid(),
	releaseversionno varchar(50) NOT NULL,
	releasedate date NOT NULL,
	application varchar(50) NOT NULL,
	itemtype varchar(50) NOT NULL,
	itemid varchar(50) NOT NULL,
	title varchar NOT NULL,
	description text NOT NULL,
	supportid varchar(50) NULL,
	documentlink varchar NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NOT NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	publish bool NULL,
	CONSTRAINT pk_releasenotes PRIMARY KEY (releasenotesid)
);

COMMENT ON COLUMN defecttracking.releasenotes.releasenotesid IS 'Primary key for the table';
COMMENT ON COLUMN defecttracking.releasenotes.releaseversionno IS 'Release Version Number';
COMMENT ON COLUMN defecttracking.releasenotes.releasedate IS 'Release Deployment Date';
COMMENT ON COLUMN defecttracking.releasenotes.application IS 'Application Name CW, AS, PROV';
COMMENT ON COLUMN defecttracking.releasenotes.itemtype IS 'Release Item Type - Defect or Story';
COMMENT ON COLUMN defecttracking.releasenotes.itemid IS 'Release Item Id - DefectId or StoryId';
COMMENT ON COLUMN defecttracking.releasenotes.title IS 'Title of Release Item';
COMMENT ON COLUMN defecttracking.releasenotes.description IS 'Release Item Description';
COMMENT ON COLUMN defecttracking.releasenotes.supportid IS 'Support Id for Defect';
COMMENT ON COLUMN defecttracking.releasenotes.documentlink IS 'Training Document Link for Story';
COMMENT ON COLUMN defecttracking.releasenotes.activeflag IS 'Status of the record';
COMMENT ON COLUMN defecttracking.releasenotes.insertedby IS 'User who inserted the record';
COMMENT ON COLUMN defecttracking.releasenotes.insertedon IS 'Record inserted Date';
COMMENT ON COLUMN defecttracking.releasenotes.updatedby IS 'User who updated the record';
COMMENT ON COLUMN defecttracking.releasenotes.updatedon IS 'Record updated date';
COMMENT ON COLUMN defecttracking.releasenotes.publish IS 'Release publish flag';
