/*
 Issue Description: CDM-42912
 Category/ Module: Approval
 Root cause: Team assignment issue
 Pull request# for code fix: NA
 Reason why no related code fix: NA
 Status of the code fix if already submitted and expected prod fix date: NO
 Backup before update/ delete: NA
 */

update teammember set teamid = 'abf11605-707e-457d-9f07-6a31abca13d7',
updatedby='CDM-42912',updatedon = now()
where teammemberid = '068391d3-8e87-41dc-8c8e-a251340fa7fb' and activeflag = 1;
