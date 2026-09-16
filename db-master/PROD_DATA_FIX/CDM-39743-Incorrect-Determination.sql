/*
 Issue Description: CDM-39743
 Category/ Module  :Incorrect Determination.
 Root cause: incomplete determination for this case. The relationship for the provider is blank. The relationship should be maternal grandmother with client id 4276229
 Pull request# for code fix: na
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 */
update
    gapeligibilityinfo
set
    primaryguardianisrelative = 'YES',
    primaryguardianrelationship = 'Maternal GrandParent',
    primaryguardianrelationshipid = '1001',
    updatedby = 'CDM-39743',
    updatedon = now()
where
    client_id = '4276229';

UPDATE
    cjams.guardianship
SET
    primaryrelationshipkey = 'MATRNLGPRNT',
    updatedby = 'CDM-39743',
    updatedon = now()
WHERE
    gapid = 'c31d0655-f3fb-4df6-84a3-a49afe5989cb';