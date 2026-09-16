update personprogramarea set enddate = now(), updatedon = now(), updatedby = 'CDM-8726' where personprogramid = 'ab8c2d42-8ca8-4612-b1e1-c51a8a25a20d';

update intakeservreqchildremoval set exitdate = null, returndate = null, returntime = null, removalexitreason = null, updatedon = now(), updatedby = 'CDM-8726' where intakeservreqchildremovalid = '2cc3d63c-39e4-4f51-a8d9-137b97c9e3d8';