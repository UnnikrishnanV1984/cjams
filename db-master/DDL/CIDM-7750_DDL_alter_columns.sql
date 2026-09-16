-- CIDM-7750 - Expungement batch error
-- To fix value too long for type character varying(50) error (CIDM-7750)

-- expungementreport Table alter Column Data types 

Alter table cjams.expungementreport alter column maltreatername TYPE varchar(150);
Alter table cjams.expungementreport alter column victimname TYPE varchar(150);
