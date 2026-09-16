/*
   Issue Description: CJAMS-58675 Add previously adopted persons
   Category/ Module  : Persons: Household
   Root cause: Data fix to update the following information in the person profile as those fields are not available for the user since the client is now an adult.
               Cjams id - 3755922 
                1.Has the child ever been legally adopted?  - Yes
                2. Previous adoption date -  9/25/2014
                3. Is the most recent prior adoption intercountry adoption?  - No
                4. Did the child have a prior legal guardianship before current OOH placement? - No
   Fix Provided: Data fix has been done to update the person adoption related information in the persons table.
   Data/Code fix ticket#: CJAMS-58675
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Person age restriction is not allowing to update information we can resolve it using the data fix. 
*/


update cjams.person
set everbeenadoptedflag = 1,
    intercountryadoption = 0,
    preadoptiondate = '2014-09-25 00:00:00.000',
    priorlegalguardianship = 0,
    updatedby = 'CJAMS-58675',
    updatedon = now()
where cjamspid = '3755922'
and activeflag =1;