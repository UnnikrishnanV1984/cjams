CREATE TABLE cjams.transferred_cases (
	transferred_cases_id uuid NOT NULL DEFAULT gen_random_uuid(),
	county_cd varchar NULL,
	case_id uuid NULL,
	case_number bigint NULL,
	insertedon date NULL DEFAULT now(),
	insertedby varchar(50) NULL DEFAULT 'manual_transfer',
	updatedon date NULL DEFAULT now(),
	updatedby varchar(50) NULL DEFAULT 'manual_transfer',
	date_of_transfer date NULL
);

-- Column comments

COMMENT ON COLUMN cjams.transferred_cases.case_id IS 'For CJAMS use';
COMMENT ON COLUMN cjams.transferred_cases.case_number IS 'For batch use';
