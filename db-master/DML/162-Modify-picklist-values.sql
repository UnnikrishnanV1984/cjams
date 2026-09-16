
UPDATE cjams.referencevalues
SET  value_text='Voluntary relinquishment without post adoption contact', description='Voluntary relinquishment without post adoption contact', updatedon= now ()
WHERE ref_key='VOLLNQWOVIST' and referencetypeid=30 and   activeflag=1 and  displayorder=1 ;

UPDATE cjams.referencevalues
SET  value_text='Voluntary relinquishment with post adoption contact', description='Voluntary relinquishment with post adoption contact', updatedon= now ()
WHERE ref_key='VOLLNQVIST' and referencetypeid=30 and   activeflag=1 and  displayorder=1 ;

UPDATE cjams.referencevalues
SET  value_text='Parental Custodial rights terminated with post adoption contact rights', description='Parental Custodial rights terminated with post adoption contact rights', updatedon= now ()
WHERE ref_key='PARCRTWVR' and referencetypeid=30 and   activeflag=1 and  displayorder=1 ;

UPDATE cjams.referencevalues
SET  value_text='Parental Custodial rights terminated without post adoption contact rights', description='Parental Custodial rights terminated without post adoption contact rights', updatedon= now ()
WHERE ref_key='PARCRTWOVR' and referencetypeid=30 and   activeflag=1 and  displayorder=1 ;
