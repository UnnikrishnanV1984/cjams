UPDATE cjams.gapeligibilityinfo
SET primaryguardianisrelative='NO', updatedby='CDM-19950', updatedon=now()
WHERE client_id= 1004406 and al_removal_id = 108570 and primaryguardianrelationshipid = 1015 and activeflag=1;
