import { Component, OnInit, ViewChild} from '@angular/core';
import { DataStoreService, CommonHttpService } from '../../../../../@core/services';
import { CasePlanService } from '../case-plan.service';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import moment from 'moment';
import { PopoverDirective } from 'ngx-bootstrap/popover';
@Component({
    selector: 'case-plan-one',
    templateUrl: './case-plan-one.component.html',
    styleUrls: ['./case-plan-one.component.scss'],
    standalone: false
})
export class CasePlanOneComponent implements OnInit {
  store: any;
  cp1Data: any;
  selectedChild: any;
  childList: any[] = [];
  parent1: any;
  parent2: any;
  raceDropDown: any[] = [];
  riskAssessment: any;
  safeCAssessment: any;
  searchResult: any;
  pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
  intakeserviceid: any;
  mfiradate: any;
  safecdate: any;
  removaladdress: any;
  approvedSafeCDate : any;
  approvedSafecOhpDate:any;
  isAuthorized :any; //for fortify issues 
  //ssn masking
  showSsnMask = true;
  dtformat = 'MM/DD/YYYY';
  @ViewChild('childname') myPopover!: PopoverDirective;

  constructor(
    private _dataStoreService: DataStoreService,
    private _casePlanService: CasePlanService,
    private _commonHttpService: CommonHttpService
  ) {
    this.store = this._dataStoreService.getCurrentStore();
    this.cp1Data = this.store['SELECTED_CHILD_DATA'];
    this._casePlanService.loadRaceDropDown().subscribe(data => {
      this.raceDropDown = data;
      this.viewChildInfo(this.cp1Data);
    });
   }

  ngOnInit() {
    this.isAuthorized =this._dataStoreService.isAuthorized();
    this._casePlanService.getParentList();
    if (this.cp1Data) {
      this.viewChildInfo(this.cp1Data);
    }
  }
  ngAfterViewInit() {
    this.scroll('versions-table');
  }

  scroll(id: any) {
    const el: any = document.getElementById(id);
    el.scrollIntoView({behavior: 'smooth', block: 'start', inline: 'nearest'});
  }

