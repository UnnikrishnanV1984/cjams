/*
 * CDM-34746 - Program Assignment
 * Customer Email ID:rebecca.biggs1@maryland.gov
 * Customer Name:Rebecca Biggs
 * Focus Area:Persons: Household
 * Description - 211030010424:Unable to end date program assignment so I can close the case
 * 
 */

select startdate , enddate , * from personprogramarea where personprogramid = 'b0ed5fa6-df34-4b94-9298-759949ba6a63';
UPDATE cjams.personprogramarea
SET enddate='2012-09-18', updatedon=now(), updatedby='CDM-34746' 
where personprogramid='b0ed5fa6-df34-4b94-9298-759949ba6a63'::uuid;

select startdate , enddate , * from personprogramarea where personprogramid = '4f01a7b3-6845-4f9b-9ee6-4f7b7fd630b0';
UPDATE cjams.personprogramarea
SET enddate='2012-09-18', updatedon=now(), updatedby='CDM-34746' 
where personprogramid='4f01a7b3-6845-4f9b-9ee6-4f7b7fd630b0'::uuid;

select startdate , enddate , * from personprogramarea where personprogramid = 'c33a8186-9c7a-490c-8e08-020fa7c1ca54';
UPDATE cjams.personprogramarea
SET enddate='2012-09-18', updatedon=now(), updatedby='CDM-34746' 
where personprogramid='c33a8186-9c7a-490c-8e08-020fa7c1ca54'::uuid;

select startdate , enddate , * from personprogramarea where personprogramid = 'a0df938e-a6b2-4a54-bc49-8de819b24818';
UPDATE cjams.personprogramarea
SET enddate='2012-09-18', updatedon=now(), updatedby='CDM-34746' 
where personprogramid='a0df938e-a6b2-4a54-bc49-8de819b24818'::uuid;
