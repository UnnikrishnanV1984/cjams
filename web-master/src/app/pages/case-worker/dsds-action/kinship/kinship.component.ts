
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable ,  forkJoin } from 'rxjs';

import { environment } from '../../../../../environments/environment';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { DropdownModel, PaginationRequest } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService, CommonHttpService, DataStoreService, GenericService } from '../../../../@core/services';
import { AuthService } from '../../../../@core/services/auth.service';
import { HttpService } from '../../../../@core/services/http.service';
import { AppConfig } from '../../../../app.config';
import { AssessmentBlob, Assessments, InvolvedPerson } from '../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { Attachment } from '../attachment/_entities/attachment.data.models';
import { Checklist, Kinship, KinshipList } from './_entities/kinship.data.models';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

declare let Formio: any;
@Component({
    selector: 'kinshipCare',
    templateUrl: './kinship.component.html',
    styleUrls: ['./kinship.component.scss'],
    standalone: false
})
export class KinshipComponent implements OnInit {
  id: string;
  daNumber: string;
  daStatus!: string;
  involevedPerson$!: Observable<InvolvedPerson[]>;
  attachment$!: Observable<DropdownModel[]>;
  checklist$!: Observable<DropdownModel[]>;
  checklistItems: DropdownModel[] = [];
  applicant!: Observable<InvolvedPerson[]>;
  coapplicant!: Observable<InvolvedPerson[]>;
  kinshipFormGroup!: FormGroup;
  listAssessment$!: Observable<Assessments[]>;
  isInitialized = false;
  applicantmodelCtrl!: FormControl;
  coapplicantmodelCtrl!: FormControl;
  attachmentmodelCtrl!: FormControl;
  filteredAttachmentGrid: Attachment[] = [];
  checklist: Checklist[] = [];
  downldSrcURL: any;
  baseUrl: string;
  kinship!: Kinship;
  isAssessmentCompleted = true;
  isSupervisor = false;
  assessmentDetail!: AssessmentBlob;
  token!: AppUser;
  kinshipList!: KinshipList;
  isdisplayComments = false;
  kinshippopupid = '#kinship-assessment-popup';
  constructor(
    private _formBuilder: FormBuilder,
    private _service: GenericService<Kinship>,
    private _commonService: CommonHttpService,
    private _http: HttpService,
    private _dataStoreService: DataStoreService,
    private _alertService: AlertService,
    private _authService: AuthService
  ) {
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.baseUrl = AppConfig.baseUrl;
  }

  ngOnInit() {
    this.token = this._authService.getCurrentUser();
    this.isSupervisor = this.token.role.name === 'apcs' ? true : false;
    this.initializeFormGroup();
    this.getApplicant();
    this.loadChecklist();
    this.getKinship();
    this.getAssessmentDetail();
    this.isInitialized = true;

  }

  initializeFormGroup() {
    this.kinshipFormGroup = this._formBuilder.group({
      primaryisractorid: ['', Validators.required],
      secondaryisractorid: [''],
      acceptcharacteristics: [''],
      cpsclearance: [''],
      cjsinfo: [''],
      dhhreport: [''],
      isreceiveddisciplinepolicy: [''],
      isapproveddisciplinepolicy: [''],
      checklist: this._formBuilder.array([]),
      documents: [],
      comments: [''],
      placement: ['']
    });
  }

  private buildChecklistFormGroup(x: any) {
    const controls = this.checklistItems.map(c => {
      if (x.amtaskid && x.filter((p: { amtaskid: any; }) => p.amtaskid === c.value).length) {
        return new FormControl(true);
      } else {
        return new FormControl(false);
      }
    });
    return this._formBuilder.group({
      checklist: new FormArray(controls)
    });
  }

  private humanizeBytes(bytes: number): string {
    if (bytes === 0) {
      return '0 Byte';
    }
    if (!bytes) {
      return '';
   }
    const k = 1024;
    const sizes: string[] = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
    const i: number = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  }

