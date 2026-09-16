-- B-107734 - Add Fiscal Category Code 4180-Center for Excellence (CfE)

-- New column in cjams.tb_fiscal_category_master to capture annual maximum total expenditure amount
-- for each Federal Fiscal year October 1st To September 30th

alter table cjams.tb_fiscal_category_master add annual_max_amount numeric(10,2);


