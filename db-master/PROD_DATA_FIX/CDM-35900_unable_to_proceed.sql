/*
 Issue Description: CDM-35900
    Category/ Module: Unable to click proceed
    Root cause: Intakeserviceid is missing for corresponding intakeservicerequestactorid
    Fix: Patched the intakeserviceid with corresponding intakeserviceid
    Pull request# for code fix: 
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 
 */
update
    intakeservicerequestactor
set
    intakeserviceid = '1d85a9ce-e0b3-4de3-8a11-00f0d115a2d9',
    updatedby = 'CDM-35900',
    updatedon = now()
where
    intakeservicerequestactorid in (
        '55675579-7abb-4557-8732-76ce1a2e62cc',
        'c61d48ad-8265-4845-bf66-b1ff9469603a'
    )
    and activeflag = 1;