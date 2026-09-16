update cjams.intakeservicerequest SET activeflag =0, updatedon = now(), updatedby = 'CDM-1491'
where intakeserviceid = '71ae7814-5c11-4811-a2e0-4cd45db6a401';


UPDATE cjams.personprogramarea
SET updatedby='CDM-1278', updatedon=now(), activeflag=0, datatransferflag='D'
WHERE personprogramid in ('508f4c21-e439-4328-948b-ac987f85536e', 'b45c72b7-4c84-4af6-9cf8-1e6049ff017e', 'cbd6df72-e0ee-41d6-a7e4-d92b466e16af', '5faec300-0995-4642-8f44-23247c3c29f2', '9ffb68ca-c88f-43d0-9359-fa46183f9629');













