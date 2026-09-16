--Application cange is done to read/write singleparentadoptioncheck
--For 3158193 this will also do a data fix in the meantime
--Data migration will be doing this fix for all relevant adoption cases
UPDATE adoptioncaseagreement
SET singleparentadoptioncheck = 0, parent2providername = 'Tom Barnhart'
WHERE adoptionagreementid = '9bdd879c-027a-4168-83b0-9c85cb799b08';