import { Component, EventEmitter, Injector, Input, OnInit, Output } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import moment from 'moment';
import { AlertService, CommonHttpService, DataStoreService, AuthService } from '../../../../@core/services';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { Titile4eUrlConfig } from '../../_entities/title4e-dashboard-url-config';
import { DatePipe } from '@angular/common';
import {PaginationRequest} from '../../../../@core/entities/common.entities';
import { map } from 'rxjs/operators';
declare var Formio: any;

const GAP_ELIGIBLE_REIMBURSABLE = 'Eligible Reimbursable';
const GAP_INELIGIBLE = 'Ineligible';

@Component({
    selector: 'title-ive-gapextension',
    templateUrl: './title-ive-gapextension.component.html',
    styleUrls: ['./title-ive-gapextension.component.scss'],
    providers: [DatePipe],
    standalone: false
})
export class TitleIveGapextensionComponent implements OnInit {
  @Output() submitForReview: EventEmitter<any> = new EventEmitter();
  @Input() gapData: any;
  gapExtensionData: any;
  client_id: any;
  removal_id!: string;
  childPersonId: any;
  cjamspid: any;
  countyname: any;
  userInfo!: AppUser;
  educationlist: any;
  employementlist: any;
  employementbarrierlist: any;
  narrativeuniqueInfo: any;
  disabilityList: any;
  disabilityfilterlist:any[] = [];
  educationfilterlist:any[] = [];
  gapExtensionForm!: FormGroup;
  @Input() pagesnapshot: any;
  isreadonly: any;
  dtformat = 'MM/DD/YYYY';
  gapInitialEligibilityStatus: any;
  private readonly fb: FormBuilder;
  private readonly _commonHttpService: CommonHttpService;
  private readonly _alertService: AlertService;
  private readonly _dataStoreService: DataStoreService;
  private readonly activatedRoute: ActivatedRoute;
  public _authService: AuthService;

  constructor(private readonly injector: Injector, public dialog: MatDialog, private readonly datePipe: DatePipe) {
    this.fb = this.injector.get<FormBuilder>(FormBuilder);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this.activatedRoute = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._authService = this.injector.get<AuthService>(AuthService);
  }

  ngOnInit() {
    this.createFormGroup();
    this.client_id = this.activatedRoute.snapshot.paramMap.get('clientid');
    this.removal_id = this.activatedRoute.snapshot.paramMap.get('removalId') ?? "";
    this.childPersonId = this.gapData?.demographicsInfo[0]?.personid;
    this._dataStoreService.currentStore.subscribe((item) => {
      if (item['isivereadonly']) {
        this.isreadonly = item['isivereadonly'];
      }
    });
    if (this.pagesnapshot) {
      this.gapExtensionForm.patchValue(this.pagesnapshot);
      this.gapExtensionForm.disable();
    } else {
      this.searchGapClientId();
    }
      this.getEducation(this.childPersonId);
      this.getworkDetails(this.childPersonId);
      this.getEmploymentBarrierDetails(this.childPersonId);
      this.getDisabilityList(this.childPersonId);
      this._authService.readonlyPage('read_only_access','',
      [this.gapExtensionForm]);
  }



  createFormGroup(){
    this.gapExtensionForm = this.fb.group({
          childname: [''],
          client_id: [''],
          childjurisdiction: [''],
          dateofbirth: [''],
          gender: [''],
          childguardianname: [''],
          childguardianid: [''],
          guardiansubsidyid:  [''],
          dateofcourtorderguardianshipfinalization: [''],
          guardianshipapplicationdate: [''],
          childmeetcontinueeligibilitycriteria: [null]
    });
  }



  isTabSwitched(){
    $('.gap a').on('shown.bs.tab', (event) => {
      var x = $(event.target).text();
      if(x.includes("Redetermination")){
        this.searchGapClientId();
      }
    });
  }


