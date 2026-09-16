/*
Issue:261023815520:The 'child fatality' button on the Maltreatment Type tab needs to be marked yes.
Root Cause:Victim child has died and the 'child fatality' radio button needs to be checked yes and also medical neglect should be checked 
Fix Provided (Data Fix Only): Data fix is done to update the child fatality from No to Yes and check the medical neglect .
Data/Code fix ticket#: CJAMS-68282
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a single referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
 */
 
update intakesnapshot
set
    jsondata = jsonb_set (
        jsonb_set (
            jsonb_set (jsondata, '{sdm,childfatality}', '"yes"'),
            '{sdm,ischildfatality}',
            'true'
        ),
        '{sdm,isnegmn_unreasonabledelay}',
        'true'
    ),
    updatedby = 'CJAMS-68282',
    updatedon = now ()
where
    intakenumber = 'I261014091973'
    and activeflag = 1;

update intakeservicerequestsdm
set
    ischildfatality = true,
    isnegmn_unreasonabledelay = true,
    updatedby = 'CJAMS-68282',
    updatedon = now ()
where
    intakeserviceid = '4ea11539-0cc1-4aea-9b4d-4499bfe17395'
    and activeflag = 1;

update intakedastaging
set
    jsondata = jsonb_set (
        jsonb_set (
            jsonb_set (jsondata, '{sdm,childfatality}', '"yes"'),
            '{sdm,ischildfatality}',
            'true'
        ),
        '{sdm,isnegmn_unreasonabledelay}',
        'true'
    ),
    updatedby = 'CJAMS-68282',
    updatedon = now ()
where
    intakenumber = 'I261014091973'
    and activeflag = 1;