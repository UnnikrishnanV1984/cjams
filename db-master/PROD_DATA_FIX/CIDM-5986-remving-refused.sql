update personexamination set appointkeptflag = 0 ,
notkeptreason = 'Youth refused to attend/schedule',
updatedby ='CIDM-5986',
updatedon =now()
 where appointkeptflag = 2;