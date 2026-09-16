/*
Issue Description: 251023147178:SW unable to send SafeC for supervisory approval. error message regarding connectivity issues. SW is connected to the VPN. SW has been able to enter contact notes and other information in CJAMs without issue. SW needs to send safec for approval to close the case.
Root cause: The contact note contained a special character ('[ ]')and that is being used as a parameter or the payload for creation of the assessment trigger function and consider that as the array in backend ending creating an error in dblevel.
Fix provided: update into progressnote,progressnotedetail table
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: Data  Error.
*/




UPDATE progressnote
SET description  = regexp_replace(description, '\[him\]self', 'himself', 'g'),
    updatedby = 'CIDM-10925',
    updatedon = now()
WHERE  witsid IN (15455603,15420891) and progressnoteid in ('de8cd4b5-c16f-40ed-874f-0ca866e03992','a37d5299-2806-42ed-b480-79d192636235')
  AND activeflag = 1;



UPDATE progressnotedetail
SET description  = regexp_replace(description, '\[him\]self', 'himself', 'g'),
    updatedby = 'CIDM-10925',
    updatedon = now()
WHERE progressnoteid in ('de8cd4b5-c16f-40ed-874f-0ca866e03992','a37d5299-2806-42ed-b480-79d192636235') and activeflag=1;
