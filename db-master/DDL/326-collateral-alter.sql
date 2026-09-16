ALTER TABLE collateral ALTER COLUMN insertedby TYPE varchar(50) ;

ALTER TABLE collateral ALTER COLUMN updatedby TYPE varchar(50) ;

ALTER TABLE collateral ALTER COLUMN collateralid SET DEFAULT gen_random_uuid();

ALTER TABLE collateraladdress ALTER COLUMN insertedby TYPE varchar(50) ;

ALTER TABLE collateraladdress ALTER COLUMN updatedby TYPE varchar(50) ;

ALTER TABLE collateraladdress ALTER COLUMN collateraladdressid SET DEFAULT gen_random_uuid();

