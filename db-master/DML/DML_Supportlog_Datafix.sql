-- To correct invalid status types from supportlog table as part of contact support module updates (CIDM-7097)

UPDATE defecttracking.supportlog set jirarequestsent = 'Approved' where lower(jirarequestsent::character varying) = 'approve';

UPDATE defecttracking.supportlog set jirarequestsent = 'Rejected' where lower(jirarequestsent::character varying) = 'reject';