--Person profile related reference values are expecting no teamtype
--type 145 will be used for education program instead of 178
UPDATE referencevalues
SET teamtypekey = NULL
WHERE referencetypeid = 145;