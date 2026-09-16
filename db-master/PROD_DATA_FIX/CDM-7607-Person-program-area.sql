update personprogramarea set activeflag = 0, updatedby = 'CDM-7607', updatedon = now() where personprogramid = 'bad360d5-c671-4c7f-be0c-3bfa729a013d';

update personprogramarea set enddate = null, updatedby = 'CDM-7607', updatedon = now() where personprogramid in ('e5d92f28-513f-4d0a-9ed2-84ba222afbd2', 'ca93e7e8-4216-4ad2-b2cf-53e3ad23006f');