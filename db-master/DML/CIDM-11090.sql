UPDATE cjams.pgresource
SET activeflag=0, 
    updatedby='CIDM-11090', 
    updatedon=now()
WHERE pgresourceid='5a000282-b14c-4d5e-8686-64a60c6e73ac'::uuid
and activeflag=1;