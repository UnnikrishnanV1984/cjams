import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ChildRemovalService } from '../../../child-removal/child-removal.service';
import { AlertService, DataStoreService, CommonHttpService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import moment from 'moment';
import { PaginationRequest, PaginationInfo } from '../../../../../../@core/entities/common.entities';
import { DocumentUploadListSharedComponent } from '../../../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';

@Component({
    selector: 'ytp-meeting',
    templateUrl: './ytp-meeting.component.html',
    styleUrls: ['./ytp-meeting.component.scss'],
    standalone: false
})
export class YtpMeetingComponent implements OnInit {
  meetingFormGroup!: FormGroup;
  persons: any[] = [];
  ytpData: any;
  ytpSummary: any = {};
  supportiveRelations: any[] = [];
  signatures: any[] = [];
  store: any;
  followUpOneYearOrNot: boolean = false;
  communityShortTermGoals: any[] = [];
  communityActions: any[] = [];
  uploadedFiles: any[] = [];
  personId: any = '';
  totalRecords = 0;
  paginationInfoperson: PaginationInfo = new PaginationInfo();
  youthSignature: any;
  caseworkerSignature: any;
  isDisabled: boolean = false;
  uploadDisable:string = '';
  twelvehour: boolean = true;
  timeInterval: number = 5;
  @ViewChild(DocumentUploadListSharedComponent) documentuploaded!: DocumentUploadListSharedComponent;

  constructor(private formBuilder: FormBuilder,
    private childRemovalService: ChildRemovalService,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService) {   this.store = this._dataStoreService.getCurrentStore(); }

  ngOnInit() {
    this.meetingFormGroup = this.formBuilder.group({
      nextMeeting: [null],
      nextMeetingDt: [null],
      nextMeetingTime: [null],
      nextMeetingLocation: [null],
      ytpMeetingFacilitated: [null],
      ytpMeetingNotes: [null],
      youthsign: [''],
      youthsignDate: [null, Validators.required],
      isYouthSign: [false],
      youthSignedDocument: [],
      caseworkerSign: [''],
      caseworkerSignDate: [null, Validators.required]
    });
    this.ytpData = this._dataStoreService.getData('YTPDATA');
    this.personId = this.ytpData?.clientid;
    this.isDisabled = this.ytpData?.approvalstatuskey == 'Pending' || this.ytpData?.approvalstatuskey == 'Approved';  
    this.uploadDisable = this.isDisabled ? 'referServiceNew' : '';
    this.getpersonattachment(this.personId);
    this.ytpSummary = this.ytpData?.new_meeting_json;
    if(this.ytpData?.new_meeting_json) {
       this.getSummaryDetails();
    }
    this.childRemovalService.getPersonsList().subscribe(persons => {
      if (persons && persons.data) {
        this.persons = persons.data;
      }
    }
    );
  }
  getFullName(person: any) {
      const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
      let name = '';
      nameKeys.forEach(key => {
      if(person && person.hasOwnProperty(key)){
        if ((person[key] !== null) && (person[key] !== 'null') && (person[key] !== '') ) {
          name = name + person[key] + ' ';
      }}
      });
      return name;
  }
  formatDateToString(date: Date): any {
    const convertedDate = moment(date);
    if (convertedDate.isValid()) {
      return convertedDate.format('MM/DD/YYYY');
    } else {
      return null;
    }
  }

  private getpersonattachment(_personid: any[]) {
    this.uploadedFiles = [];
    const inputreq = {
      personid: this.personId,
      intakenumber: null,
      servicerequestid: null,
      servicecaseid: null,
      adoptioncaseid: null,
      objecttypekey: 'Person',
      category: ['Ready by 21'],
      subcategory: ['My Youth Transition Plan and Meeting Summary'],
      worker: null,
      title: null,
      sortcolumn: 'updatedon',
      sortby: 'desc',
      actualdocumentdate: null,
      activeflag: 1
    };

    this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          where: inputreq,
          method: 'get',
          page: this.paginationInfoperson.pageNumber,
          limit: 1000
          // nolimit : true
        }),
        'Documentproperties/getcaseworkerattachments' + '?filter').subscribe((response: any) => {
          if (response && Array.isArray(response) && response.length) {
            let result = response[0].searchcaseworkerattachments;

            if (result) {
              const documnt = Array.isArray(this.ytpData?.new_meeting_json?.youthSignedDocument) ? this.ytpData?.new_meeting_json?.youthSignedDocument : []; 
              result = this.searchcaseworkerattachmentsFilterFn(result, documnt);
              this.totalRecords = result.length;
              this.uploadedFiles = result;
              this.uploadedFiles.forEach((attach) => {
                attach.uplodeddate = moment(attach.insertedon).format('MM/DD/YYYY hh:mm A');
                attach.actualdocumentdate = (attach.actualdocumentdate) ? moment(attach.actualdocumentdate).format('MM/DD/YYYY') : null;
              });
            } else {
              this.uploadedFiles = [];
            }
          } else {
            this.uploadedFiles = [];
          }
        });
  }

  private searchcaseworkerattachmentsFilterFn(result: any, documnt: any) {
    result = result.map((item: any) => {
      if (documnt.includes(item.documentpropertiesid)) {
        item.numberofbytes = this.humanizeBytes(item.numberofbytes);
        item.documentattachment = (item.documentattachment && Array.isArray(item.documentattachment) && item.documentattachment.length > 0)
          ? item.documentattachment[0] : item.documentattachment;
        return item;
      }
    });
    result = result.filter((x: any) => !!x);
    return result;
  }

  humanizeBytes(bytes: number): string {
    if (bytes === 0) {
      return '0 Byte';
    }
    const k = 1024;
    const sizes: string[] = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
    const i: number = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  }

  pdpageChanged(pageNumber: any) {
    this.paginationInfoperson.pageNumber = pageNumber;
    this.getpersonattachment(this.personId);
  }

  FileUploaded(event: any) {
    if (event && event.length>0 && this.personId) {
      var propId = event.map((x: { documentpropertiesid: any; })=>x.documentpropertiesid);
      var doc = this.meetingFormGroup.get('youthSignedDocument')?.value || [];
      this.meetingFormGroup.patchValue({'youthSignedDocument': doc.concat(propId)})
    }
  }

  getErrorsMessage(ControlName: any, displayName: any) {
    if (this.meetingFormGroup?.controls[ControlName].status == 'INVALID') {
      return 'Please enter valid ' + displayName;
    }
  }

  saveSummary() {
    const summary = this.meetingFormGroup.getRawValue();
    summary.youthSignedDocument = this.uploadedFiles.map(x => x.documentpropertiesid).filter(x=> !!x)
    if((summary.isYouthSign && (!summary.youthSignedDocument || (summary.youthSignedDocument && summary.youthSignedDocument.length == 0))) || (!summary.isYouthSign && summary.youthsign && summary.youthsign.length ==0)) {
      this._alertservice.error('Please select Youth signed document!');
      return;
    }
    if(this.meetingFormGroup.invalid) {return}
    summary.goals = this.supportiveRelations;
    summary.actions = this.signatures;
    this._ytpService.patchData('new_meeting_json', summary)
    .subscribe(
      response => {
        this._alertservice.success('YTP Meeting details entered successfully!');
        this.store['YTPDATA'].new_meeting_json = summary;
      },
      error => {
        this._alertservice.error('Error in entering Summary details!');
      }
    );
  }

  getSummaryDetails() {
    this.ytpData = this._dataStoreService.getData('YTPDATA');
    this.meetingFormGroup.patchValue(this.ytpData?.new_meeting_json);
    if(this.ytpData?.new_meeting_json.youthsign){
      this.youthSignature = this.meetingFormGroup.get('youthsign')?.value; 
    }
    if (this.ytpData?.new_meeting_json.caseworkerSign) {
      this.caseworkerSignature = this.meetingFormGroup.get('caseworkerSign')?.value;
    }
    if (this.ytpData?.new_meeting_json.goals) {
      this.supportiveRelations = this.ytpData?.new_meeting_json.goals;
    }
    if (this.ytpData?.new_meeting_json.actions) {
      this.signatures = this.ytpData?.new_meeting_json.actions;
      if (Array.isArray(this.signatures) && this.signatures.length) {
        this.signatures.forEach(item => {
          item.action_plan = item.action_plan ? new Date(item.action_plan) : '';
        });
      }
    }

  }
  
  resetSignatureCapture() {
    this.meetingFormGroup.get('youthsign')?.reset();   
}

  uploadclosed(event: any){
    if(event){
      this.documentuploaded.closeupload();
    }
  }

  clearSummary() {
    this.youthSignature = null;
    this.meetingFormGroup.reset();
  }

  addSupport() {
    this.supportiveRelations.push({ parkingItem: '', plan: ''});
  }

  deleteSupport(index: any){
    this.supportiveRelations.splice(index, 1);
  }


}
