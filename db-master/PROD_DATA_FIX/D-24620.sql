--D-24620 data fix

update usernotification set activeflag =0 , updatedby = 'D-24620', updatedon = now() where activeflag =1 and usernotificationid = '96d26ae9-d5f6-4033-86b6-98b5f2ca6178'

