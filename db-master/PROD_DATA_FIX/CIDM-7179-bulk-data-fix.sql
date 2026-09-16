--Buld data fix for usernotification table. Copy isread flag data from cjams.usernotificationmap to cjams.usernotification.
update cjams.usernotification u set isread=u1.isread
from cjams.usernotificationmap u1 
inner join cjams.usernotification u2 on u1.usernotificationid=u2.usernotificationid and u1.activeflag=1 and u2.activeflag=1
where u.usernotificationid=u1.usernotificationid and u.activeflag=1;

