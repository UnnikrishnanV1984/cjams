 INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder,
 insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES
('UNKN', 27, 'Unknown', 'Unknown', NULL, 1, 1,
 'CIDM-10981', now(), 'CIDM-10981', now(),
 NULL, NULL, NULL, 'b7f1d3de-3c4b-4a6c-8f4a-9f7a2c0f9b21'::uuid) ON CONFLICT DO NOTHING;