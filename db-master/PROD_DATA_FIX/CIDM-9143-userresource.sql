UPDATE cjams.userresource
SET activeflag=0, updatedby='CIDM-9143', updatedon=now()
WHERE userresourceid='faf17611-cddf-4de5-a667-6070a2888ace'::uuid and userid=2964;
