/*
 * B-226711: CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases
 * ADD column isexpunged
 * Revision(s) 
 * 10/31/2025 - Amiya Pradhan - Adding isexpunged coulmn for Expungement (CIDM-10890)
 */

ALTER TABLE contactparticipant ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE intakedastaging ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE intakedastatus ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE intakeservicerequest ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE intakeservicerequestsdm ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE intakeservrequestsdmmaltreatment ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE investigationallegation ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE investigationallegationmaltreators ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE investigation ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE investigationfinding ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE investigationmaltreatmentactor ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE personprogramarea ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE progressnote ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE progressnotedetail ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE Contacttrialvisit ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE actor ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE intakeservicerequestactor ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE intakeservicerequestservice ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;
ALTER TABLE intakesnapshot ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;

COMMENT ON COLUMN cjams.contactparticipant.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.intakedastaging.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.intakedastatus.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.intakeservicerequest.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.intakeservicerequestsdm.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.intakeservrequestsdmmaltreatment.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.investigationallegation.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.investigationallegationmaltreators.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.investigation.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.investigationfinding.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.investigationmaltreatmentactor.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.personprogramarea.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.progressnote.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.progressnotedetail.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.Contacttrialvisit.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.actor.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.intakeservicerequestactor.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.intakeservicerequestservice.isexpunged IS 'Flag to indicate the expunged record';
COMMENT ON COLUMN cjams.intakesnapshot.isexpunged IS 'Flag to indicate the expunged record';