UPDATE
  snapshothist
SET
  snapshotdata = REGEXP_REPLACE(snapshotdata::TEXT,
    '"assessmentinformation"\s*?\:\s*?\[.*?\]', 
    '"assessmentinformation": [{"outcome": "Safe", "assessmentname": "SAFE-C OHP", "assessmentcompletiondate": "2021-10-06T18:59:01"}, {"outcome": "Safe", "assessmentname": "SAFE-C OHP", "assessmentcompletiondate": "2021-12-28T14:49:46"}]'
    )::JSONB,
    updatedby = 'CIDM-4447',
    updatedon = now()
WHERE
  id = '0ff57c6c-bb6f-4d03-8c38-c6976d2df00b'
  AND activeflag = 1;