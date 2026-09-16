-- Application fix is already done on 11/21, 
-- this will do data fix for case assignments that ended after go-live and have enddate > updatedon.
-- SELECT count(*) OVER(),enddate,updatedon,insertedon,* 
-- FROM caseassignment 
-- WHERE enddate > updatedon AND enddate > '2019-10-26' AND enddate <= now() ORDER BY startdate DESC;

UPDATE caseassignment
SET updatedon = enddate, updatedby = 'admin-D-22679'
WHERE enddate > updatedon AND enddate > '2019-10-26' AND enddate <= now();