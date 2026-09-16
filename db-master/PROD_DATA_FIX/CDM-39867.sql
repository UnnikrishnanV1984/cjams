/*
 * CDM-39867 - calendar is grayed out
 * Customer Email ID:kathryn.morton@maryland.gov
 * Description - 221030036453:Worker is unable to end service log for Rosalie Burgess because the 
 * calendar is grayed out and will not allow us to end date it.
 * OOH program assignment end-date need to be removed.
 * 
 */

--select * from personprogramarea where personprogramid = '809fe370-3662-4639-9273-eb86c7405727';
UPDATE cjams.personprogramarea
SET enddate=null, updatedby='CDM-39867', updatedon=now() 
WHERE personprogramid = '809fe370-3662-4639-9273-eb86c7405727';
