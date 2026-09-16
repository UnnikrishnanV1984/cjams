UPDATE livingarrangement la
SET livingenddate = (SELECT enddatetime FROM placement WHERE placementid = '11fbc9e8-8b1a-4a34-a300-5dfea2816381')
WHERE 
la.placementid = '11fbc9e8-8b1a-4a34-a300-5dfea2816381'
