/*
 -- Issue Description: CJAMS-69662 - Unable to input in red highlighted areas on FORM 1080A for case 3275962.
 --Root cause : County/Jurisdiction where the incident occurred is auto-populated at form load from the intake snapshot (intakedastaging/intakesnapshot → jsondata -> 'officelocation'). 
                Case 3275962's active intake CW10181882 is a CIS-converted legacy intake and has zero snapshot rows, so the response is empty.
 -- Fix provided: Datafix to set countyjurisdictionwheretheincidentoccurred = 'Baltimore County' on the
                active form1080a record.
 -- Code/Data fix ticket#: CJAMS-69662
 -- Regression Impacts: N/A
 -- Is Code fix Required?: N 
 
 */

update form1080a
set countyjurisdictionwheretheincidentoccurred = 'Baltimore County',
    updatedby = 'CJAMS-69662',
    updatedon = now()
where form1080aid = 'ee557f9b-3dc7-4a54-8dcf-23e4fd0eedd0'
  and activeflag = 1
  and countyjurisdictionwheretheincidentoccurred is null;
