--D-22708
UPDATE personidentifier SET personidentifiervalue = 'MDT-124789014' , updatedon = now()
WHERE personidentifiervalue = 'MDT-130815505';

UPDATE personprogramarea SET activeflag = 0, updatedon = now() WHERE personprogramid ='174a242a-e2bd-4b75-878d-10c7732bfd2b';