  mapData(){
            if(this.gapExtensionData.demographicsInfo && this.gapExtensionData.demographicsInfo.length > 0){
              this.gapExtensionForm.patchValue(this.gapExtensionData.demographicsInfo[0]);
            }

            if(this.gapExtensionData.generalInfo && this.gapExtensionData.generalInfo.length > 0){
              this.gapExtensionForm.patchValue(this.gapExtensionData.generalInfo[0]);
            }

            if(this.gapExtensionData.gapExtensionInfo &&
                this.gapExtensionData.gapExtensionInfo.length > 0 &&
                this.gapExtensionData.gapExtensionInfo[0].childmeetcontinueeligibilitycriteria === 'YES'){
              this.gapExtensionForm.patchValue(this.gapExtensionData.gapExtensionInfo);
            }
  }

  submissionData(){
    // Only an 'Ineligible' initial GAP determination is carried over to the redetermination.
    // Every other case (eligible, incomplete, missing or lookup failure) sends 'Eligible Reimbursable'.
    this.getGapInitialEligibilityStatus().subscribe({
      next: (initialstatus: any) => {
        this.gapInitialEligibilityStatus = initialstatus;
        this.postRedetermination(this.gapInitialEligibilityStatus);
      },
      error: () => {
        this.gapInitialEligibilityStatus = GAP_ELIGIBLE_REIMBURSABLE;
        this.postRedetermination(GAP_ELIGIBLE_REIMBURSABLE);
      }
    });
  }

  private postRedetermination(initialstatus: any){
    interface LooseObject {
      [key: string]: any
    }

    let gender = 'Other';
    if(this.gapExtensionForm.value.gender === 'M'){
      gender = 'Male';
    }else if(this.gapExtensionForm.value.gender === 'F'){
      gender = 'Female';
    }


      if (Array.isArray(this.educationfilterlist) && this.educationfilterlist.length > 0) {
          const edumetadata = {'__metadata': {
                  '#type': 'EducationDetails'
              }};
          const edueventreason = {'YouthEventReason': 'ED'};
          this.educationfilterlist.forEach((obj) => {
              Object.assign(obj, edueventreason, edumetadata);
          });
      }else {
        this.educationfilterlist = [];
      }

      if (Array.isArray(this.employementlist) && this.employementlist.length > 0) {
          const empmetadata = {'__metadata': {
                  '#type': 'EmploymentDetails'
              }};
          const empeventreason = {'YouthEventReason': 'EM'};
          this.employementlist.forEach((obj) => {
              Object.assign(obj, empeventreason, empmetadata);
          });
      }else {
        this.employementlist = null;
      }

      if (Array.isArray(this.narrativeuniqueInfo) && this.narrativeuniqueInfo.length > 0 ) {
          const empbarriermetadata = {'__metadata': {
                  '#type': 'RemovesBarriersDetails'
              }};
          const empbarriereventreason =   {'YouthEventReason': 'RB'};
          this.narrativeuniqueInfo.forEach((obj) => {
              Object.assign(obj, empbarriereventreason, empbarriermetadata);
          });
      } else {
        this.narrativeuniqueInfo = null;
      }

      if (Array.isArray(this.disabilityfilterlist) && this.disabilityfilterlist.length > 0) {
          const disablitymetadata =  {'__metadata': {
                  '#type': 'ChildDisabilityDetails'
              }};
          const disablityeventreason =  {'YouthEventReason': 'CD'};
          this.disabilityfilterlist.forEach((obj) => {
              Object.assign(obj, disablityeventreason, disablitymetadata);
          });
      }else {
        this.disabilityfilterlist = [];
      }

      let submissiondata: LooseObject = {
      "cjamsPid": Number(this.gapExtensionForm.value.client_id),
      "guardiansubsidyid":Number(this.removal_id),
      "removalid": Number(this.gapData?.demographicsInfo[0]?.al_removal_id),
      "pagesnapshot": this.gapExtensionForm.getRawValue(),
      "reDetermination": {
        "payload": {
          "name": "EXT_GAP",
          "__metadataRoot": {},
          "Objects": [
            {
              "ChildMeetContinueEligibilityCriteria": this.gapExtensionForm.value.childmeetcontinueeligibilitycriteria,
              "person": {
                "educationDetails": this.educationfilterlist,
                "employmentDetails": this.employementlist,
                "childDisabilityDetails": this.disabilityfilterlist,
                "removesBarriersDetails": this.narrativeuniqueInfo,
                "DateOfBirth": this.dateConversion(this.gapExtensionForm.value.dateofbirth),
                "CountyOfJurisdiction_LDSS": this.gapExtensionForm.value.childjurisdiction,
                "Gender": gender,
                "Name": this.gapExtensionForm.value.childname,
                "__metadata": {
                  "#type": "Person",
                  "#id": "Person_id_1"
                },
              },
              "GuardianshipFinalizationDate_FinalizationDateOfCourtOrder": this.dateTimeConversion(this.gapExtensionForm.value.dateofcourtorderguardianshipfinalization),
              "__metadata": {
                "#type": "Application",
                "#id": "Application_id_1"
              },
              "status": {
                "GAPEligibilityStatus": initialstatus,
                "__metadata": {
                  "#type": "Status",
                  "#id": "Status_id_1"
                },
                "EXTGAPEligibilityStatus": null
              }
            }
          ]
        }
      }
    } ;

    this._commonHttpService.create(submissiondata, Titile4eUrlConfig.EndPoint.postGapEligibilityNExtension).subscribe(
      (res) => {
        this.submitForReview.emit();
        this._alertService.success("Submitted successfully!");
      },
      (error) => {
          this._alertService.error("Submission Failed");
      });


  }