  loadChecklist() {
    this._commonService
      .getArrayList(
        new PaginationRequest({
          nolimit: true,
          method: 'get',
          where: {
            iskinship: 1
          }
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.kinship.checklistUrl + '?filter'
      )
      .subscribe(result => {
        this.checklistItems = result.map(
          res =>
            new DropdownModel({
              text: res.name,
              value: res.amtaskid
            })
        );
        const control = <FormArray>this.kinshipFormGroup.controls['checklist'];
        this.checklistItems.forEach(() => {
          control.push(new FormControl(false));
        });
      });
  }

  getAssessmentDetail() {
    this._commonService
      .getArrayList(
        {
          method: 'get',
          where: {
            objectid: this.id,
            assessmenttemplatename: 'homeHealthReport'
          },
          page: 1,
          limit: 10
        },
        'admin/assessment/getassessment?filter'
      )
      .subscribe(item => {
        if (item && item.length) {
          this.assessmentDetail = <AssessmentBlob>item[0];
        }
      });
  }

  openAssessment() {
    const _self = this;
    Formio.setToken(this.token.id);
    const formioUrl = this.getFormUrl();
    Formio.createForm(document.getElementById('assessment-view'), formioUrl, {
      readOnly: false
    }).then((form: any) => {
      form.components = form.components.map((item: { key: string; type: string; action: string; }) => {
        if (item.key === 'Complete' && item.type === 'button') {
          item.action = 'submit';
        }
        return item;
      });

      form.on('render', () => {
        (<any>$(this.kinshippopupid)).modal('show');
        setTimeout(() => {
          $(this.kinshippopupid).scrollTop(0);
        }, 200);
      });
      form.on('submit', (submission: any) => {
        let status = '';
        let comments = '';
        if (_self.token.role.name === 'apcs') {
          status = submission.data.assessmentstatus;
          comments = submission.data.supervisorcomments;
        } else if (_self.token.role.name === 'field') {
          if (submission.data.submit) {
            status = 'InProcess';
          } else {
            status = submission.data.assessmentreviewed;
          }
          comments = submission.data.caseworkercomments;
        }
        _self.assessmentDetail.submissionid = submission._id;
        _self.assessmentDetail.submissiondata = submission.data;
        _self._http
          .post('admin/assessment/Add', {
            externaltemplateid: _self.assessmentDetail.externaltemplateid,
            objectid: _self.id,
            submissionid: submission._id,
            submissiondata: this.nullCheck(submission.data),
            form: this.nullCheck(submission.form),
            score: this.getScore(submission.data.score),
            assessmentstatustypekey1: status,
            comments: comments
          })
          .subscribe((response: any) => {
            _self._alertService.success('Home Health Report form DHR/SSA 1083 form saved successfully.');
            (<any>$(this.kinshippopupid)).modal('hide');
          });
      });
    });
  }

  getFormUrl() {
    let formioUrl = '';
    if (this.assessmentDetail.submissionid) {
      formioUrl = environment.apiHost + `/admin/assessment/getassessmentform/${this.assessmentDetail.externaltemplateid}/submission/${this.assessmentDetail.submissionid}`;
    } else {
      formioUrl = environment.apiHost + `/admin/assessment/getassessmentform/${this.assessmentDetail.externaltemplateid}`;
    }
    return formioUrl;
  }

  nullCheck(inputData: any){
    return inputData ? inputData : null;
  }

  getScore(score: any){
    return score ? score : 0;
  }

  getApplicant() {
    const source = forkJoin([
      this._commonService.getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: { intakeservreqid: this.id }
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
      ),
      this._commonService.getArrayList(
        new PaginationRequest({
          nolimit: true,
          method: 'get'
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentGridUrl + '/' + this.id + '?data'
      )
    ]).pipe(
      map((result: any) => {
        return {
          involvedPerson: result[0]['data'],
          attachment: result[1].map((res: { title: any; documentpropertiesid: any; }) =>
              new DropdownModel({
                text: res.title,
                value: res.documentpropertiesid
              })
          )
        };
      }),
      share(),);
    this.involevedPerson$ = source.pipe(pluck('involvedPerson'));
    this.attachment$ = source.pipe(pluck('attachment'));

    this.applicant = this.involevedPerson$.pipe(map(element => {
      return element.filter(this.restrictApplicant);
    }));
    this.coapplicant = this.applicant;
  }

  restrictApplicant(element: any) {
    return element.rolename !== 'RC' && element.rolename !== 'VICTIM' && element.rolename !== 'AM' && element.rolename !== 'CHILD';
  }

  restrictCoApplicant(data: any) {
    this.coapplicant = this.applicant.pipe(map(elements => {
      return elements.filter(element => element.personid !== data.value);
    }));
  }

  onChangeAttachment(event: any) {
    if (event) {
     return event.map((res: any) => {
        return { documentpropertiesid: res };
      });
    }
  }
  saveKinship(mode: any) {
    this.kinship = Object.assign({}, this.kinshipFormGroup.value);
    this.kinship.checklist.forEach((item, index) => {
      if (item) {
        this.checklist.push({ amtaskid: this.checklistItems[index].value });
      }
    });
    this.kinship.checklist = this.checklist;

    if (this.kinship.primaryisractorid) {
      this.kinship.intakeserviceid = this.id;
      this.kinship.secondaryisractorid = this.nullCheck(this.kinship.secondaryisractorid);
      this.kinship.documents = this.onChangeAttachment(this.kinshipFormGroup.value.documents);
        this._service.create(this.kinship, CaseWorkerUrlConfig.EndPoint.DSDSAction.kinship.AddKinshipUrl).subscribe((response: any) => {
            if (response) {
              this.saveRoutingInfo(mode);
            }
          },
          (error: any) => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          }
        );
    } else {
      this._alertService.error('Please select an applicant.');
    }
  }

  saveRoutingInfo(mode: any) {
    let status = null;
    let msg = null;
    if (mode === 'Accept') {
      status = 16;
      msg = 'Kinshipcare Accepted';
    } else if (mode === 'Reject') {
      status = 17;
      msg = 'Kinshipcare Rejected';
    } else {
      status = 15;
      msg = 'Kinshipcare Review';
    }
    this._commonService.create({
      objectid: this.id,
      eventcode: 'KINR',
      status: status,
      comments: this.kinshipFormGroup.value.comments ? this.kinshipFormGroup.value.comments : null,
      notifymsg: msg,
      routeddescription: msg
    }, 'routing/routingupdate').subscribe(result => {
      if (result) {
        if (mode === 'Accept') {
          this._alertService.success('Kinship Care accepted.');
        } else if (mode === 'Reject') {
          this._alertService.success('Kinship Care rejected.');
        } else {
          this._alertService.success('Kinship Care submitted for approval.');
        }
      }
    });
  }
  private getKinship() {
    this._commonService
      .getArrayList(
        {
          where: { intakeserviceid: this.id },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.kinship.KinshipListUrl + '?filter'
      )
      .subscribe(result => {
        if (result) {
          this.kinshipList = Object.assign(result);
          if (this.kinshipList && this.kinshipList.kinshipcarelist[0]) {
            this.kinshipFormGroup.patchValue(this.kinshipList.kinshipcarelist[0]);
          }
          if (this.kinshipList && this.kinshipList.routinginfo[0]) {
            this.kinshipFormGroup.patchValue({ comments: this.kinshipList.routinginfo[0].remarks });
          }
        }

        if (this.isSupervisor) {
          this.isdisplayComments = true;
        } else {
          if (this.kinshipFormGroup.value.comments) {
            this.isdisplayComments = true;
            this.kinshipFormGroup.get('comments')?.disable();
          } else {
            this.isdisplayComments = false;
          }
        }
      });
  }
}
