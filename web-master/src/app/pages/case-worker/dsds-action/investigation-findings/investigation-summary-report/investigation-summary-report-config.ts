export class ComarFindings {
  public static ComarFindingsList: any = {
    'SEXUAL-ABUSEID': {
      value: 'Sexual Abuse of <b>${comar?.victimname}</b> is <b>"INDICATED"<b> in accordance with the provisions of Maryland Code Ann.,' + 
      'Fam. Law § 5-701(b)(2), (m), (y)(1) and COMAR 07.02.07.11A(2). It is the professional assessment of this worker that ' + 
      'sexual abuse occurred because the evidence supports all of the following elements:<br><br>' + 
     '1) An act that involves sexual molestation or sexual exploitation (describe in detail): <b>${findingcomments}</b><br>' + 
      '2) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>' + 
      '3) The act involving sexual molestation or exploitation was by a parent, caregiver, authority figure or by a household or family member ' + 
      '(Insert name and whether the person is a parent,OR caregiver, OR authority figure, OR household OR family member): <b>${comar?.caretakername}</b><br>'},
    'SEXUAL-ABUSERO': {
      value: 'Sexual Abuse of <b>${comar?.victimname}</b> is <b>"RULED OUT"</b> in accordance with the provisions of Maryland Code Ann.,' + 
      'Fam. Law § 5-701(b)(2), (w), (y)(1) and COMAR 07.02.07.11C. It is the professional assessment of this worker that sexual' + 
      'abuse did not occur because the evidence does not support one or more of the following elements: (Indicate which element ' + 
      'or elements were not met in a bulleted format or short narrative.)<br><br>' + 
      '1) An act that involves sexual molestation or sexual exploitation (describe in detail): <b>${findingcomments}</b><br>' + 
      '2) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>' + 
      '3) The act involving sexual molestation or exploitation was by a parent, caregiver, authority figure or by a household or family member' + 
      '(Insert name and whether the person is a parent, OR caregiver, OR authority figure, OR household OR family member): <b>${comar?.caretakername}</b><br>'},
    'SEXUAL-ABUSEUD': {
      value: 'Sexual Abuse of <b>${comar?.victimname}</b> is <b>"UNSUBSTANTIATED"</b> in accordance with the provisions of Maryland Code Ann.,' + 
      'Fam. Law § 5-701(b)(2), (y)(1), (aa) and COMAR 07.02.07.11B. It is the professional assessment of this worker that some credible' + 
      'evidence supports each of the following elements but is insufficient to conclude that abuse occurred: (Specify which element or ' + 
      'elements caused the finding to be "unsubstantiated" and not "indicated" or "ruled out".)<br><br>' + 
      '1) An act that involves sexual molestation or sexual exploitation (describe in detail): <b>${findingcomments}</b><br>' + 
      '2) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>' + 
      '3) The act involving sexual molestation or exploitation was by a parent, caregiver, authority figure or by a household or family member' + 
      '(Insert name and whether the person is a parent,OR caregiver, OR authority figure, OR household OR family member): <b>${comar?.caretakername}</b><br>'},
    'SEX-TRAFFICKING-INDICATED': {
      value: 'Sexual Abuse – Sex Trafficking of <b>${comar?.victimname}</b> is <b>"INDICATED"</b> in accordance with the provisions of Maryland Code Ann.,' + 
      'Fam. Law § 5-701(b)(2), (m), (x),(y)(2) and COMAR 07.02.07.11A(2). It is the professional assessment of this worker that sexual abuse ' + 
      'occurred because the evidence supports all of the following elements:<br><br>' + 
      '1) An act that involves sex trafficking (describe in detail): <b>${findingcomments}</b><br>' + 
      '2) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>'},
    'SEX-TRAFFICKING-RULED-OUT': {
      value: 'Sexual Abuse – Sex Trafficking of <b>${comar?.victimname}</b> is <b>"RULED OUT"</b> in accordance with the provisions of Maryland Code Ann.,' + 
      'Fam. Law § 5-701(b)(2), (W), (x),(y)(2) and COMAR 07.02.07.11C. It is the professional assessment of this worker that sexual abuse did ' + 
      'not occur because the evidence does not support one or more of the following elements: (Indicate which element or elements were not supported' + 
      'in a bulleted format or short narrative.)<br><br>' + 
      '1) An act that involves sex trafficking (describe in detail): <b>${findingcomments}</b><br>' + 
      '2) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>'},
    'SEX-TRAFFICKING-UNSUBSTANTIATED': {
      value: 'Sexual Abuse – Sex Trafficking of <b>${comar?.victimname}</b> is <b>"UNSUBSTANTIATED "</b> in accordance with the provisions of Maryland Code Ann.,' + 
      'Fam. Law § 5-701(b)(2), (x),(y)(2), (aa) and COMAR 07.02.07.11B.It is the professional assessment of this worker that some credible evidence ' + 
      'supports each of the following elements but is insufficient to conclude that abuse occurred: (Specify which element or elements caused the finding' + 
      'to be "unsubstantiated" and not "indicated" or "ruled out".)<br><br>' + 
      '1) An act that involves sex trafficking (describe in detail): <b>${findingcomments}</b><br>' + 
      '2) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>'},
    'PHYSICAL-ABUSEUD': {
      value: 'Physical Abuse of <b>${comar?.victimname}</b> is <b>"UNSUBSTANTIATED"</b> in accordance with the provisions of Maryland Code Ann.,' + 
      'Fam. Law § 5-701(b)(1), (aa) and COMAR 07.02.07.11B. It is the professional assessment of this worker that some credible evidence' + 
      'supports each of the following elements but is insufficient to conclude that abuse occurred: (Specify the element or elements that caused' + 
      'the finding to be "unsubstantiated" and not "indicated" or "ruled out".)<br><br>' + 
      '1) A physical injury (brief description of the current or prior injury): <b>${findingcomments}</b><br>' + 
      '2) The injury was caused by a parent, caregiver, authority figure, or household or family member (Insert name and whether the person' + 
      'is a parent, OR caregiver, OR authority figure, OR household OR family member): <b>${comar?.caretakername}</b><br>' + 
      '3) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>' + 
      '4) Circumstances including the nature, extent, and location of the injury indicate (describe either OR both using a bulleted format or short narrative)<br>' + 
      '  &ensp; i) Harm to a child: <b>${harmchild}</b> <br>' + 
      '  &ensp; ii)During the incident, a substantial risk of harm to a child: <b>${riskofharm}</b> <br> <b>${circumstancescomments}</b><br>' + 
      '5) The injury was not caused by accidental means (provide details supporting either an intentional act or reckless disregard for the child’s health or ' + 
      'welfare causing the injury): <b>${intentionalinjurydesc}</b>'},
    'PHYSICAL-ABUSERO': {
      value: 'Physical Abuse of <b>${comar?.victimname}</b> is <b>"RULED OUT"</b> in accordance with the provisions of Maryland Code Ann., Fam. Law§ 5-701(b)(1), (w), ' + 
      'and COMAR 07.02.07.11C. It is the professional assessment of this worker that physical abuse did not occur because the evidence does not support one ' + 
      'or more of the following elements: (Indicate which element or elements were not supported in a bulleted format or short narrative.)<br><br>' + 
      '1) A physical injury (brief description of the current or prior injury): <b>${findingcomments}</b><br>' + 
      '2) The injury was caused by a parent, caregiver, authority figure, or household or family member(Insert name and whether the person is a parent, OR caregiver,' + 
      'OR authority figure, OR household OR family member): <b>${comar?.caretakername}</b><br>' + 
      '3) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>' + 
      '4) Circumstances including the nature, extent, and location of the injury indicate (describe either OR both using a bulleted format or short narrative)<br>' + 
      '  &ensp; i) Harm to a child: <b>${harmchild}</b> <br> ' + 
      '  &ensp; ii)During the incident, a substantial risk of harm to a child: <b>${riskofharm}</b> <br> <b>${circumstancescomments}</b><br>' + 
      '5) The injury was not caused by accidental means (provide details supporting either an intentional act or reckless disregard for the child’s health or welfare' + 
      'causing the injury): <b>${intentionalinjurydesc}</b><br>'},
    'PHYSICAL-ABUSEID': {
      value: 'Physical Abuse of <b>${comar?.victimname}</b> is <b>"INDICATED"</b> in accordance with the provisions of Maryland Code Ann.,Fam. Law § 5-701(b)(1),' + 
      '(m) and COMAR 07.02.07.11A(1). It is the professional assessment of this worker that physical abuse occurred because the evidence supports all of' + 
      'the following elements:<br><br>' + 
      '1) A physical injury (brief description of the current or prior injury): <b>${findingcomments}</b><br>' + 
      '2) The injury was caused by a parent, caregiver, authority figure, or household or family member (Insert name and whether the person is a parent, OR caregiver,' + 
      'OR authority figure, OR household OR family member): <b>${comar?.caretakername}</b><br>' + 
      '3) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>' + 
      '4) Circumstances including the nature, extent, and location of the injury indicate (describe either OR both using a bulleted format or short narrative)<br>' + 
      '  &ensp; i) Harm to a child: <b>${harmchild}</b> <br> ' + 
      '  &ensp; ii) During the incident, a substantial risk of harm to a child: <b>${riskofharm}</b> <br> <b>${circumstancescomments}</b><br>' + 
      '5) The injury was not caused by accidental means (provide details supporting either an intentional act or reckless disregard for the child’s health or welfare' + 
      'causing the injury): <b>${intentionalinjurydesc}</b><br>'},
    'NEGLECTUD': {
      value: 'Neglect of <b>${comar?.victimname}</b> is <b>"UNSUBSTANTIATED"</b> in accordance with the provisions of Maryland Code Ann., Fam. Law § 5-701(s),(aa) and COMAR COMAR 07.02.07.12B.' + 
      'It is the professional assessment of this worker that some credible evidence supports each of the following elements but is insufficient to ' + 
      'conclude that neglect occurred: (Specify which element or elements caused the finding to be "unsubstantiated" and not "indicated" or "ruled out".)<br><br>' + 
      '1) A failure to provide proper care including leaving a child unattended (brief description of the lack of proper care or attention): <b>${findingcomments}</b><br>' + 
      '2) The failure was caused by a parent or caregiver (Insert name and indicate whether the person is a parent OR caregiver): <b>${comar?.caretakername}</b><br>' + 
      '3) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>' + 
      '4) Circumstances including the nature, extent, and causeof the alleged neglect indicate that there was (describe either OR both using a bulleted format or short narrative)<br>' + 
      '&ensp; i) Harm to a child: <b>${harmchild}</b> <br> ' + 
      '&ensp; ii) During the incident, a substantial risk of harm to a child: <b>${riskofharm}</b><br> <b>${circumstancescomments}</b><br>'},
    'NEGLECTRO': {
      value: 'Neglect of <b>${comar?.victimname}</b> is <b>"RULED OUT"</b> in accordance with the provisions of Maryland Code Ann., Fam. Law$ 5-701(s), (w) and 07.02.07.12C.' + 
      'It is the professional assessment of this worker that neglect did not occur because the evidence does not support one or more ofthe following' + 
      'elements: (Indicate which element or elements were not supported in a bulleted format or short narrative.)<br><br>' + 
      '1) A failure to provide proper care including leaving a child unattended (brief description of the lack of proper care or attention): <b>${findingcomments}</b><br>' + 
      '2) The failure was caused by a parent or caregiver (Insert name and indicate whether the person is a parent OR caregiver): <b>${comar?.caretakername}</b><br>' + 
      '3) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>' + 
      '4) Circumstances including the nature, extent, and causeof the alleged neglect indicate that there was (describe either OR both using a bulleted format or short narrative)<br>' + 
      '&ensp; i) Harm to a child: <b>${harmchild}</b> <br>' + 
      '&ensp; ii) During the incident, a substantial risk of harm to a child: <b>${riskofharm}</b><br> <b>${circumstancescomments}</b><br>'},
    'NEGLECTID': {
      value: 'Neglect of <b>${comar?.victimname}</b> is <b>"INDICATED"</b> in accordance with the provisions of Maryland Code Ann., Fam. Law $ 5-701(m), (s) and COMAR 07.02.07.12A(1).' + 
      'It is the professional assessment of this worker that neglect occurred because the evidence supports all of the following elements:<br><br>' + 
      '1) A failure to provide proper care including leaving a child unattended (brief description of the lack of proper care or attention): <b>${findingcomments}</b><br>' + 
      '2) The failure was caused by a parent or caregiver (Insert name and indicate whether the person is a parent OR caregiver): <b>${comar?.caretakername}</b><br>' + 
      '3) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>' + 
      '4) Circumstances including the nature, extent, and causeof the alleged neglect indicate that there was (describe either OR both using a bulleted format or short narrative)<br>' + 
      '&ensp; i) Harm to a child: <b>${harmchild}</b> <br>' + 
      '&ensp; ii) During the incident, a substantial risk of harm to a child: <b>${riskofharm}</b> <br> <b>${circumstancescomments}</b><br>'},
    'MENTAL-INJURY-ABUSE-ID': {
      value: 'Mental Injury Abuse of <b>${comar?.victimname}</b> is <b>"INDICATED"</b> in accordance with the provisions of Maryland Code Ann., Fam. Law § 5-701(b)(1),' + 
      '(m), (r) and COMAR 07.02.07.11A(3). It is the professional assessment of this worker that mental injury abuse occurred because the evidence supports ' + 
      'all of the following elements:<br><br>' + 
      '1) An injury characterized by an observable, identifiable, and substantial impairment of a mental or psychological ability to function (explain the impairment): <b>${findingcomments}</b><br>' + 
      '2) The injury was caused by an intentional act or series of intentional acts (regardless of whether there was an intent to harm the child)(provide details of an intentional act or ' + 
      'series of acts that caused the impairment): <b>${intentionalinjurydesc}</b><br>' + 
      '3) The act was caused by a parent, caregiver, authority figure, or household or family member (Insert name and whether the person is a parent,OR caregiver, OR authority figure, OR ' + 
      'household OR family member): <b>${comar?.caretakername}</b><br>' + 
      '4) The victim was a child under the age of 18 (child’s DOB): <b>${comar?.victimdob}</b><br>'},
    'MENTAL-INJURY-ABUSE-RO': {
      value: 'Mental Injury Abuse of <b>${comar?.victimname}</b> is <b>"RULED OUT"</b> in accordance with the provisions of Maryland Code Ann., Fam. Law § 5-701(b)(1),' + 
      '(r), (w) and COMAR 07.02.07.11C(1).It is the professional assessment of this worker that mental injury abuse did not occur because the evidence does not' + 
      'support one or more of the following elements: (Indicate which element or elements were not supported in a bulleted format or short narrative.)<br><br>' + 
      '1) An injury characterized by an observable, identifiable, and substantial impairment of a mental or psychological ability to function (explain the impairment): <b>${findingcomments}</b><br>' + 
      '2) The injury was caused by an intentional act or series of intentional acts (regardless of whether there was an intent to harm the child) (provide details of an intentional act or' + 
      'series of acts that caused the impairment): <b>${intentionalinjurydesc}</b><br>' + 
      '3) The act was caused by a parent, caregiver, authority figure, or household or family member (Insert name and whether the person is a parent,OR caregiver, OR authority figure,' + 
      'OR household OR family member): <b>${comar?.caretakername}</b><br>' + 
      '4) The victim was a child under the age of 18 (child’s DOB): <b>${comar?.victimdob}</b><br>'},
    'MENTAL-INJURY-ABUSE-UD': {
      value: 'Mental Injury Abuse of <b>${comar?.victimname}</b> is <b>"UNSUBSTANTIATED"</b> in accordance with the provisions of Maryland Code Ann., Fam. Law § 5-701(b)(1),' + 
      '(r), (aa) and 07.02.07.11B. It is the professional assessment of this worker that some credible evidence supports each of the following elements bus is ' + 
      'insufficient to conclude that mental injury abuse occurred: (Specify which element or elements caused the finding to be "unsubstantiated" and not "indicated" or "ruled out".)<br><br>' + 
      '1) An injury characterized by an observable, identifiable, and substantial impairment of a mental or psychological ability to function (explain the impairment): <b>${findingcomments}</b><br>' + 
      '2) An intentional act or series of intentional acts (regardless of whether there was an intent to harm the child) caused the injury (provide details of a current or prior act that' + 
      'caused the impairment): <b>${intentionalinjurydesc}</b><br>' + 
      '3) The act was caused by a parent, caregiver, authority figure, or household or family member (Insert name and whether the person is a parent,' + 
      'OR caregiver, OR authority figure, OR household OR family member): <b>${comar?.caretakername}</b><br>' + 
      '4) The victim was a child under the age of 18 (child’s DOB): <b>${comar?.victimdob}</b><br>'},
    'MENTAL-INJURY-NEGLECT-ID': {
      value: 'Mental Injury Neglect of <b>${comar?.victimname}</b> is <b>"INDICATED"</b> in accordance with the provisions of Maryland Code Ann.,' + 
      'Fam. Law § 5-701(m), (r), (s)(2) and COMAR 07.02.07.11A(2).It is the professional assessment of this worker that mental injury ' + 
      'neglect occurred because the evidence supports all of the following elements:<br><br>' + 
      '1) An injury characterized by an observable, identifiable, and substantial impairment of a mental or psychological ability to function (explain the impairment): <b>${findingcomments}</b><br>' + 
      '2) An omission or other failure to provide proper care or attention causing the substantial impairment (provide details of the current or' + 
      'prior omission or other failure): <b>${intentionalinjurydesc}</b><br>' + 
      '3) The substantial impairment was caused by a parent, caregiver, or household or family member (Insert name and whether the person is a parent, OR caregiver,' + 
      'OR household, OR family member): <b>${comar?.caretakername}</b><br>' + 
      '4) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>'},
    'MENTAL-INJURY-NEGLECT-RO': {
      value: 'Mental Injury Neglect of <b>${comar?.victimname}</b> is <b>"RULED OUT"</b> in accordance with the provisions of Maryland Code Ann.,' + 
      'Fam. Law § 5-701(r), (s)(2), (w) and COMAR COMAR 07.02.07.11C. It is the professional assessment of this worker that mental injury' + 
      'neglect did not occur because the evidence does not support one or more of the following elements: (Indicate which element or elements' + 
      'were not met in a bulleted format or short narrative.)<br><br>' + 
      '1) An injury characterized by an observable, identifiable, and substantial impairment of a mental or psychological ability to function (explain the impairment): <b>${findingcomments}</b><br>' + 
      '2) An omission or other failure to provide proper care or attention causing the substantial impairment (provide details of the current or' + 
      'prior omission or other failure): <b>${intentionalinjurydesc}</b><br>' + 
      '3) The substantial impairment was caused by a parent, caregiver, or household or family member (Insert name and whether the person is a parent, OR caregiver,' + 
      'OR household, OR family member): <b>${comar?.caretakername}</b><br>' + 
      '4) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>'},
    'MENTAL-INJURY-NEGLECT-UD': {
      value: 'Mental Injury Neglect of <b>${comar?.victimname}</b> is <b>"UNSUBSTANTIATED"</b> in accordance with the provisions of Maryland Code Ann.,' + 
      'Fam. Law § 5-701(r), (s)(2), (aa) and COMAR 07.02.07.11B. It is the professional assessment of this worker that there is some but ' + 
      'insufficient credible evidence to support a finding of either "indicated" or "ruled out" mental injury abuse because the following elements' + 
      'were either present or were supported by some, but insufficient, evidence: (Specify which elements caused the finding to be "unsubstantiated" and not "indicated" or "ruled out".)<br><br>' + 
      '1) An injury characterized by an observable, identifiable, and substantial impairment of a mental or psychological ability to function (explain the impairment): <b>${findingcomments}</b><br>' + 
      '2) An omission or other failure to provide proper care or attention causing the substantial impairment (provide details of the current or' + 
      'prior omission or other failure): <b>${intentionalinjurydesc}</b><br>' + 
      '3) The substantial impairment was caused by a parent, caregiver, or household or family member (Insert name and whether the person is a parent, OR caregiver,' + 
      'OR household, OR family member): <b>${comar?.caretakername}</b><br>' + 
      '4) The victim was a child (child’s DOB): <b>${comar?.victimdob}</b><br>'}

  };
}
