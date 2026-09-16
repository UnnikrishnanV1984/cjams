-- CDM-36366 - Adoption Determination
/* Issue Description:User request to update existing condition on health tab # 211030009797

-- ClientId:202299527
-- RemovalId: 196160 

-- Category/ Module: Title IV-E(Adoption Intial Determination) 

--Root Cause: While determination eligibility, It says exceeded number of allowed characters.
--Fix Provided: For one of the column the value is exceeding type limit 20, increased type to 50
-- Pull request# N/A

*/

ALTER TABLE tb_adoptionaudit_siblingdetails ALTER COLUMN siblingadoptiveproviderid TYPE varchar(100);