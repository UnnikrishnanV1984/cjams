Delete from cjams.petitiontype where petitiontypekey= 'QRTP';
INSERT INTO cjams.petitiontype
(petitiontypeid, petitiontypekey, description, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon)
VALUES('d91f018c-26d8-4b37-9291-d94fb2dc82da'::uuid, 'QRTP', 'QRTP Placement', 1, '2022-11-18 16:19:21.827', 'B-137863', 'B-137863', '2022-11-18 16:19:21.827', '2022-11-18 16:19:21.827')
on conflict do nothing;

Delete from cjams.hearingtype where hearingtypekey= 'QRTPIH';
INSERT INTO cjams.hearingtype
(hearingtypeid, hearingtypekey, description, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES('4d8829a6-43f5-4f6b-bba2-4a1534db4a8f'::uuid, 'QRTPIH', 'QRTP Initial Hearing', 1, '2022-11-18 16:24:18.646', 'B-137863', 'B-137863', '2022-11-18 16:24:18.646', '2022-11-18 16:24:18.646', NULL, 'CW')
on conflict do nothing;

Delete from cjams.hearingtype where hearingtypekey= 'QRTPRH';
INSERT INTO cjams.hearingtype
(hearingtypeid, hearingtypekey, description, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES('e7a20990-07ac-4f6b-9348-fca473ca6878'::uuid, 'QRTPRH', 'QRTP Review Hearing', 1, '2022-11-18 16:24:18.646', 'B-137863', 'B-137863', '2022-11-18 16:24:18.646', '2022-11-18 16:24:18.646', NULL, 'CW')
on conflict do nothing;