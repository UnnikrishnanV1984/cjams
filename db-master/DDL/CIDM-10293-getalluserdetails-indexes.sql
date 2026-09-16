-- composite + partial for rolemapping
CREATE INDEX IF NOT EXISTS idx_rolemapping_principalid_activeflag
ON rolemapping(principalid)
WHERE activeflag = 1;

-- expression + partial for userresource
CREATE INDEX IF NOT EXISTS idx_userresource_userid_varchar_activeflag
ON cjams.userresource( (userid::varchar) )
WHERE activeflag = 1;
