ALTER TABLE cjams.adoptioncase ALTER COLUMN adoptioncasenumber SET DEFAULT getnextdanumber('Servicecasenumber'::character varying);
