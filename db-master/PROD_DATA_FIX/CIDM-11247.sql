-- CIDM-11247 - Users are unable to view and approve the tickets as data is missing for ldssregion
-- 			 	Data fix to correct the records where ldss region is missing
-- 			 	Code fix also puhsed along with data fix

update defecttracking.supportlog s
	set ldssregion = (select countyname from cjams.v_userprofile vu where securityusersid = s.insertedby limit 1),
		updatedby = 'CIDM-11247',
		updatedon = now()
	where application = 'CW'
		and date(insertedon) = '2026-03-20'
		and ldssregion is null; 