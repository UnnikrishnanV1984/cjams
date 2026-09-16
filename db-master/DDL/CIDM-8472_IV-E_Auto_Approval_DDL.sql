-- CIDM-8472- IV-E Auto Approval Batch

-- DROP TABLE cjams.ive_auto_approvals;

CREATE TABLE cjams.ive_auto_approvals (
	iveautoapprovalsid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
	eligibility_period_id bigint NULL,
	auto_approval_process_sw varchar(1) NULL,
	auto_approval_date timestamp NULL,
	csmsrefpayload json NULL,
	csmsref_process_sw varchar(1) NULL,
	csmsref_interface_date timestamp NULL,
	csmsref_interface_comments character varying NULL, 
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	activeflag int4 NOT NULL DEFAULT 1,
	comments character varying NULL,  
	CONSTRAINT ive_auto_approvals_pkey PRIMARY KEY (iveautoapprovalsid)
);

-- Column comments

COMMENT ON COLUMN cjams.ive_auto_approvals.iveautoapprovalsid IS 'Primary key - Unique identifier for IV-E Auto Approval Request';
COMMENT ON COLUMN cjams.ive_auto_approvals.eligibility_period_id IS 'Foreign key - PK of cjams.tb_eligibility_period table';
COMMENT ON COLUMN cjams.ive_auto_approvals.auto_approval_process_sw IS 'To Identify if the Request was processed by the batch successfully';
COMMENT ON COLUMN cjams.ive_auto_approvals.auto_approval_date IS 'Auto Approval Date (Batch Run Date)';
COMMENT ON COLUMN cjams.ive_auto_approvals.csmsrefpayload IS 'To Capture the API Payload for the CSMS referral Request';
COMMENT ON COLUMN cjams.ive_auto_approvals.csmsref_process_sw IS 'To Capture the CJAMS to CSMS referral Status';
COMMENT ON COLUMN cjams.ive_auto_approvals.csmsref_interface_date IS 'CJAMS to CSMS referral Interface Date';
COMMENT ON COLUMN cjams.ive_auto_approvals.csmsref_interface_comments IS 'To Capture the CJAMS to CSMS referral Interface API return Status';
COMMENT ON COLUMN cjams.ive_auto_approvals.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.ive_auto_approvals.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.ive_auto_approvals.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN cjams.ive_auto_approvals.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.ive_auto_approvals.activeflag IS 'Status of the record - active or inactive';
COMMENT ON COLUMN cjams.ive_auto_approvals.comments IS 'To Capture Auto Approval Batch Comments.';
