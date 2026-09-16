/*
   Issue Description: CDM-21940
   Category/ Module  : The user requested the highlighted date and time to be 
   replaced with April 1, 2022, 10:30:00 AM
*/


update ProgressNote set insertedon='2022-04-01 10:30:00', updatedon = now(),
updatedby = 'CDM-21940' where progressnoteid= '8b1109db-3fad-4141-b9d4-87a25ee934b8';

update progressnotedetail set insertedon='2022-04-01 10:30:00', updatedon = now(),
updatedby = 'CDM-21940' where progressnoteid= '8b1109db-3fad-4141-b9d4-87a25ee934b8';

