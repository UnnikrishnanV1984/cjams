CREATE INDEX welfarelog_request_idx ON cjams.welfarelog (request,tokenid);
CREATE INDEX welfarelog_tokenid_idx ON cjams.welfarelog (tokenid,insertedon);
Update personaddresstype set activeflag=1 where personaddresstypekey in ('PH','SH');
