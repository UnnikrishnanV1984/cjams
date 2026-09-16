ALTER TABLE personhlthsleeping ADD COLUMN IF NOT EXISTS uploadpath json NULL;
ALTER TABLE personhlthelimination ADD COLUMN IF NOT EXISTS uploadpath json NULL;

ALTER TABLE personexamination ALTER COLUMN  uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personbehavioralhealth ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE birthhealthinfo ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE persondisability ALTER COLUMN uploadpath TYPE json USING uploadpath::json; 
ALTER TABLE personfmlymdclhstry ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personhospitalization ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personimmunization ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personhealthinsurance ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personmedicalcondition ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personmedicalconditioninfo ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE clientunder5yearsinfo ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personsexualinfo ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personphycisianinfo ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personmedicalinfo ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personabusesubstance ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personhlthmobilityspeech ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personhlthfeeding ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personhlthsleeping ALTER COLUMN uploadpath TYPE json USING uploadpath::json;
ALTER TABLE personhlthelimination ALTER COLUMN uploadpath TYPE json USING uploadpath::json;




 