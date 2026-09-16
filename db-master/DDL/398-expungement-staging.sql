CREATE EXTENSION IF NOT EXISTS pgcrypto;

ALTER TABLE cjams.expungementstaging ADD ncrypt_firstname text NULL;
COMMENT ON COLUMN cjams.expungementstaging.ncrypt_firstname IS 'Encrypted first name';
ALTER TABLE cjams.expungementstaging ADD ncrypt_middlename text NULL;
COMMENT ON COLUMN cjams.expungementstaging.ncrypt_middlename IS 'Encrypted middle name';
ALTER TABLE cjams.expungementstaging ADD ncrypt_lastname text NULL;
COMMENT ON COLUMN cjams.expungementstaging.ncrypt_lastname IS 'Encrypted last name';
ALTER TABLE cjams.expungementstaging ADD ncrypt_dob text NULL;
COMMENT ON COLUMN cjams.expungementstaging.ncrypt_dob IS 'Encrypted dob';
ALTER TABLE cjams.expungementstaging ADD ncrypt_ssn text NULL;
COMMENT ON COLUMN cjams.expungementstaging.ncrypt_ssn IS 'Encrypted ssn';
