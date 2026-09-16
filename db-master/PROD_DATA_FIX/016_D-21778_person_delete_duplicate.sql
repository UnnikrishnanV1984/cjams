UPDATE person SET activeflag =  0
		,updatedby = 'admin-D21778'
		,updatedon = now()
WHERE  personid = 'bedfea94-5bef-4260-9f3a-4030e361f3fa'
AND cisclientid = '448042339' 
AND cjamspid = '200000420'
AND activeflag = 1;


UPDATE personidentifier SET activeflag = 0
		,updatedby = 'admin-D21778'
		,updatedon = now()
WHERE personid = 'bedfea94-5bef-4260-9f3a-4030e361f3fa'
AND personidentifierid in ('afb892ab-237b-4ea2-80b4-17e7d4b549b1','81c8fa42-5483-4145-99b3-904a3ee81714')
AND activeflag = 1;