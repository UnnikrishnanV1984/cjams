--04/11/2023 MOUNIKA GUDISE updating description column (CIDM-6925)

update referencevalues set description ='The child has, or had previously, a neurodevelopmental disorder,
characterized by social impairments, communication difficulties, and restricted, repetitive, and
stereotyped patterns of behavior. This includes the range of disorders from autistic disorder,
sometimes called autism or classical autism spectrum disorder, to milder forms known as
Asperger syndrome and pervasive developmental disorder not otherwise specified.', updatedby  ='CIDM-6925',
updatedon =now()  where value_text= 'Autism Spectrum Disorder' and referencetypeid=97 and teamtypekey='CW' and activeflag  =1;

update referencevalues set description ='The child has, or had previously, a visual impairment that may
adversely affect the day-to-day functioning or educational performance, such as blindness,
amblyopia, or color blindness', updatedby  ='CIDM-6925',
updatedon =now() where value_text= 'Visual Impairment and Blindness' and referencetypeid=97 and teamtypekey='CW' and activeflag  =1;

update referencevalues set description ='The child has, or had previously, a diagnosis of a serious mental
disorder or illness, such as bipolar disorder, depression, psychotic disorders, or schizophrenia.', updatedby  ='CIDM-6925',
updatedon =now() where value_text= 'Serious Mental Disorders' and referencetypeid=97 and teamtypekey='CW' and activeflag  =1;

update referencevalues set description ='The child has been assessed by appropriate diagnostic instruments and
procedures and is experiencing delays in one or more of the following areas: physical
development or motor skills, cognitive development, communication, language, or speech
development, social or emotional development, or adaptive development.', updatedby  ='CIDM-6925',
updatedon =now() where value_text= 'Developmental Delay' and referencetypeid=97 and teamtypekey='CW' and activeflag  =1;

update referencevalues set value_text ='Mental/Emotional Disorder',description ='The child has, or had previously, one or more mood or personality
disorders or conditions over a long period of time and to a marked degree, such as conduct
disorder, oppositional defiant disorder, emotional disturbance, anxiety disorder,
obsessive-compulsive disorder, or eating disorder.', updatedby  ='CIDM-6925',
updatedon =now() where value_text= 'Mental/Emotions Disorder' and referencetypeid=97 and teamtypekey='CW' and activeflag  =1;

update referencevalues set description ='The child has, or had previously, an impairment in hearing,
whether permanent or fluctuating, that adversely affects the child’s day-to-day functioning and
educational performance.', updatedby  ='CIDM-6925',
updatedon =now() where value_text= 'Hearing Impairment and Deafness' and referencetypeid=97 and teamtypekey='CW' and activeflag  =1;

update referencevalues set description ='The child has, or had previously, a diagnosed condition or other
health impairment other than those described above, which requires special medical care, such
as asthma, diabetes, chronic illnesses, a diagnosis as HIV positive or AIDS, epilepsy, traumatic
brain injury, other neurological disorders, speech/language impairment, learning disability, or
substance abuse issues.', updatedby  ='CIDM-6925',
updatedon =now() where value_text= 'Other Diagnosed Condition' and referencetypeid=97 and teamtypekey='CW' and activeflag  =1;

update referencevalues set description ='The child has, or had previously, a physical
deformity, such as amputations and fractures or burns that cause contractures, or an orthopedic
impairment, including impairments caused by a congenital anomalies or disease, such as
cerebral palsy, spina bifida, multiple sclerosis, or muscular dystrophy.', updatedby  ='CIDM-6925',
updatedon =now() where value_text= 'Orthopedic Impairment or Other Physical Condition' and referencetypeid=97 and teamtypekey='CW' and activeflag  =1;

update referencevalues set description ='The child has, or had previously, a visual impairment that may
adversely affect the day-to-day functioning or educational performance, such as blindness,
amblyopia, or color blindness', updatedby  ='CIDM-6925',
updatedon =now() where value_text= 'Visual Impairment and Blindness' and referencetypeid=97 and teamtypekey='CW' and activeflag  =1;

update referencevalues set description ='The child has, or had previously, a diagnosis of the
neurobehavioral disorders of attention deficit or hyperactivity disorder (ADHD) or attention
deficit disorder (ADD).' , updatedby  ='CIDM-6925',
updatedon =now() where value_text= 'Attention Deficit Hyperactivity Disorder' and referencetypeid=97 and teamtypekey='CW' and activeflag  =1;

update referencevalues set description ='The child has, or had previously, significantly subaverage general cognitive
and motor functioning existing concurrently with deficits in adaptive behavior manifested during
the developmental period that adversely affect the childs socialization and learning.', updatedby  ='CIDM-6925',
updatedon =now() where value_text= 'Intellectual Disability' and referencetypeid=97 and teamtypekey='CW' and activeflag =1;

 update referencevalues set description ='The child has or had previously been diagnosed with a developmental
disability.This means a severe chronic disability of an individual that is attributable to a mental
or physical impairment or combination of mental and physical impairments that manifests
before the age of 22 is likely to continue indefinitely and results in substantial functional
limitations in three or more areas of major life activity. Areas of major life activity include
self-care receptive and expressive language learning mobility,self-direction,capacity for
independent living economic self-sufficiency,and reflects the individuals need for a
combination and sequence of special, interdisciplinary,orgeneric services,individualized
supports or other forms of assistance that are of lifelong or extended duration and are
individually planned and coordinated.If a child is given the diagnosis of developmental
disability,do not indicate the individual conditions that form the basis of this diagnosis separately.', updatedby  ='CIDM-6925',
updatedon =now() where value_text= 'Developmental Disability' and referencetypeid=97 and teamtypekey='CW' and activeflag =1;
