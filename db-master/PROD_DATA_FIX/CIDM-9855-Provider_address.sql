-- CIDM-9855 - Update Provider Address
/* Issue Description: Provider address 'City Name' to be corrected

-- Category/ Module: Provider

-- Root cause: Provider address 'City Name' to be corrected, The city name now shows as numbers which is not a valid data. 
-- Fix Provided: Datafix has been provided to update city names
-- Pull request# N/A

*/

--5001415
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Germantown',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id=2059;

--5071686
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Salisbury',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id=80004;

--5088933
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Clarksburg',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id=170452;

--5092702
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Laurel',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id=106202;

--6001213
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Baltimore',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id=114601;

--6001286
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Windsor Mill',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id=114682;

--6002625
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Baltimore',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id=116207;

--6004433
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Gwynn Oak',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id=118299;

--6004729
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Baltimore',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id=118633;

--6005423
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Baltimore',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id= 119468;

--6006761
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Glen Burnie',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id= 120993;

--6007563
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Laurel',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id= 121943;

--6056467
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Randallstown',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id= 180580;

--6058648
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Hanover',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id= 183160;

--6059480
UPDATE prov.tb_provider_addresses
SET adr_city_nm='Baltimore',
update_ts=now(), 
update_user_id='CIDM-9855'
WHERE address_id= 184323;

