/*
 Issue: Incomplete GAP Determination
 Category/Module: PermanencyPlans/GAP
 Root cause: Service case number is not linking with the GAP case and there is no case number showing
 Fix provided: DB query to add the missing data to the worksheet
 Data/Code fix ticket#: CDM-42896
 Regression Impacts: N/A
 Is Code fix Required?: No
 Code fix ticket#: N/A
 Reason why no related code fix: NA
 Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
 Backup before update/ delete:Query:
 */
UPDATE
    cjams.gapeligibilityinfo
SET
    casenumber = '2020019501797',
    servicecaseid = '5e04a925-37c5-4723-90da-791cb71ba760',
    updatedby = 'CDM-42896',
    updatedon = now()
WHERE client_id = '2654841' and activeflag =1;