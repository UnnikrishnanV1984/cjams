DROP TABLE IF EXISTS cjams.encryptionlookup;
DROP procedure if exists addtoencryptionlookup(TEXT,TEXT,TEXT,TEXT);
DROP FUNCTION IF EXISTS cjams.encryptexpungedtables(v_inputprocname character varying, v_encryptionkey character varying) ;
DROP procedure if exists genericencryption(TEXT,TEXT[],TEXT);