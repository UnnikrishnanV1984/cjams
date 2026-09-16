ALTER TABLE investigationallegationmaltreators
add column if not exists cclocationofhearing varchar(50);

ALTER TABLE investigationallegationmaltreators
ADD COLUMN if not exists cchearingheld varchar (50);

ALTER TABLE investigationallegationmaltreators
add column if not exists cchearingheldreason varchar(50);

ALTER TABLE investigationallegationmaltreators
add column if not exists csaarguementheld varchar(50);

ALTER TABLE investigationallegationmaltreators
add column if not exists csaarguementnotheldreason varchar(50);

ALTER TABLE investigationallegationmaltreators
add column if not exists coacertioraristatus varchar(50);

ALTER TABLE investigationallegationmaltreators
add column if not exists coacertgranteddate timestamp;

ALTER TABLE investigationallegationmaltreators
add column if not exists coacertdenieddate timestamp;

ALTER TABLE investigationallegationmaltreators
ALTER COLUMN coadetails TYPE varchar(50);

