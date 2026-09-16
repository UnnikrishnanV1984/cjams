
update attorneyaddress set activeflag=0, updatedon = current_timestamp where 
attorneyaddressid in ('badedd8b-80f1-4a2e-9830-4bf706c0cf49','6d470135-fafd-4779-b6e6-d1defd205524',
'28550ca4-1015-4853-b7be-039112372e25','5ae809a8-5313-428a-9e11-426b133d4671'
,'a5bbe132-b97a-46f7-8f1b-0814f0d381aa');

INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES(gen_random_uuid(), 'Christopher Goodwin', null, null, null, null, 1, current_timestamp, 'admin', NULL, current_timestamp, NULL, NULL, null, null, null, null);

INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES(gen_random_uuid(), 'Deborah Herman', null, null, null, null, 1, current_timestamp, 'admin', NULL, current_timestamp, NULL, NULL, null, null, null, null);