  viewChildInfo(child: any) {
    this.selectedChild = child;
    this.selectedChild.riskAssessment = (this.riskAssessment && this.riskAssessment.length) ? this.riskAssessment[0] : null;
    this.selectedChild.safeCAssessment = (this.safeCAssessment && this.safeCAssessment.length) ? this.safeCAssessment[0] : null;
    this.viewSocialHistoryInfo(child);
    const childremovalinfo = this._casePlanService.childRemovalInfo;
    const childremoval = childremovalinfo.find(item => item.personid === child.personid);
    this.removaladdress = childremoval ? childremoval.removaladd1 : null;
    this._casePlanService.getassessment().subscribe(response => {
      const list = response.data;
      const mfiraass = list.find(item => item.description.toUpperCase() === 'MARYLAND FAMILY RISK REASSESSMENT');
      const safecass = list.find(item => item.description.toUpperCase() === 'SAFE-C');
      this.setmfiradate(mfiraass);
      this.setapprovedSafeCDate(safecass);
      this.setapprovedSafecOhpDate(mfiraass);

     this.safecdate = (moment(this.approvedSafecOhpDate).isAfter(this.approvedSafeCDate))?  this.approvedSafecOhpDate : this.approvedSafeCDate;
     this.preparePDFrequest();
    });
    if (this.selectedChild) {
      this.setParentInformation(this.selectedChild.personid);
    }
  }
  setmfiradate(mfiraass: any) {
    let mfiraApprovedList = Array.isArray(mfiraass.intakassessment) && mfiraass.intakassessment.length ? mfiraass.intakassessment : [];
    mfiraApprovedList = mfiraApprovedList.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey === 'Accepted');
    this.mfiradate = (Array.isArray(mfiraApprovedList) && mfiraApprovedList.length) ? mfiraApprovedList[0].updateddate : null;
  }

  setapprovedSafeCDate(safecass: any) {
    let safecApprovedList = Array.isArray(safecass.intakassessment) && safecass.intakassessment.length? safecass.intakassessment: [];
    safecApprovedList =     safecApprovedList.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey === 'Accepted');
    this.approvedSafeCDate = (Array.isArray(safecApprovedList) && safecApprovedList.length) ? safecApprovedList[0].updateddate : null;
  }

  setapprovedSafecOhpDate(safecohp: any) {
    let safecohpApprovedList = Array.isArray(safecohp.intakassessment) && safecohp.intakassessment.length ? safecohp.intakassessment : [];
    safecohpApprovedList = safecohpApprovedList.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey === 'Accepted');
    this.approvedSafecOhpDate = (Array.isArray(safecohpApprovedList) && safecohpApprovedList.length) ? safecohpApprovedList[0].updateddate : null;
  }
  preparePDFrequest(){
    var payload = {
      count: -1,
      where: {
          documenttemplatekey: ['CasePlanSocialHistory'],
          intakeserviceid: this.intakeserviceid,
          clientId: this.getChildClientId(),
          name: this.getChildName(),
          cjamspid: this.getChildClientId(),
          removaldate: this.getChildRemovalDate(),
          racetypekey: this.getChildRace(),
          gender: this.getChildGender(),
          dob: this.getChildDOB(),
          ssn: (this.selectedChild) ? this.selectedChild.ssn : null,
          religion: (this.selectedChild) ? this.selectedChild.religion : null,
          parent1name: (this.selectedChild) ? this.selectedChild.parent1name : null,
          parent2name: (this.selectedChild) ? this.selectedChild.parent2name : null,
          removaladd1: (this.removaladdress) ? this.removaladdress : null,
          riskassessupdatedon: (this.mfiradate) ? moment(this.mfiradate).format(this.dtformat) : null,
          safeassessupdatedon: (this.safecdate) ? moment(this.safecdate).format(this.dtformat) : null,
          removalinfo: this.getChildRemovalInfo(),
          placement: (this.selectedChild.placement) ? this.selectedChild.placement : null,
          familyhistory: (this.selectedChild) ? this.selectedChild.familyhistory : null,
          childdesc: (this.selectedChild) ? this.selectedChild.childdesc : null,
      },
      method: 'post'
    };
    this._dataStoreService.setData('SELECTED_CASEPLAN1_PAYLOAD', payload);

  }

  getChildRace(){
    return (this.selectedChild && this.selectedChild.race) ? this.getRaceDesc(this.selectedChild.race) : null;
  }
  getChildClientId(){
    return (this.selectedChild) ? this.selectedChild.cjamspid : null;
  }
  getChildName(){
    return (this.selectedChild) ? this.selectedChild.firstname + ' ' + this.selectedChild.lastname : null;
  }
  getChildRemovalDate(){
    return (this.selectedChild) ? moment(this.selectedChild.removaldate).format(this.dtformat) : null;
  }
  getChildGender(){
    return (this.selectedChild) ? this.selectedChild.gender : null;
  }
  getChildDOB(){
    return (this.selectedChild) ?  moment(this.selectedChild.dob).format(this.dtformat) : null;
  }
  getChildRemovalInfo(){
    return (this.selectedChild && this.selectedChild?.removalInfo?.reasonableefforts?.length) ? this.concatResonableEffortsDescription(this.selectedChild.removalInfo.reasonableefforts) : null;   
  }

  viewSocialHistoryInfo(child: any) {
    if ( child &&  child.intakeservicerequestactorid) {
      const selectedChild = this._casePlanService.getSocialHistory(child.intakeservicerequestactorid);
      selectedChild.subscribe(data => {
        if (data && data.length) {
         this.selectedChild.placement = data[0].placement;
         this.selectedChild.familyhistory = data[0].familyhistory;
         this.selectedChild.childdesc = data[0].childdesc;
         this.selectedChild.insertedon = data[0].insertedon;
         this.selectedChild.createdby = data[0].createdby;
         this.selectedChild.updatedon = data[0].updatedon;
         this.selectedChild.updatedby = data[0].updatedby;
        }
      });
    }  else  {
      this.selectedChild = [];
    }
  }

  getRaceDesc(race: any) {
    race = Array.isArray(race) ? race : [];
    if (this.raceDropDown) {
      const raceList = '';
      race = race.map((item: { racetypekey: any; }) => {
        const a = this.raceDropDown.find(ele => ele.racetypekey === item.racetypekey);
        return a ? a.typedescription : '';
      });
      return race.toString();
    } else {
      return null;
    }
  }

  printReport() {
    this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this._commonHttpService.getSingle({
        count: -1,
        where: {
            documenttemplatekey: ['CasePlanSocialHistory'],
            intakeserviceid: this.intakeserviceid,
            clientId: this.getChildClientId(),
            name: this.getChildName(),
            cjamspid: this.getChildClientId(),
            removaldate: this.getChildRemovalDate(),
            racetypekey: this.getChildRace(),
            gender: this.getChildGender(),
            dob: this.getChildDOB(),
            ssn: (this.selectedChild) ? this.selectedChild.ssn : null,
            religion: (this.selectedChild) ? this.selectedChild.religion : null,
            parent1name: (this.selectedChild) ? this.selectedChild.parent1name : null,
            parent2name: (this.selectedChild) ? this.selectedChild.parent2name : null,
            removaladd1: (this.removaladdress) ? this.removaladdress : null,
            riskassessupdatedon: (this.mfiradate) ? moment(this.mfiradate).format(this.dtformat) : null,
            safeassessupdatedon: (this.safecdate) ? moment(this.safecdate).format(this.dtformat) : null,
            removalinfo: this.getChildRemovalInfo(),
            placement: (this.selectedChild.placement) ? this.selectedChild.placement : null,
            familyhistory: (this.selectedChild) ? this.selectedChild.familyhistory : null,
            childdesc: (this.selectedChild) ? this.selectedChild.childdesc : null,
        },
        method: 'post'
    }, 'evaluationdocument/generateintakedocument').subscribe((data) => {
        if (data && data.data[0]) {
            window.open(data.data[0].documentpath, '_blank');
        }
    });
  }

  setParentInformation(personid: any) {
    this._casePlanService.getRelationshipOfPerson(personid).subscribe(response => {
      if (Array.isArray(response) && response.length) {
        const bioFather = response.find(item => item.relationshiptypekey === 'BGFTHR');
        const bioMother = response.find(item => item.relationshiptypekey === 'BGMTHR');
        if (bioFather && Array.isArray(this._casePlanService.personList)) {
            this.parent1 = this._casePlanService.personList.find(item => item.personid === bioFather.person2id);
        } else {
          this.parent1 = null;
        }
        if (bioMother && Array.isArray(this._casePlanService.personList)) {
          this.parent2 = this._casePlanService.personList.find(item => item.personid === bioMother.person2id);
      } else {
        this.parent2 = null;
      }
      } else {
        this.parent1 = null;
        this.parent2 = null;
      }
      this.selectedChild.parent1name = ( this.parent1) ? ( this.parent1.firstname + ' ' +  this.parent1.lastname ) : null;
      this.selectedChild.parent2name = ( this.parent2) ? ( this.parent2.firstname + ' ' +  this.parent2.lastname ) : null;

    });
  }
  closePopover(element: any) {
    this.myPopover.hide();
  }
  
  showComma(array: any, index: any){       
    if((array.length - 1) == index){
        return false;
    }else {
        return true;
    }
 }

 concatResonableEffortsDescription(array: any){
  return array.map((item: { description: any; })=>item.description).join(', ');
}

}
  