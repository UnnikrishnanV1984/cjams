-- To correct invalid status types from supportlog table as part of contact support module updates (CIDM-7621)

UPDATE defecttracking.supportlog set jirarequestsent = 'Approved' where jirarequestno like 'CJAMS%' and jirarequestsent IN ('Rejected','Pending');	