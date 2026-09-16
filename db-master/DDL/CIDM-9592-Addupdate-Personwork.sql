/*
Issue Description:Console error on add person module
Category/ Module : Person Profile
Root cause:When entering the multiple contact numbers and emails in the UI, there is a console error saying that API request failed
Fix provided :As the column type is mismatched from how Stored procedure is saving data and the table column type, corrected this by converting the column to jsonb
Code fix ticket#:CIDM-9592
Reason why no related code fix:NA
Status of the code fix if already submitted and expected prod fix date:NA
Backup before update/ delete:
*/

ALTER TABLE
    cjams.personemployment
ALTER COLUMN
    workphone TYPE jsonb USING to_jsonb(workphone),
ALTER COLUMN
    email TYPE jsonb USING to_jsonb(email);