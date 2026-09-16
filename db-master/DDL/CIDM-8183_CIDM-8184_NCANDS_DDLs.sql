-- CIDM-8183 - NCANDS - Element 151 : If the Plan of safe care is available then 1 or else 0

-- CIDM-8184 - NCANDS - Elements 152 - In Plan of safe care  

/*
Field Long Name: Has a Plan of Safe Care
Field Short Name: PLNSFCR
Field Number: 151
Size: 1
Position: 337

Field Long Name: Referral to Appropriate Services
Field Short Name: REFRCARA
Field Number: 152
Size: 1
Position: 338
*/

-- Modifiy ncands_child_data & tb_ncands_elements to add Element 151 & 152

ALTER TABLE cjams.ncands_child_data ADD COLUMN IF NOT EXISTS PLNSFCR varchar(1) NULL;
COMMENT ON COLUMN cjams.ncands_child_data.PLNSFCR IS 'Plan of Safe Care Flag'; 

ALTER TABLE cjams.ncands_child_data ADD COLUMN IF NOT EXISTS REFRCARA varchar(1) NULL;
COMMENT ON COLUMN cjams.ncands_child_data.REFRCARA IS 'Referral to Appropriate Services Flag'; 


ALTER TABLE cjams.tb_ncands_elements ADD COLUMN IF NOT EXISTS PLNSFCR varchar(1) NULL;
COMMENT ON COLUMN cjams.tb_ncands_elements.PLNSFCR IS 'Plan of Safe Care Flag'; 

ALTER TABLE cjams.tb_ncands_elements ADD COLUMN IF NOT EXISTS REFRCARA varchar(1) NULL;
COMMENT ON COLUMN cjams.tb_ncands_elements.REFRCARA IS 'Referral to Appropriate Services Flag'; 

