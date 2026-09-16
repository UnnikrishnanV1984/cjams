ALTER TABLE investigationallegationmaltreators
add column oahearingheldreason varchar(50);

ALTER TABLE investigationallegationmaltreators
ADD COLUMN if not exists oahearingheld varchar (50);

ALTER TABLE investigationallegationmaltreators
add column if not exists oalocationofhearing varchar(50);

ALTER TABLE investigationallegationmaltreators
add column if not exists oahearingnarrative varchar(50);

ALTER TABLE investigationallegationmaltreators
add column if not exists oamodificationsmade varchar(50);

ALTER TABLE investigationallegationmaltreators
add column if not exists oarunningmotiondate timestamp;

ALTER TABLE investigationallegationmaltreators
add column if not exists oatranslator boolean;

ALTER TABLE investigationallegationmaltreators
add column if not exists oahearingheldreason varchar(50);

ALTER TABLE investigationallegationmaltreators
ALTER COLUMN oahearingheld TYPE varchar(50);