    getEducation(personid:any) {
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    method: 'get',
                    where: { personid: personid },
                    page: 1,
                    limit: 10
                }),
                'personeducation/educationlist' + '?filter'
            ).subscribe((result) => {
                this.educationlist = result;
                this.educationlist = this.educationlist?.personEducation ?? [];
                this.educationfilterlist = [];
                this.educationlist.forEach((element:any) => {
                  element.startdate = element.startdate ? moment(element.startdate).format(this.dtformat) : null;
                  element.enddate =  element.enddate ? moment(element.enddate).format(this.dtformat) : null;
                  if (this.checkClasstypekeyCondFn(element)) {
                        if(element.classtypetypekey === null && element.schoolenrolltypekey) {
                          switch(element.schoolenrolltypekey){
                            case 'SESC':
                              element.classtypetypekey = 'JH';
                              break;
                            case 'COLLG':
                              element.classtypetypekey = 'CLG';
                              break;
                            case 'PSEOT':
                              element.classtypetypekey = 'VTP';
                              break;
                          }
                        }
                        this.educationfilterlist.push(element);
                  }
              });
            });
    }


      // Associated to getEducation function
  private checkClasstypekeyCondFn(element: any) {
    return element.classtypetypekey === 'CLG' || element.classtypetypekey === 'GEDP' || element.classtypetypekey === 'VTP' || element.classtypetypekey === 'HS'
      || element.classtypetypekey === 'JH' || element.classtypetypekey === 'IA' || element.currentgradetypekey === 'GDTWL' || element.currentgradetypekey === 'COL'
      || element.schoolenrolltypekey === 'SESC' || element.schoolenrolltypekey === 'COLLG' || element.schoolenrolltypekey === 'PSEOT';
  }

    getworkDetails(personid: string) {
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    method: 'get',
                    where: { personid: personid }
                }),
                'People/getpersonwork?filter'
            ).subscribe((result) => {
                this.employementlist = result;
                this.employementlist.forEach((element:any) => {
                    element.startdate = element.startdate ? moment(element.startdate).format(this.dtformat) : null;
                    element.enddate =  element.enddate ? moment(element.enddate).format(this.dtformat) : null;
                    element.noofhours =  element.noofhours ? Number(element.noofhours) : null;
                    if (element.workphone && element.workphone.length > 0) {
                        delete element.workphone;
                    }
                    if (element.email && element.email.length > 0) {
                        delete element.email;
                    }
                });
            });
    }

    getEmploymentBarrierDetails(personid:any) {
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    method: 'get',
                    where: {personid: personid}
                }),
                'People/getpersonworknarrative?filter'
            ).subscribe((result) => {
                this.employementbarrierlist = result;
                this.narrativeuniqueInfo = [];
                //SonarQube fix - used single for-of loop instead of the 2 for loops above
                for(const i of this.employementbarrierlist){
                  const promotedemploymentprogramname = i.promotedemploymentprogramname;
                  i.promotedemploymentprogramstartdate = i.promotedemploymentprogramstartdate ? moment(i.promotedemploymentprogramstartdate).format(this.dtformat) : null;
                  i.promotedemploymentprogramenddate =  i.promotedemploymentprogramenddate ? moment(i.promotedemploymentprogramenddate).format(this.dtformat) : null;

                  if (promotedemploymentprogramname) {
                      this.narrativeuniqueInfo.push(i);
                  }
                }
            });
    }

    getDisabilityList(personid:any) {
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: { personid: personid }
                }),
                'People/getpersondisability?filter'
            ).subscribe((result) => {
                this.disabilityfilterlist = [];
                this.disabilityList = result;
                this.disabilityList.forEach((element:any) => {
                    element.startdate = element.startdate ? moment(element.startdate).format(this.dtformat) : null;
                    element.enddate =  element.enddate ? moment(element.enddate).format(this.dtformat) : null;
                    element.evaluationdate =  element.evaluationdate ? moment(element.evaluationdate).format(this.dtformat) : null;
                    if (element.disabilityconditiontypekey === 'Yes') {
                        if (element.disabilityflag === 1) {
                            element.disabilityflag = 'Permanent';
                        }  else {
                            element.disabilityflag = 'Temporary';
                        }
                        this.disabilityfilterlist.push(element);
                    }
                });
            });
    }

  searchGapClientId() {
        if(this.gapData) {
            this.gapExtensionData = this.gapData;
            this.mapData();
        }
  }

    // Resolves the latest GAP initial determination status ('I' periods, newest first).
    // Only 'Ineligible' is passed through to the redetermination; every other status
    // (including none found) resolves to the hardcoded 'Eligible Reimbursable'.
    getGapInitialEligibilityStatus() {
        return this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    page: 1,
                    limit: 10,
                    where: { clientid: this.client_id, removalid: this.removal_id }
                },
                Titile4eUrlConfig.EndPoint.getGAPEligibilityDetails+
                '?filter'
            ).pipe(map((result: any) => {
                const initialdeterminations = Array.isArray(result)
                    ? result.filter((item: any) => item.sqnm_sw === 'I' && item.gapeligibilitystatus)
                    : [];
                const initialstatus = initialdeterminations.length > 0 ? initialdeterminations[0].gapeligibilitystatus : null;
                return String(initialstatus ?? '').trim().toUpperCase() === GAP_INELIGIBLE.toUpperCase()
                    ? GAP_INELIGIBLE
                    : GAP_ELIGIBLE_REIMBURSABLE;
            }));
    }


    dateConversion(date:any){
      if(date === undefined || date === null || date === ''){
        return null;
      }else{
        return this.datePipe.transform(date,"MM/dd/yyyy");
      }
    }


    dateTimeConversion(date:any){
      if(date === undefined || date === null || date === ''){
        return null;
      }else{
        return this.datePipe.transform(date,"MM/dd/yyyy HH:mm:ss");
      }
    }


}
