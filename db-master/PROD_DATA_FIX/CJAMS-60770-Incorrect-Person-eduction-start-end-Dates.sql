/*
Issue Description: The attendance start date and end date for the Frankfort Middle School education record are incorrect in the Education screen.
Frontend (UI) does not allow date correction due to BID date locking.Expected correct dates:Start Date: 2/27/2024 End Date: 6/5/2024
Root cause: The attendance dates got locked because of BID system notifications or backend automation that overwrites dates.
Fix provided: DB queries to update query to progressnote table
Data/Code fix ticket#: CJAMS-60770
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update personeducation
set startdate = '2024-02-27 00:00:00' , enddate = '2024-06-05 00:00:00',updatedby = 'CJAMS-60770', updatedon = now()
where personeducationid = '387cd901-180c-4639-80b3-2bcedbed0e96' and activeflag=1;