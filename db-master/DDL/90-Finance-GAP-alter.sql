ALTER TABLE gapratesrevision ALTER COLUMN gapratesrevisionid  SET DEFAULT gen_random_uuid();
ALTER TABLE adoptionrevision ALTER COLUMN adoptionrevisionid  SET DEFAULT gen_random_uuid();