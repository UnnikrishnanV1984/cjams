UPDATE intakesnapshot  
SET jsondata = jsonb_set(
    COALESCE(jsondata::jsonb, '{}'::jsonb), 
    '{clearhistory}',                        
    '{
          "close": null,
        "reason": "DC",
        "comments": null,
        "individual": null,
        "thirdparty": null,
        "workername": "LoriPfeiffer",
        "startdatetime": null
    }'::jsonb,                              
    true                                    
), updatedon = now(), updatedby ='CJAMS-66117'
WHERE intakenumber = 'I261013944890' and activeflag = 1;

