
/*
Issue Description: Service cases opened in error 
Root cause: As user is asking to disconnect the case from below cases 261030708046(Service Case),-261023795933(CPS IR Case), 251030511348(Service Case)-251023059864(CPS AR Case)
Fix provided: DB queries to update the servicecase, intakeservicerequest, servicecasedisposition and routing tables to disconnect the cases opened in error.
Data/Code fix ticket#: CJAMS-68506
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data fix only, no code changes required
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
-- 1. Update servicecase
UPDATE servicecase 
SET 
    activeflag = 0, 
    updatedby = 'CJAMS-68506', 
    updatedon = NOW()
WHERE 
    servicecaseid IN ('a15b629e-627f-4c26-a27e-1f4fa8503520', 'ddbabc6f-187b-4472-83a9-d9d9c7bccc68'); 
    -- Note: Assumed 'id' is the primary key for servicecase. Adjust if it is named differently.

-- 2. Update intakeservicerequest
UPDATE intakeservicerequest 
SET 
    servicecaseid = null, 
    updatedby = 'CJAMS-68506', 
    updatedon = NOW()
WHERE 
    servicecaseid IN ('a15b629e-627f-4c26-a27e-1f4fa8503520', 'ddbabc6f-187b-4472-83a9-d9d9c7bccc68');

-- 3. Update servicecasedisposition
UPDATE servicecasedisposition 
SET 
    activeflag = 0, 
    updatedby = 'CJAMS-68506', 
    updatedon = NOW()
WHERE 
    servicecaseid IN ('a15b629e-627f-4c26-a27e-1f4fa8503520', 'ddbabc6f-187b-4472-83a9-d9d9c7bccc68');

-- 4. Update routing
UPDATE routing 
SET 
    activeflag = 0, 
    updatedby = 'CJAMS-68506'
WHERE 
    objectid IN ('a15b629e-627f-4c26-a27e-1f4fa8503520', 'ddbabc6f-187b-4472-83a9-d9d9c7bccc68') 
    AND activeflag = 1;