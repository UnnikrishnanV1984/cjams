/* D-21361 to allow decimals in amountowed and facevalue input fields */
ALTER TABLE cjams.personasset ALTER COLUMN amountowed type numeric;
ALTER TABLE cjams.personasset ALTER COLUMN facevalue type numeric;