/* 
   Issue Description: CDM-20123
   Category/ Module  : Contact notes
   Root cause: Contact notes are showing duplicates in PDF. Issue has been already addressed with code fix. So doing data fix for the issue
*/

update progressnotedetail 
set activeflag = 0, updatedby = 'CDM-14992', updatedon = now()
where progressnotedetailid in ('4a102675-e060-44d1-9648-fb741a348855',
								'6ea213f2-f962-43f0-addf-0445875b88bf',
								'cb06bcfa-1712-44f7-b5a1-8452d24c47c2',
								'11055933-79ce-4b7b-9abd-1899e7cf7cfb',
								'f005fdb9-e168-4264-9bd8-06ee22ed6640');
