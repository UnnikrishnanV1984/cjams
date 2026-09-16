-- CDM-9088 - Remove unnecessary record from Permanency plan history

delete from permanencyplanhistory where permanencyplanhistoryid = '638ad046-a019-4a9b-8180-dc4ea6769ed2' and status = 'Review';