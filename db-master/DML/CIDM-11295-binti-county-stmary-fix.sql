-- CIDM-11295 - BINTI county was not updated for St. Mary's County since the last script was countyname='Saint Mary''s'
UPDATE cjams.county
SET binticountyname='Saint Mary''s County',
    updatedby='CIDM-11295',
    updatedon=now()
WHERE countyid='fa2affa3-0783-49f0-b3f8-e3fbcf59bfc0'::uuid
and countyname='St. Mary''s' and activeflag = 1;