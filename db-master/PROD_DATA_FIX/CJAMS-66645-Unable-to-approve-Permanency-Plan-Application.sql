/*
Issue: CJAMS-66645 Payments did not populate
Category/Module: GAP / Suspension
Root cause: 2020021902200:CJAMS #4495373 - Journee Moore - Provider change was made, but when application was submitted for approve, no one could approve.
                We will revert GAP application to the original one
            2 . Remove Latest subsidy rate slab for the new provider
            3. Remove suspension record
Fix provided:  Data fix has been done to remove the incorrect GAP suspension record and trigger the pending payments.
Data/Code fix ticket#: CJAMS-65035
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Draft suspension created and data fix needed for this issue.
*/

update gapsuspension 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-66645'
where gapsuspensionid = 'a34f5fd7-d37e-4363-879e-5b3798d287a1'
and   gapid = '70108ae5-333f-4a29-82da-6539d01bd724'
and activeflag = 1;


------delete gap subsidy rate
update gapagreementrate
set activeflag = 0, updatedby ='CJAMS-66645',updatedon=now()
where gapagreementrateid ='ec700e46-fe37-440b-82f0-a6f40b6e1442' and activeflag=1;



-- INSERT INTO cjams.providerswitchinfo
-- (providerswitchid, activeflag, objectid, objecttype, approvalstatus, oldproviderid, newproviderid, requestedby, approvedby, approvaldate, decisiondate, insertedby, insertedon, updatedby, updatedon)
-- VALUES('d3a5d95d-b4f9-47a2-91ff-501839eb4818', 1, 'da90b9be-1a92-4c2d-8980-8b7c8de2315d', 'GAP', 'Review', '6003597', '6283646', '38283c5d-e5c6-429d-9034-40587cc641ce', NULL, NULL, '2026-03-23 15:12:25.737', '38283c5d-e5c6-429d-9034-40587cc641ce', '2026-03-23 15:12:25.737', '38283c5d-e5c6-429d-9034-40587cc641ce', '2026-03-23 15:12:25.737');

DELETE FROM cjams.providerswitchinfo
WHERE providerswitchid='d3a5d95d-b4f9-47a2-91ff-501839eb4818';


-- INSERT INTO cjams.providerswitchinfo
-- (providerswitchid, activeflag, objectid, objecttype, approvalstatus, oldproviderid, newproviderid, requestedby, approvedby, approvaldate, decisiondate, insertedby, insertedon, updatedby, updatedon)
-- VALUES('a8b7a2e2-a37e-4119-8312-290faa48c4ff', 1, 'da90b9be-1a92-4c2d-8980-8b7c8de2315d', 'GAP', 'Review', NULL, NULL, '38283c5d-e5c6-429d-9034-40587cc641ce', NULL, NULL, '2026-03-25 10:10:24.096', '38283c5d-e5c6-429d-9034-40587cc641ce', '2026-03-25 10:10:24.096', '38283c5d-e5c6-429d-9034-40587cc641ce', '2026-03-25 10:10:24.096');

DELETE FROM cjams.providerswitchinfo
WHERE providerswitchid='a8b7a2e2-a37e-4119-8312-290faa48c4ff';




update guardianship
set switchprovider = false,guardianoneproviderid = 6003597, effectiveswitchdate = null, switchproviderreason = '',  guardianoneid = '6003597', guardianonename = 'MILISSA MORRIS', updatedby='CJAMS-66645', updatedon = now()
where gapid='70108ae5-333f-4a29-82da-6539d01bd724' and activeflag = 1;

--updating gapraterevision table to trigger finance batch.
update gapratesrevision
set approvalDate = now(),
    updatedby = 'CJAMS-66645',
    updatedon = now()
where gapratesrevisionid in('034d8ddd-a2be-4016-a426-34e40738d767') and activeflag=1;
