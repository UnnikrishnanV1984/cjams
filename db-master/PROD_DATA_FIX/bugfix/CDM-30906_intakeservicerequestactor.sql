-- CDM-30906 - MISSING CLIENT-CASEHEAD   
-- CPS-IR: 231030107404 

-- Category/ Module: Person Profile
-- Root cause: Fixed   
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 


UPDATE cjams.intakeservicerequestactor
SET isprimary=true, updatedby='CDM-30906', updatedon=now()
WHERE intakeservicerequestactorid='68395adf-1e20-48cd-ac13-7670b5d1c254' and personid='133a1b22-7e39-40ba-89f1-44ef2676bdcf';
