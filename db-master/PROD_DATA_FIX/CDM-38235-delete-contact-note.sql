/* CDM-38235
   Issue Description: 231030050717 Please delete the contact note written on March 22, 2024 with the contact date of November 15, 2023, 
                      Start Time : 1:30 PM, End Time : 2:00 PM , contact ID: 12789977.
   Category/ Module  :  Contacts
   Root cause: user requeseted to remove the contact note
   Fix Provided: Data fix has been promoted to delete the requested contact note 
*/

update progressnote 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38235'
where progressnoteid = '31c8aab8-647f-4831-bfea-c1efe5b86b26'
and witsid = 12789977 ;

update progressnotedetail 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38235'
where progressnoteid = '31c8aab8-647f-4831-bfea-c1efe5b86b26'
and activeflag = 1 ;

update contactparticipant 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38235'
where progressnoteid = '31c8aab8-647f-4831-bfea-c1efe5b86b26'
and activeflag = 1 ;

