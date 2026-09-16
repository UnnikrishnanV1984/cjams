/*
    CDM-16319
    Issue: Duplicate placement getting created
    Root cause: Unable to reproduce the issue in stage3
    Fix: Done data fix for now
*/
update livingarrangement 
set updatedby = 'CDM-16319', updatedon = now(), activeflag = 0
where placementid in ('7e7bd970-f6fd-4fd0-8679-228960fadc1b', '3f63ecb2-6eed-46ae-92bd-8073f89b60a8', '55d05e38-6c1e-4888-a17a-6199b8d855db', 'd417f798-f61d-4bfa-8315-4c0041729822', 'fd309b33-ab07-43a0-8f7a-3f77ba40f010', '9f19419d-6825-4246-a998-6d90b62e42f1');

update placement
set updatedby = 'CDM-16319', updatedon = now(), activeflag = 0
where placementid in ('7e7bd970-f6fd-4fd0-8679-228960fadc1b', '3f63ecb2-6eed-46ae-92bd-8073f89b60a8', '55d05e38-6c1e-4888-a17a-6199b8d855db', 'd417f798-f61d-4bfa-8315-4c0041729822', 'fd309b33-ab07-43a0-8f7a-3f77ba40f010', '9f19419d-6825-4246-a998-6d90b62e42f1');

update routing 
set updatedby = 'CDM-16319', updatedon = now(), activeflag = 0
where objectid in ('7e7bd970-f6fd-4fd0-8679-228960fadc1b', '3f63ecb2-6eed-46ae-92bd-8073f89b60a8', '55d05e38-6c1e-4888-a17a-6199b8d855db', 'd417f798-f61d-4bfa-8315-4c0041729822', 'fd309b33-ab07-43a0-8f7a-3f77ba40f010', '9f19419d-6825-4246-a998-6d90b62e42f1');
