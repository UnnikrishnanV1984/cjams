--- connect CPS case 20200136018666 wtih existing service case 3292522.
select * from cjams.createservicecase('f608679b-e041-4bfa-bb9d-1de8bcba484e','8efef4cf-2009-4ebc-b825-7f6bff5adcd1', 0, '14b908ec-8ac9-4a54-9284-3e417fbac3e2', 'ohm');

--- Deactivating New service case.
update cjams.servicecase set activeflag = 0 where servicecasenumber = '2020015001341';