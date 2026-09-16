-- CDM-10732 - Update program assignment along with child removal end date

update personprogramarea set enddate = '2020-07-01 10:33:32', updatedby= 'CDM-10732', updatedon = now() where personprogramid='02d4ec84-42e0-4883-8fa1-33203827b8e7';
