UPDATE cjams.referencevalues
SET value_text='Dental Exam (Form 631-E)', description='Dental Exam (Form 631-E)', updatedby='CDM-44598', updatedon=now()
WHERE referencevaluesid='4d4bd362-7818-4732-8bc0-6059c942e3ae'::uuid and ref_key='denam' and  parentkey='medts';