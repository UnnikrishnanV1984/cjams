/*
 * CDM-42231
 * Description - user attempted to put an entry three times into contact>meeting. Although I have hit save each time, the entry does not appear in the meetings section.
 * case ID: 3081315
 * CPS - servicecaseid: 3bc7592e-eb01-4513-9a5e-25dfe4e3ec58
 * Note: there was pagination issue was also there so applied the code fix with same CDM.
 */

/*
select updatedon,insertedon,meetingdate,effectivedate,* 
from meetingrecording where servicecaseid = '3bc7592e-eb01-4513-9a5e-25dfe4e3ec58'
and meetingrecordingid in ('1c39e591-f964-4b4f-8d17-8c451b7574e6','9d810723-f555-4624-8c5d-cc3b98c27e3b','dda78855-28a0-4097-be30-e45389c316b7')
and activeflag = 1;

*/
update meetingrecording
set activeflag = 0,
	updatedby = 'CDM-42231',
	updatedon = now()
where servicecaseid = '3bc7592e-eb01-4513-9a5e-25dfe4e3ec58'
and meetingrecordingid in ('1c39e591-f964-4b4f-8d17-8c451b7574e6',
                            '9d810723-f555-4624-8c5d-cc3b98c27e3b',
                            'dda78855-28a0-4097-be30-e45389c316b7') -- Duplicate Record
and activeflag = 1;