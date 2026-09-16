/*
Issue: CJAMS-62877 GAP agreement triggered overpayment
Category/Module: GAP
Root cause: This is a migrated case from Chessie and the GAP agreement is not entered correctly as the Guardianship is started on 12/03/2012. 
User requested to update the GAP Agreement start date to 12/03/2012 & remove the subsidy rate slab on 09/20/2010 to 09/19/2011.
We need to do a data fix to update the agreement dates and generate the Account Receivables.
Fix provided: Data fix done for following items as requested by the user 
              1) Update the GAP agreement start date from 09/20/2010 to 12/03/2012
              2) Remove the Subsidy Rate slab on 09/20/2010 to 09/19/2011, and Update the Guardianship Start Date from 09/20/2010 to 12/03/2012.
Data/Code fix ticket#: CJAMS-62877
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The is a migrated case with user entry error.
*/

-- updating agreement start date in gapagreement table.

update gapagreement
set startdate = '2012-12-03 00:00:00.000',
    updatedby = 'CJAMS-62877',
    updatedon = now()
where gapagreementid = 'f95d2cdf-37ba-47e8-a12d-12b40ad22f93';

-- updating agreement start date in gapagreementrevision table and also triggering the payment batch for all the susbidy created.

update gapagreementrevision 
set startdate = '2012-12-03 00:00:00.000',
    updatedon = now(),
    approvaldate = now(), 
    updatedby = 'CJAMS-62877' 
where gapagreementid = 'f95d2cdf-37ba-47e8-a12d-12b40ad22f93';

--Deactivating the incorrect subsidy rate period in gapagreementrate table
update gapagreementrate
set activeflag = 0,
    updatedby = 'CJAMS-62877',
    updatedon = now()
where  gapagreementrateid = '4042e39f-da19-4e68-a9ab-bb0b896d641d';

--Deactivating the incorrect subsidy rate period in gapratesrevision table
update gapratesrevision
set activeflag = 0,
    updatedby = 'CJAMS-62877',
    updatedon = now()
where  gaprateid = '4042e39f-da19-4e68-a9ab-bb0b896d641d';


--Deactivating the routing records
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-62877'
where objectid = '4042e39f-da19-4e68-a9ab-bb0b896d641d'; 

--To Trigger overpayment batch for all the gap rate records
update gapagreementrate
set updatedby = 'CJAMS-62877',
    updatedon = now()
where  gapagreementid  = 'f95d2cdf-37ba-47e8-a12d-12b40ad22f93'
and activeflag =1;