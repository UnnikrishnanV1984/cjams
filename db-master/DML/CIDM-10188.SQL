DELETE FROM cjams.settings
WHERE settingname='psychotropic_business_hour_start';

INSERT INTO cjams.settings
(settingname, settingvalue, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('psychotropic_business_hour_start', '09:00:00', 1, NULL, 'CIDM-10188', now(), now(), NULL);

DELETE FROM cjams.settings
WHERE settingname='psychotropic_business_hour_end';


INSERT INTO cjams.settings
(settingname, settingvalue, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('psychotropic_business_hour_end', '17:00:00', 1, NULL, 'CIDM-10188', now(), now(), NULL);


update cjams.referencevalues set displayorder=7,updatedon=NOW(),updatedby='CIDM-10188' where referencetypeid = 500608 and ref_key='PCR';

update cjams.referencevalues set displayorder=8,updatedon=NOW(),updatedby='CIDM-10188' where referencetypeid = 500608 and ref_key='PPP';

update cjams.referencevalues set displayorder=9,updatedon=NOW(),updatedby='CIDM-10188' where referencetypeid = 500608 and ref_key='PPR';

update cjams.referencevalues set displayorder=10,updatedon=NOW(),updatedby='CIDM-10188' where referencetypeid = 500608 and ref_key='REJ';

update cjams.referencevalues set displayorder=11,updatedon=NOW(),updatedby='CIDM-10188' where referencetypeid = 500608 and ref_key='RTW';

delete from cjams.referencevalues where referencetypeid = 500608 and ref_key='ISCA';


delete from cjams.referencevalues where referencetypeid = 500608 and ref_key='ISCA';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ISCA', 500608, 'initial_submission', 'Initial Submission/Coordinator Assignment Pending', 'CW', 1, 6, 'CIDM-10188', NOW(), 'CIDM-9541', NOW(), NULL, NULL, NULL);


DELETE FROM cjams.holidays
WHERE year = '2025';

INSERT INTO cjams.holidays (date, year, description, insertedby,insertedon)
VALUES
('01-01-2025', '2025',  'New Year', 'CIDM-10188',now()),
('01-20-2025', '2025',  'Dr. Martin Luther King', 'CIDM-10188',now()),
('02-17-2025', '2025',  'Presidents Day', 'CIDM-10188',now()),
('05-26-2025', '2025',  'Memorial Day', 'CIDM-10188',now()),
('06-19-2025', '2025',  'Juneteenth', 'CIDM-10188',now()),
('07-04-2025', '2025',  'Independence Day', 'CIDM-10188',now()),
('09-01-2025', '2025',  'Labor Day', 'CIDM-10188',now()),
('10-13-2025', '2025',  'Columbus Day', 'CIDM-10188',now()),
('11-11-2025', '2025',  'Veterans Day', 'CIDM-10188',now()),
('11-27-2025', '2025',  'Thanksgiving Day', 'CIDM-10188',now()),
('11-28-2025', '2025',  'American Indian Heritage Day', 'CIDM-10188',now()),
('12-25-2025', '2025',  'Christmas Day', 'CIDM-10188',now());
