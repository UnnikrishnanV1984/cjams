update intakeservreqchildremoval
set removaltime = '2020-05-18 10:00:00', familystructuretypekey = '298', childphysicalremovaladdress = '412 Walnut St. Cumberland, MD 21502',
ischildphysicalremovaladdressverified = 1,primarycaregiveradd='412 Walnut St, Cumberland, MD', seccaregiveractorid='73896323-b58f-4e0b-a4a6-63c28a7ac2fd',
seccaregiveradd = '412 Walnut St, Cumberland, MD',isverifiedcaregiver2add = 1, updatedon = now(), updatedby = 'Datafix user as per CDM-1637'
where intakeservreqchildremovalid in ('75dd4bf2-b5d6-4bf3-bd5b-2d591e58bea0', '18036fe7-4e51-4b98-993d-946ca6f9b6e8');

update Intakeservreqchildremovalreason
set removalreasontypekey = 'NREM', updatedon = now(), updatedby = 'Datafix user as per CDM-1637'
where intakeservreqchildremovalid in ('75dd4bf2-b5d6-4bf3-bd5b-2d591e58bea0', '18036fe7-4e51-4b98-993d-946ca6f9b6e8') and inputtypekey = 'REPCR';