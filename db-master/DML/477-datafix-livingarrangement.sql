
UPDATE cjams.livingarrangement SET primarycaregiver = livingfirstname WHERE primarycaregiver IS NULL;
--Copying comment data from 'livingfirstname' to 'primarycaregiver'
--Further fix required to populate 'primarycaregiverid' with personid of primarycaregiver whereever possible.-TODO: Data migration team.