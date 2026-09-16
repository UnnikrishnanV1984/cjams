-- CDM-10113 - removed end date for program assignment

update personprogramarea set enddate=null where personprogramid='e9bd40b0-9b48-4ee5-9cbb-b161291f339f' and activeflag=1;