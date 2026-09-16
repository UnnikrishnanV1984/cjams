/*
   Issue Description: CDM-18610 Removals
   Category/ Module  : Person Removals
   Root cause: user want to remove.
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- remove duplicate persons from case and child removals
update intakeservicerequestactor set activeflag =0, updatedby='CDM-18610', updatedon=now() where intakeservicerequestactorid in ('f6690103-2447-4fc8-a01e-ae7f857e6780','0356360f-31c4-460e-b816-cd58aacceaf2');

update actor set activeflag =0, updatedby='CDM-18610', updatedon=now() where actorid in ('10883a20-9279-413d-9758-3665a6eb0bcd', '99bd584e-39d0-4a13-91a7-6d03e7cc2a43');

--assign program name to the children.
INSERT INTO cjams.personprogramarea
(personprogramid, personid, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, objecttypekey, objectid, entityid, alternateid, datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
VALUES('1ffbdafc-615b-46a9-90fe-f531f12e18ef', '46755eff-c9ff-4404-8500-7b36ea5974c1', '2021-10-26 00:00:00.000', NULL, now(), 'CDM-18610', now(), 'CDM-18610', 1, NULL, NULL, NULL, NULL, NULL, 'CPS', 'IR', 'servicecase', '11b195bc-da8d-425a-b1d0-fab62248c5b4', '3228934', 4014108, NULL, NULL, NULL, NULL, 'CW');

INSERT INTO cjams.personprogramarea
(personprogramid, personid, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, objecttypekey, objectid, entityid, alternateid, datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
VALUES('2ffbdafc-715b-46a9-90fe-f531f12e18dc', '8bb1cf97-584e-4352-a1a5-0ffffe1d86dd', '2021-10-26 00:00:00.000', NULL, now(), 'CDM-18610', now(), 'CDM-18610', 1, NULL, NULL, NULL, NULL, NULL, 'CPS', 'IR', 'servicecase', '11b195bc-da8d-425a-b1d0-fab62248c5b4', '3228934', 4014109, NULL, NULL, NULL, NULL, 'CW');

