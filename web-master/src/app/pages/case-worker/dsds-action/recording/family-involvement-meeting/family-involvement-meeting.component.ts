
import {EMPTY,  Observable ,  forkJoin, combineLatest } from 'rxjs';

import {share, map, pluck} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { DropdownModel, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AlertService, DataStoreService, GenericService, SessionStorageService, AuthService } from '../../../../../@core/services';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { DSDSActionSummary } from '../../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { InvolvedPerson } from '../../involved-person/_entities/involvedperson.data.model';
import { FamilyList, Fim } from '../_entities/recording.data.model';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { AppConstants } from '../../../../../@core/common/constants';
import { TransferHistoryApprovedService } from '../../../../../shared/services/transfer-history-approved.service';
import moment from 'moment';
import { config } from '../../../../../../environments/config';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'family-involvement-meeting',
    templateUrl: './family-involvement-meeting.component.html',
    styleUrls: ['./family-involvement-meeting.component.scss'],
    standalone: false
})
export class FamilyInvolvementMeetingComponent implements OnInit {
    id!: string;
    daNumber!: string;
    isFim = false;
    isplaement = false;
    placementList: any = [];
    placementDetails: any;
    meetingTypesDropdown$!: Observable<DropdownModel[]>;
    familyMeetingTypesDropdown$!: Observable<DropdownModel[]>;
    familyMeetingTypesDropdown: any[] = [];
    familyMeetingTypesDropdownOG: any[] = [];
    informalSupportDropdown$!: Observable<DropdownModel[]>;
    ldssStaffDropdown$!: Observable<DropdownModel[]>;
    schoolSystemDropdown$!: Observable<DropdownModel[]>;
    involevedPerson$!: Observable<InvolvedPerson[]>;
    allParticipantTypeDropdown$!: Observable<DropdownModel[]>;
    totalPlaceinfo: any[] = [];
    hearingdetailslist: any;
    hearingdetailsout: any;
    placeinforDropdown: any[] = [];
    familyIM!: Fim;
    fimList$!: Observable<FamilyList[]>;
    fimView!: FamilyList;
    fimForm!: FormGroup;
    selectedFimType: any[] = [];
    fimSubType: any[] = [];
    isPermanencyPlanFIM: boolean=false;
    minDate = new Date();
    dsdsActionsSummary = new DSDSActionSummary();
    showFollowUp = false;
    meetingDecisionAccepted = false;
    meetingDecisionRejected = false;
    involvedDrop!: boolean;
    otherPerticipants!: boolean;
    selected = 'involvedPerson';
    isServiceCase: any;
    uploadedDocuments: any[] = [];
    uploadType= 'meeting';
    isClosed = false;
    userRole: any;
    caseNumber!: string;
    source!: string;
    caseType!: string;
    isIntakeWorker!: boolean;
    isUploadClicked!: boolean;
    involevedPersons!: InvolvedPerson[];
    involvedParticipants!: InvolvedPerson[];
    isReadonly = true;
    viewForm : boolean = false;
    hearingdetailslistdis : boolean = false;
    downldSrcURL!: string;
    totalCount!: number;
    baseUrl!: string;
    isEditDisabled = false;
    CHILD_CATEGORIES = ['CHILD', 'BIOCHILD', 'NVC', 'OTHERCHILD', 'PAC', 'RC', 'AV'];
    disableSubmit:boolean = false;
    selectPersonNameList: string[] = [];
    selectPersonListforhearing: any[] = [];
    isAdoptionCase: boolean = false;
    checkmandatory: boolean = false;
    addmeeetinpopupid = '#add-new-meeting';
    removalfimstr = 'Removal FIM';
    vpafimstr = 'Voluntary Placement Agreement (VPA) FIM';
    //CIDM-10031: We want to still replicate the behavior of previous values (being de-activated) with the new ones
    //'Change in Permanency Plan FIM' --> Permanency Planning (PPF)
    permanencyFIM_old = 'Change in Permanency Plan FIM';
    permanencyFIM_new = 'PPF';
    //'Change in Placement FIM' --> Placement stability (PSF)
    placementFIM_old = 'Change in Placement FIM';
    placementFIM_new = 'PSF';
    //Auto Save
    //Auto Save
    autoSaveIntervalTimer!: any;
    autoSaveEnabled = false;
    autoSaveCounter = 0;

    /**
     *  De-activated familymeetingtype reference values
        Instead of setting activeflag = 0 in the DB, we will hide these values from UI
        This way we will be able to show historical data with those values
        These values we will be disabled when adding New or Edit record
    */
    deactivatedfamilymeetingtype = [
        'Change in Permanency Plan FIM',
        'Case Planning FIM',
        'Removal FIM',
        'Change in Placement FIM',
        'Youth Transition FIM',
        'Voluntary Placement Agreement (VPA) FIM'
    ];

    private route: ActivatedRoute;
    private _alertService: AlertService;
    private _commonHttpService: CommonHttpService;
    private _authService: AuthService;
    private _formBuilder: FormBuilder;
    private _router: Router;
    private _servicePlan: GenericService<Fim>;
    private _dataStoreService: DataStoreService;
    private _session: SessionStorageService;
    private readonly _transferHistoryApprovedService: TransferHistoryApprovedService;
    retrymeetingid: any;
    retrydoc: any;
    meetingListCheck: any;
    
    constructor(private injector: Injector) {
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._router = this.injector.get<Router>(Router);
        this._servicePlan = this.injector.get<GenericService<Fim>>(GenericService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._session = injector.get<SessionStorageService>(SessionStorageService);
        this._transferHistoryApprovedService = injector.get<TransferHistoryApprovedService>(TransferHistoryApprovedService);
        this.isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this.route.queryParams.subscribe(params => {
            this.retrydoc = params['retrydocument'];
            this.retrymeetingid = params['retryid'];
        });
    }

    ngOnInit() {
        this.isEditDisabled = this._authService.isDisabled('contacts','contacts.meeting.edit');
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.getInvolvedPerson(); 
        this.getFimDropDown();         
        this.isUploadClicked = false;
        this.userRole = this._authService.getCurrentUser();
        if ( this.userRole && this.userRole.role && this.userRole.role.name !== AppConstants.ROLES.SUPERVISOR ) {
            if(this.userRole.role.name === 'CJAMS_SSA_FTDM_FACILITATOR' ||this.userRole.role.name === 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' ||this.userRole.role.name === 'CJAMS_SSA_FTDM_QI_SUPERVISOR'){
              this.isReadonly = this.compareWithResponsibleworkers(this.userRole.user.email);
            } else {
              this.isReadonly = this._authService.readonlyButton('read_only_access', 'caseworker-contacts-notes-family-add-new');
            }
        }
        this.isIntakeWorker =
            this.userRole.role.name === AppConstants.ROLES.INTAKE_WORKER;
        this.fimForm = this._formBuilder.group({
            meetingdate: [new Date()],
            meetingrecordingid: [null],
            meetingtypekey: [null],
            persontype: [''],
            meetingstatus: [null, Validators.required],
            personname: [''],
            meetingdescription: [''],
            meetingcomments: [''],
            meetingdecision: [null],
            meetingdecisioncomments: [''],
            isfollowupmeeting: [null],
            followmeetingrecordingactor: [''],
            followmeetingdate: [null],
            followupdate: [null],
            parentmeetingid: [null],
            iscompleted: [null],
            participants: [''],
            meetingrecordingactor: [''],
            fimtype: [''],
            intakeserviceid: [''],
            placementid: [null],
        });
        this.fimForm.setControl('meetingparticipants', this._formBuilder.array([]));
        this.fimForm.setControl('hearingdetails', this._formBuilder.array([]));
        this._dataStoreService.currentStore.subscribe((store: any) => {
            if (store['dsdsActionsSummary']) {
                this.dsdsActionsSummary = store['dsdsActionsSummary'];
            }
        });
        const da_status = this._session.getItem('da_status');
        if (da_status) {
         if (da_status === 'Closed' || da_status === 'Completed') {
             this.isClosed = true;
         } else {
             this.isClosed = false;
         }
        }
        if(this.isIntakeMode() && this._transferHistoryApprovedService.getTrasferHistory()) {
            this.isClosed = true;
        }
    }


    compareWithResponsibleworkers(userDetail: any){
        let activeMod = "";
        if (this._session.getItem('activeModuleRole') == 'CJAMS_SSA_FTDM_FACILITATOR') { activeMod = "FTDM Facilitator"; }
        else if (this._session.getItem('activeModuleRole') == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL') { activeMod = "Qualified Individual"; }
        else if (this._session.getItem('activeModuleRole') == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') { activeMod = "FTDM/QI Supervisor"; }

        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        const tempArray = [];
        let isReadonly = false;
        if(caseInfo && caseInfo.responsibleworkers){
            for (let i = 0; i < caseInfo.responsibleworkers.length; i++) {
                if(caseInfo.responsibleworkers[i].enddate == null && caseInfo.responsibleworkers[i].email == userDetail 
                    && caseInfo?.responsibleworkers[i]?.teamname == activeMod){
                    tempArray.push(caseInfo.responsibleworkers[i]);
                }
            }
            if(tempArray.length!=0){isReadonly=true;}
            else{isReadonly=false;}
        }
        return isReadonly;
    }
    addServicePlan(fimModel: any) {
        this.checkmandatory = true;
      try {
        this.disableSubmit = true;
        if (this.fimForm.invalid) {
            this._alertService.error('Please Complete Form');
            this.disableSubmit = false;
            return;
        }        
        fimModel = fimModel.getRawValue();
        if (fimModel && (!fimModel.meetingparticipants || fimModel.meetingparticipants.length <= 0)) {
            this._alertService.error('Please Add atleast One Participants');
            this.disableSubmit = false;
            return;
        }

        if (this._session.getItem('ISADOPTION')) {
            this.isAdoptionCase = true;
        }

        if(!this.isAdoptionCase && this._session.getItem('CASE_TYPE') && this._session.getItem('CASE_TYPE') === 'ADOPTION'){
            this.isAdoptionCase = true;
        }

      this.checkIfNotAdoptionCaseFn(fimModel);
      this.checkIfAdoptionCaseFn(fimModel);

          this.handleHearingdetailsFn(fimModel);
        
        if (fimModel.meetingparticipants.length > 0) {
            fimModel.meetingparticipants = this.returnMeetingparticipantsDataFn(fimModel);
            fimModel.uploadedfile = this.uploadedDocuments;
            this.familyIM = Object.assign({}, fimModel);

            this.handleSelectedFimTypeCondFn(fimModel);

            this.familyIM.intakeserviceid = this.id;
            this.familyIM.uploadedfile = this.uploadedDocuments;
            this.familyIM.iscompleted = fimModel.meetingstatus;
            this.familyIM.ismeetingdecision = fimModel.meetingdecision;
            if (this.isServiceCase) {
                this.familyIM.servicecaseid = this.id;
                this.familyIM.intakeserviceid = null;
                this.familyIM.adoptioncaseid = null;
            }
            if (this.isAdoptionCase) {
                this.familyIM.adoptioncaseid = this.id;
                this.familyIM.intakeserviceid = null;
                this.familyIM.servicecaseid = null;
            }
            this._servicePlan.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Fim.AddParticipantUrl;
            this.handleFamilyIMApiFn();
        } else {
            this._alertService.error('Please Add atleast One Participants');
        }
      } catch (e) {
        this.disableSubmit = false;
        throw e;
      }
    }
    // Assosiated to addServicePlan method
    private returnMeetingparticipantsDataFn(fimModel: any): any {
        return fimModel.meetingparticipants.map((res: any) => {
            return {
                participanttype: res.Persondropdown,
                participantkey: res.participantkey,
                firstname: res.firstname,
                lastname: res.lastname,
                emailid: res.emailid,
                personid: res.personid,
                isinvited: res.isinvited ? 1 : 0,
                isattended: res.isattended ? 1 : 0,
                isaccpted: res.isaccpted === 1 ? 1 : 0,
                electronicsignature: res.electronicsignature,
                collateralid: res.collateralid
            };
        });
    }
    // Assosiated to addServicePlan method
    private handleHearingdetailsFn(fimModel: any) {
        if (fimModel.hearingdetails.length > 0) {
            fimModel.hearingdetails = fimModel.hearingdetails.map((res: { clientid: any; hearingdetails: any; }) => {
                return {
                    clientid: res.clientid,
                    hearingdetails: res.hearingdetails
                };
            });
        }
    }

    // Assosiated to addServicePlan method
    private handleFamilyIMApiFn() {
        this._servicePlan.create(this.familyIM).subscribe(
            (res: string | any[]) => {
                //If autosaving, keep the modal pop-up open and continue
                if(this.autoSaveEnabled) {
                    if(res && res.length) {
                        var savedrecord = res;                    
                        this.fimForm.patchValue({
                            meetingrecordingid: savedrecord[0].meetingrecordingid
                        });
                        this._alertService.success('AutoSaved meeting notes successfully');
                    }
                } else {
                //If saving with the button (manually), hide the pop-up and reset
                    try {
                        this.getPageList();
                        $(this.addmeeetinpopupid).modal('hide');
                        if (this.isUploadClicked) {
                            this.isUploadClicked = false;
                            this._router.navigate(['/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment/attachment-upload']);
                        }
                        this.clearFim();
                        this._alertService.success('Participants Added successfully');

                        //@AutoSave
                        this.resetAutoSave();
                    } catch (e) {
                        this.disableSubmit = false;
                        throw e;
                    }
                }
            },
            (_error: any) => this.disableSubmit = false, () => this.disableSubmit = false
        );
    }
    // Assosiated to addServicePlan method
    private handleSelectedFimTypeCondFn(fimModel: any) {
        if (Array.isArray(this.selectedFimType) && this.selectedFimType.length) {
            this.familyIM.fimtype = [];
            this.selectedFimType.forEach((fimType: any) => this.familyIM.fimtype.push({
                familymeetingtypekey: fimType.familymeetingtypekey,
                familymeetingsubtypekey: fimType.familymeetingsubtypekey
            }));
        } else if (Array.isArray(fimModel.fimtype) && fimModel.fimtype.length) {
            this.familyIM.fimtype = [];
            fimModel.fimtype.forEach((fimType: any) => this.familyIM.fimtype.push({
                familymeetingtypekey: fimType,
                familymeetingsubtypekey: 'null'
            }));
        } else {
            this.familyIM.fimtype = [];
        }
    }
    // Assosiated to addServicePlan method
    private checkIfAdoptionCaseFn(fimModel: any) {
        if (this.isAdoptionCase) {
            fimModel.meetingrecordingactor = fimModel.meetingrecordingactor.map((personid: any) => {
                const person: any = this.involevedPersons.find(item => item.personid === personid);
                return {
                    adoptioncaseactorid: person.intakeservicerequestactorid,
                    intakeservicerequestactorid: null,
                    personid: personid
                };
            });
            if (fimModel.followmeetingrecordingactor && fimModel.followmeetingrecordingactor.length) {
                fimModel.followmeetingrecordingactor = fimModel.followmeetingrecordingactor.map((res: { intakeservicerequestactorid: any; personid: any; }) => {
                    return {
                        adoptioncaseactorid: res.intakeservicerequestactorid,
                        intakeservicerequestactorid: null,
                        personid: res.personid
                    };
                });
            }

        }
    }
    // Assosiated to addServicePlan method
    private checkIfNotAdoptionCaseFn(fimModel: any) {
        if (!this.isAdoptionCase) {
            fimModel.meetingrecordingactor = fimModel.meetingrecordingactor.map((personid: string) => {
                const person: any = this.involevedPersons.find(item => item.personid === personid);
                return {
                    intakeservicerequestactorid: person.intakeservicerequestactorid,
                    personid: personid
                };
            });
            if (fimModel.followmeetingrecordingactor && fimModel.followmeetingrecordingactor.length) {
                fimModel.followmeetingrecordingactor = fimModel.followmeetingrecordingactor.map((res: { intakeservicerequestactorid: any; personid: any; }) => {
                    return {
                        intakeservicerequestactorid: res.intakeservicerequestactorid,
                        personid: res.personid
                    };
                });
            }
        }
    }

    navigatetoattachements() {
        // No data or function to call or add
    }


    getFullName(person: any) {
        const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
        let name = '';
        nameKeys.forEach(key => {
          if(person && person.hasOwnProperty(key)){
          if ( (person[key] != null) && (person[key] != 'null') && (person[key] != '') ) {
            name = name + person[key] + ' ';
          }}
        });
        return name.trim();
      }
    
    getFimType(fimType: any) {
        if (fimType === 'FIM' || fimType === 'FTDM') {
            this.isFim = true;
            this.fimForm.patchValue({
                fimtype : ''
            });
            this.fimForm.get('fimtype')?.setValidators([Validators.required]);
            this.fimForm.get('fimtype')?.updateValueAndValidity();
            if (this.fimForm.get('fimtype')?.value == this.placementFIM_old 
                || this.fimForm.get('fimtype')?.value == this.placementFIM_new) {
                this.isplaement = true;
                this.fimForm.patchValue({
                    placementid : null
                });
                this.fimForm.get('placementid')?.setValidators([Validators.required]);
                this.fimForm.get('placementid')?.updateValueAndValidity();
            }
        } else {
            this.isFim = false;
            this.fimForm.patchValue({
                fimtype : '',
                placementid: null
            });
            this.fimForm.get('fimtype')?.setValidators(null);
            this.fimForm.get('fimtype')?.updateValueAndValidity();
            this.isplaement = false;
            this.fimForm.get('placementid')?.setValidators(null);
            this.fimForm.get('placementid')?.updateValueAndValidity();
        }
    }
    viewFim(family: FamilyList) {
        this.viewForm = true;
        if (family.meetingtypekey === 'FIM' || family.meetingtypekey === 'FTDM') {
            this.isFim = true;
        } else {
            this.isFim = false;
        }
        if(family.fimtype) {
            this.fimSubType = family.fimtype;
        }
            this.uploadedDocuments = [];
            this.uploadedDocuments = this.returnUploadedfileFn(family);
            const meetingparticipants = this.returnMeetingParticipantsFn(family);
            
            const hearingdetail = family.hearingdetail ? (family.hearingdetail.map((res: any) => {
                return {
                    clientid: res.clientid,
                    hearingdetails: res.intakeservicerequestcourthearingid
                };
            })):[];
        
        
        if (family.meetingtypekey == 'FTDM') {
          this.isFim = true;
          this.isplaement = true;
        }
        this.fimForm.patchValue(this.patchFimFormDataFn(family, meetingparticipants, hearingdetail));
        this.getPersonNameList(this.fimForm.getRawValue().meetingrecordingactor, this.involevedPersons, undefined, true);
        this.fimdetailsLogic(family);
        if(!this.hearingdetailslist){
           this.gethearingdetails();
        }
        this.fimForm.setControl('hearingdetails', this._formBuilder.array([]));
        
        const control1 = <FormArray>this.fimForm.controls['hearingdetails'];
        hearingdetail.forEach((element: { [key: string]: any; }) => {
            control1.push(this._formBuilder.group(element));
        });
        if (this.fimForm.controls.fimtype.value == this.permanencyFIM_old 
            || this.fimForm.controls.fimtype.value == this.permanencyFIM_new)
         {
             this.isPermanencyPlanFIM=true;
         }else{
          this.isPermanencyPlanFIM=false;
         }
        this.fimForm.setControl('meetingparticipants', this._formBuilder.array([]));
        const control = <FormArray>this.fimForm.controls['meetingparticipants'];
        meetingparticipants.forEach(element => {
            control.push(this._formBuilder.group(element));
        });
        this.fimForm.disable();
        $(this.addmeeetinpopupid).modal('show');
    }
    fimdetailsLogic(family: any) {
        if (family.fimdetails && family.fimdetails.length &&
             (family.fimdetails.map((item: any) => item.familymeetingtypekey).includes(this.placementFIM_old) 
                || family.fimdetails.map((item: any) => item.familymeetingtypekey).includes(this.placementFIM_new))) {
            this.isplaement = true;
            if(!this.viewFim) {
            setTimeout(() => {
                this.fimForm.patchValue(
                    {
                        placementid: family.placementid
                    }
                );      
                this.fillPlacementInfo(family.placementid);        
            }, 1000);
        }
        }
    }
    // Assosiated with viewFim method
    private patchFimFormDataFn(family: FamilyList, meetingparticipants: any[], hearingdetail: any) {
        return this.returnFimFormPatchFn(family, meetingparticipants, hearingdetail);
    }

    downloadFile(s3bucketpathname: any) {
        
            // 4200
            s3bucketpathname = s3bucketpathname.replace(/,/g, '');
            this.downldSrcURL = '/api' + s3bucketpathname;
        
        window.open(this.downldSrcURL, '_blank');
    }

    downloadLargeFileView(source: any) {
        if (source.ecmsdocumentid !== '' )
            {
            const where = {
            "docId": source.ecmsdocumentid ,
            "filename":  source.originalfilename
            }
            const endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.downloadFileViewFromEDMS;
            this._commonHttpService
            .create(
            {
                method: 'post',
                where
            },
            endpointUrl + '?filter'
            ).subscribe(
                (response) => {
                const result = (typeof response === 'string') ? JSON.parse(response) : response;
                const s3bucketpathname = result?.downloadUrl?.replace(/,/g, '');
                if (!s3bucketpathname) {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    return;
                }
                window.open(s3bucketpathname, '_blank');
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }     
    }

    redirectToUpload() {
        this.isUploadClicked = true;
        this.addServicePlan(this.fimForm.value);
    }

    addNewMeeting() {
        this.filterFamilyMeetingTypesDropdown();
        this.initAutoSave(true);
    }

    filterFamilyMeetingTypesDropdown() {
        //In Add mode we want to simply remove all options from deactivated list
        this.familyMeetingTypesDropdownOG = this.familyMeetingTypesDropdown;
        this.familyMeetingTypesDropdown =  this.familyMeetingTypesDropdown.filter( (item) =>
            !this.deactivatedfamilymeetingtype.includes(item.familymeetingtypekey)
        );
    }

    filterFamilyMeetingTypesDropdownEditMode(fimdetails: any) {
        //In edit mode we want to only show historically selected options from deactivated list and remove the rest
        this.familyMeetingTypesDropdownOG = this.familyMeetingTypesDropdown;
        var pastselectedfimtype = fimdetails.map((item: any) => item.familymeetingtypekey)
        this.familyMeetingTypesDropdown =  this.familyMeetingTypesDropdown.filter( (item) =>
            !this.deactivatedfamilymeetingtype.includes(item.familymeetingtypekey) ||
            pastselectedfimtype.includes(item.familymeetingtypekey)
        );
    }

    resetFamilyMeetingTypesDropdown() {
        this.familyMeetingTypesDropdown = this.familyMeetingTypesDropdownOG;
    }

    initAutoSave(enableFlag: any) {
        this.autoSaveCounter = 60;
        this.autoSaveEnabled = true;
        if(enableFlag) {
            this.autoSaveIntervalTimer = setInterval(() => {
                //Save meeting
                this.autoSaveCounter=this.autoSaveCounter-10;
                if(this.fimForm.dirty && this.fimForm.valid) {
                    this.addServicePlan(this.fimForm);
                } else if (!this.fimForm.valid){
                    this._alertService.error('Please enter all mandatory fields before entering notes to enable auto save.');
                    return;
                }    
            }, config.AutoSaveTimer);
        }
    }

    resetAutoSave() {
        if(this.autoSaveIntervalTimer) {
            clearInterval(this.autoSaveIntervalTimer);
            this.autoSaveIntervalTimer = null;
        }
    }

    editFim(family: FamilyList) {
        this.initAutoSave(true);
        if (family.meetingtypekey === 'FIM') {
            this.isFim = true;
        } else {
            this.isFim = false;
        }
        if(family.fimtype) {
            this.fimSubType = family.fimtype;
        }
            this.uploadedDocuments = [];
            this.uploadedDocuments = this.returnUploadedfileFn(family);
            const meetingparticipants = family.participants ? (family.participants.map(_item => {
                return { Persondropdown: _item.participanttype,
                firstname: _item.firstname,
                lastname: _item.lastname,
                isinvited : _item.isinvited,
                isattended : _item.isattended,
                isaccpted : _item.isaccpted,
                electronicsignature: _item.electronicsignature,
                personid: _item.personid,
                collateralid: _item.collateralid,
                 isAutoParticipant: !!(_item.personid || _item.collateralid)
            };

            })) : [];
            if (family.meetingtypekey == 'FTDM') {
                this.isFim = true
            }
        
            const hearingdetail = family.hearingdetail ? (family.hearingdetail.map((res: any) => {      //NOSONAR    // This function has less than 3 lines of duplicate code. Hence, marking it as no sonar.
                return {
                    clientid: res.clientid,
                    hearingdetails: res.intakeservicerequestcourthearingid
                };
            })):[];

            this.getFimType(family.meetingtypekey);
        //Still show historically selected fimtype options from deactivated list
        if(family && family.fimdetails) {
            this.filterFamilyMeetingTypesDropdownEditMode(family.fimdetails);
        }
        this.fimForm.patchValue(this.returnFimFormPatchFn(family, meetingparticipants, hearingdetail));
        this.getPersonNameList(this.fimForm.getRawValue().meetingrecordingactor, this.involvedParticipants)
        this.fimdetailsLogic(family);
        if(!this.hearingdetailslist){
            this.gethearingdetails();
         }
         this.fimForm.setControl('hearingdetails', this._formBuilder.array([]));
         
         const control1 = <FormArray>this.fimForm.controls['hearingdetails'];
         hearingdetail.forEach((element: any) => {
             control1.push(this._formBuilder.group(element));
         });
         if (this.fimForm.controls.fimtype.value == this.permanencyFIM_old 
            || this.fimForm.controls.fimtype.value == this.permanencyFIM_new)
         {
             this.isPermanencyPlanFIM=true;
         }else{
          this.isPermanencyPlanFIM=false;
         }
        this.fimForm.setControl('meetingparticipants', this._formBuilder.array([]));
        const control = <FormArray>this.fimForm.controls['meetingparticipants'];
        meetingparticipants.forEach(element => {
            control.push(this._formBuilder.group(element));
        });
        this.viewForm = false;
        this.fimForm.enable();
        $(this.addmeeetinpopupid).modal('show');

    }
    // Assosiated with editFim and viewFim function
    private returnMeetingParticipantsFn(family: FamilyList) {
        return family.participants ? (family.participants.map(item => {
            return {
                Persondropdown: item.participanttype,
                firstname: item.firstname,
                lastname: item.lastname,
                isinvited: item.isinvited,
                isattended: item.isattended,
                isaccpted: item.isaccpted,
                electronicsignature: item.electronicsignature,
                personid: item.personid,
                collateralid: item.collateralid,
                isAutoParticipant: !!(item.personid || item.collateralid)
            };
        })) : [];
    }
    // Assosiated with editFim function
    private returnFimFormPatchFn(family: FamilyList, meetingparticipants: any, hearingdetail: any) {
        return {
            meetingdate: family.meetingdate,
            meetingrecordingactor: family.recordingactor ? family.recordingactor.map(item => item.personid) : null,
            persontype: family.persontype,
            personname: family.personname,
            meetingstatus: family.iscompleted,
            meetingtypekey: family.meetingtypekey,
            fimtype: family.fimdetails ? family.fimdetails.map(item => item.familymeetingtypekey) : null,
            participants: family.participants ? family.participants.map(item => item.personid) : null,
            meetingdescription: family.meetingdescription,
            meetingcomments: family.meetingcomments,
            isfollowupmeeting: family?.isfollowupmeeting == null ? null : family.isfollowupmeeting.toString(),
            followmeetingdate: family.followmeetingdate,
            followupdate: family.followupdate,
            followmeetingrecordingactor: family.followmeetingrecordingactor,
            meetingdecision: family.ismeetingdecision,
            meetingdecisioncomments: family.meetingdecisioncomments,
            meetingrecordingid: family.meetingrecordingid,
            meetingparticipants: meetingparticipants,
            hearingdetails: hearingdetail,
            placementid: family.placementid
        };
    }
    // Assosiated with editFim function
    private returnUploadedfileFn(family: FamilyList) {
        return family.uploadedfile && family.uploadedfile.data ? family.uploadedfile.data : [];
    }

    clearFim() {
        this.resetAutoSave();
        this.resetFamilyMeetingTypesDropdown();
        this.uploadedDocuments = [];
        this.viewForm = false;
        this.isPermanencyPlanFIM=false;
        this.fimForm.reset();
        this.fimForm.enable();
        this.selectedFimType = [];
        this.fimSubType = [];
        this.isFim = false;
        this.isplaement = false;
        this.informalSupportDropdown$ = EMPTY;
        this.ldssStaffDropdown$ = EMPTY;
        this.schoolSystemDropdown$ = EMPTY;
        this.allParticipantTypeDropdown$ = EMPTY;
        this.getFimDropDown();
        this.fimForm.setControl('meetingparticipants', this._formBuilder.array([]));
        this.selectPersonNameList = [];
    }
    changeParticipants(selected: any, person: any) {
        this.involvedDrop = true;
        this.otherPerticipants = false;
        const personIdentifierValue = person.personid ? person.personid : person.collateralid;
        if (selected) {
            this.addMeetingParticipants(true, personIdentifierValue);
        } else {
            const control = <FormArray>this.fimForm.controls['meetingparticipants'];
            this.deleteMeetingParticipants(control.value.findIndex((item: { personid: any; collateralid: any; }) => item.personid === personIdentifierValue || item.collateralid === personIdentifierValue), null);
        }
    }
    newParticipants(modal: any) {
        const role = [];
        role.push({ typedescription: modal.source.value.split('~')[2] });
        if (modal.checked) {
            const psrticip = Object.assign({
                rolename: modal.source.value.split('~')[1],
                parentrolename: modal.source.value.split('~')[0],
                roles: role
            });
            this.addMeetingParticipants(false, psrticip);
        } else {
            const control = <FormArray>this.fimForm.controls['meetingparticipants'];
            control.controls.forEach((cont: any) => {
                if (modal.source.value.split('~')[1] === cont.value.participantkey && modal.source.value.split('~')[0] === cont.value.participanttype) {
                    const removeIndex = control.controls.indexOf(cont);
                    this.deleteMeetingParticipants(removeIndex, modal);
                }
            });
        }
    }
    otherParticipants() {
        this.otherPerticipants = true;
        this.involvedDrop = false;
        const psrticip = Object.assign({
            rolename: '',
            parentrolename: '',
            roles: ''
        });
        this.addMeetingParticipants(false, psrticip);
    }
    deleteOthersMeetingParticipants(index: number) {
        const control = <FormArray>this.fimForm.controls['meetingparticipants'];
        control.removeAt(index);
    }

    addMeetingParticipants(isInvovled: any, personinfo: any) {
        let involvedpersontype = '';
        if (this.involvedDrop) {
            involvedpersontype = 'involvedperson';
        }
        const control = <FormArray>this.fimForm.controls['meetingparticipants'];
        if (isInvovled) {
            const person = this.involvedParticipants.find(item => item.personid === personinfo || item.collateralid === personinfo);
            control.push(this.createFormGroup(person, involvedpersontype));
        } else {
            control.push(this.createFormGroup(personinfo, involvedpersontype));
        }

    }
    deleteMeetingParticipants(index: number, _e: any) {
        const control = <FormArray>this.fimForm.controls['meetingparticipants'];
        control.removeAt(index);
        const meetingparticipants = control.value;
        let participants: any = '';
        if (meetingparticipants && meetingparticipants.length) {
            participants = [];
            meetingparticipants.forEach((element: any) => {
                if (element.personid) {
                    participants.push(element.personid);
                } else if(element.collateralid){
                    participants.push(element.collateralid)
                }
            });
        }
        this.fimForm.patchValue({
            participants: participants
        });
    }
    gethearingdetails(){
        let objectkey;
        if( this.caseType == 'Service Case'){
            objectkey='servicecase'
        }else{
            objectkey=null;
        }
        let meetingidforpayload;
        if(this.fimForm.get('meetingrecordingid')?.value)
        {
            meetingidforpayload=this.fimForm.get('meetingrecordingid')?.value;
        }else{
             meetingidforpayload=null
        }
        this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
            
            method: 'get',
            where: { objecttypekey :objectkey ,meetingidforload:meetingidforpayload,servicecaseid: this.id,meetingdate:moment(this.fimForm.get('meetingdate')?.value).format('YYYY-MM-DD hh:mm:ss') },
            }),
            'Meetingrecordings/gethearingdetails?filter'
           
        ).subscribe((result1: any) => {           
            this.hearingdetailsout =result1;
            this.hearingdetailslist = this.hearingdetailsout.reduce((result: any, currentValue: any) => {
                const personId = currentValue['personid'];
                if (!result[personId]) {
                  result[personId] = [];
                }
                result[personId].push(currentValue);
                
                return result;
              }, {});
              
           Object.keys(this.hearingdetailslist).forEach(key=>{((this.hearingdetailslist[key])||[]).sort((a: any,b: any)=>b.hearingdatetime.localeCompare(a.hearingdatetime)) });
        });
    }

    onFimTypeChange(event: any) {
        this.fimSubType = event.value;
        if((this.fimSubType.includes(this.permanencyFIM_old) || this.fimSubType.includes(this.permanencyFIM_new)) && this.fimForm.controls.meetingtypekey.value=='FTDM' )
        {
            this.isPermanencyPlanFIM=true;
            const hearingdetails=this.selectPersonListforhearing.map((item: any) =>{return {clientid:item.personid,'hearingdetails':''}});
            this.fimForm.setControl('hearingdetails', this._formBuilder.array([]));
            const control = <FormArray>this.fimForm.controls['hearingdetails'];
            hearingdetails.forEach(val => {
                control.push(this._formBuilder.group(val));
            });
            this.gethearingdetails();
        }else{
            this.isPermanencyPlanFIM=false;
        }
        this.selectedFimType = [];
        this.isplaement = false;
        this.fimForm.get('placementid')?.reset();
        this.fimForm.get('placementid')?.setValidators(null);
        this.fimForm.get('placementid')?.updateValueAndValidity();
        this.placementDetails = null;
        event.value.map((subType: any) => {
            const familymeetingsubtype = this.familyMeetingTypesDropdown.find(item => item.familymeetingtypekey === subType);
            if (!familymeetingsubtype.length) {
                this.selectedFimType.push({
                    familymeetingtypekey: subType,
                    familymeetingsubtypekey: 'null'
                });
            }
        });
        if (this.selectedFimType.length !== event.value.length) {
            this.fimForm.markAsPristine();
        } else {
            this.fimForm.markAsDirty();
        }
        if (event.value.length) {
            this.handleOnFimTypeChangeEventFn(event);
        } else {
            this.familyMeetingTypesDropdown.forEach((item) => {
                item.additionalProperty = false;
            });
        }
    }
    // Assosiated to onFimTypeChange method
    private handleOnFimTypeChangeEventFn(event: any) {
        if (event.value.filter((fim: any) => fim === this.removalfimstr).length) {
            this.checkRemovalfimstrFn();
        } else if (event.value.filter((fim: any) => (fim === this.placementFIM_old || fim === this.placementFIM_new)).length) {
            this.isplaement = true;
            this.fimForm.get('placementid')?.setValidators([Validators.required]);
            this.fimForm.get('placementid')?.updateValueAndValidity();
        } else if (event.value.filter((fim: any) => fim === this.vpafimstr).length) {
            this.checkVpafimstrFn();
        } else {
            this.checkEitherVpafimstrOrRemovalfimstrFn();
        }
    }
    // Assosiated to onFimTypeChange method
    private checkEitherVpafimstrOrRemovalfimstrFn() {
        const fimType = this.fimForm.value.fimtype;
        if (fimType && fimType.length) {
            fimType.forEach((fim: any, index: any) => {
                if (fim === this.removalfimstr || fim === this.vpafimstr) {
                    fimType.splice(index, 1);
                }
            });
            this.fimForm.patchValue({ primaryPlan: fimType });
        }
        this.familyMeetingTypesDropdown.forEach((item) => {
            if (item.familymeetingtypekey === this.removalfimstr || item.familymeetingtypekey === this.vpafimstr) {
                item.additionalProperty = true;
            } else {
                item.additionalProperty = false;
            }
        });
    }
    // Assosiated to onFimTypeChange method
    private checkVpafimstrFn() {
        const fimType = this.fimForm.value.fimtype;
        if (fimType && fimType.length) {
            fimType.forEach((fim: any, index: any) => {
                if (fim !== this.vpafimstr) {
                    fimType.splice(index, 1);
                }
            });
            this.fimForm.patchValue({ primaryPlan: fimType });
        }
        this.familyMeetingTypesDropdown.forEach((item) => {
            if (item.familymeetingtypekey !== this.vpafimstr) {
                item.additionalProperty = true;
            } else {
                item.additionalProperty = false;
            }
        });
    }
    // Assosiated to onFimTypeChange method
    private checkRemovalfimstrFn() {
        const fimType = this.fimForm.value.fimtype;
        if (fimType && fimType.length) {
            fimType.forEach((fim: any, index: any) => {
                if (fim !== this.removalfimstr) {
                    fimType.splice(index, 1);
                }
            });
            this.fimForm.patchValue({ primaryPlan: fimType });
        }
        this.familyMeetingTypesDropdown.forEach((item) => {
            if (item.familymeetingtypekey !== this.removalfimstr) {
                item.additionalProperty = true;
            } else {
                item.additionalProperty = false;
            }
        });
    }

    onFimSubTypeChange(event: any) {
        const subType = this.familyMeetingTypesDropdown.find(item => item.familymeetingtypekey === event.value);
        this.selectedFimType.push({
            familymeetingtypekey: subType.familymeetingtypekey,
            familymeetingsubtypekey: subType.familymeetingsubtypekey
        });
        this.fimForm.markAsDirty();
    }
    private createFormGroup(getROle: any, involvedpersontype: any) {
    const isAutoParticipant = involvedpersontype === 'involvedperson';
        return this._formBuilder.group({
            participanttype: [getROle.parentrolename ? getROle.parentrolename : 'IP'],
            participantkey: [getROle.rolename ? getROle.rolename : null],
            participantDesc: [getROle.roles ? getROle.roles[0].typedescription : null],
            firstname: [getROle.firstname ? getROle.firstname : null, Validators.required],
            lastname: [getROle.lastname ? getROle.lastname : null, Validators.required],
            emailid: [getROle.email ? getROle.email : null],
            personid: [getROle.personid],
            isinvited: [''],
            isattended: [''],
            isaccpted: [''],
            providerId: [''],
            electronicsignature:[''],
            Persondropdown: [involvedpersontype],
            collateralid: [getROle.collateralid],
            isAutoParticipant: [isAutoParticipant]
        });
    }
    hearingdetailsTooltip(clientid: any, id: any){
        if(!id){
            return;
        }
          const res= this.hearingdetailslist[clientid]?.find((ele: { intakeservicerequestcourthearingid: any; })=>ele.intakeservicerequestcourthearingid 
                == id);
                return res?.hearingtype + ',' + moment(res?.hearingdatetime).format('MM/DD/yyyy,hh:mm a');
      }
    enableFollowUp(event: string) {
        this.showFollowUp = event === '1' ? true : false;
    }

    enableMeetingRejected(event: string) {

        this.meetingDecisionRejected = event === 'Rejected' ? true : false;
        if (!this.meetingDecisionRejected) {
        this._alertService.success('Assessments Should be completed within next 5 days');

    }

    }


    private getInvolvedPerson() {
        let params: any =  this.getRequestParam();
        if (this.isServiceCase) {
            params = { objectid: this.id, objecttypekey: 'servicecase',  servicecaseid: this.id };
        }
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    
        let url = '';
        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        params['isExpungementSuperUser'] = isExpungementSuperUser;
        params['iscaseexpunged'] = iscaseexpunged;

        this.involevedPerson$ = this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    where: params
                },
                url + '?filter'
            ).pipe(
            map((res: any) => {
                return res['data'];
            }));
            this.involevedPerson$.subscribe((persons: any) => {
                const personList = [...persons];
                this.involevedPersons = personList;
                const data = this.getRequestParamCollateral();
                const request = {
                    objectid: data.caseid ? data.caseid : data.intakenumber,
                    objecttype: data.caseid ? 'case' : 'intake'
                };
                this._commonHttpService.getArrayList(
                  {
                    where: request,
                    method: 'get',
                    nolimit: true
                  },
                  'collateral/list?filter'
                ).subscribe((collateralData: any) => {
                  if (collateralData && collateralData.length && collateralData[0].getcollateraldetails && collateralData[0].getcollateraldetails.length) {
                    const collateralDetailList = collateralData[0].getcollateraldetails.map((ele: any) => {
                        ele['personid'] = ele.collateralid;
                        return ele;
                    });
                    const participantList = [...personList,...collateralDetailList]; 
                    this.involvedParticipants = participantList;      
                  } else {
                    this.involvedParticipants = [...personList];  
                  }
                  this.getPageList();
                });
            });
    }

    fillPlacementInfo(value: any) {
            const placementInfo = this.placeinforDropdown.find(item => item.placementid === value);
            let type;
            if (placementInfo) {
                if (placementInfo.placementstructuredesc) {
                    type = placementInfo.placementstructuredesc;
                } else {
                    if (placementInfo.livingarrangementtype) {
                        type = placementInfo.livingarrangementtype;
                    } else {
                        type = placementInfo.placementtype;
                    }
                }
            }
            const obj = {
            placementtypename : type,
            placementname: placementInfo?.primarycaregiver ? placementInfo?.primarycaregiver : placementInfo?.livingarrangementtype,
            startdate: placementInfo?.startdate,
            starttime: placementInfo?.starttime,
            enddate: placementInfo?.enddate,
            endtime: placementInfo?.endtime,
            placementid: placementInfo?.placementid
            }
            if (placementInfo?.isCpaHome) {
                const cpaHome = placementInfo.cpahomerevision.find((x: { placement_cpa_home_id: any; }) => x.placement_cpa_home_id === placementInfo.placementid)
                obj['placementname'] = placementInfo.placementname;
                obj['startdate'] = cpaHome.entry_dt;
                obj['starttime'] = cpaHome.entry_tm;
                obj['enddate'] = cpaHome.exit_dt;
                obj['endtime'] = cpaHome.exit_tm;
            }
            this.placementDetails = obj;
      }

    getPlacementDropdown() {
        const members = this.fimForm.get('meetingrecordingactor')?.value || [];
        const currentSelDate = moment(this.fimForm.get('meetingdate')?.value);

        const dropdownList =
            this.totalPlaceinfo
                .filter(user => members.indexOf(user.personid) >= 0)
                .reduce((acc, item) => ([
                    ...acc,
                    ...(item.placements || [])
                ]), [])
        // Filter the data based on the condition
        const filteredData = this.returnDropdownListFilteredDataFn(dropdownList, currentSelDate);
        const validPlacementList: any[] = [];

        this.handleFilteredDataAccordingToPlacementtypekeyFn(filteredData, validPlacementList, currentSelDate);
          
          if (this.fimTypeCheck()) {
            this.isplaement = true;
            this.fimForm.get('placementid')?.setValidators([Validators.required]);
            this.fimForm.get('placementid')?.updateValueAndValidity();
        } else {
            this.isplaement = false;
            this.fimForm.get('placementid')?.setValidators(null);
            this.fimForm.get('placementid')?.updateValueAndValidity();
        }
          this.placementDetails = null;
          this.placeinforDropdown = validPlacementList;
          let placeDetail = validPlacementList.find((pl) => pl.placementid === this.fimForm.value.placementid);
          if (!placeDetail) {
            let currentPlacementid: any = null;
            validPlacementList.forEach((vpl) => {
                if (currentPlacementid === null &&  vpl.placementrevision &&  vpl.placementrevision.length > 0) {
                 let revision = vpl.placementrevision.find((rpl: { placementid: any; }) => rpl.placementid === this.fimForm.value.placementid);
                 if (revision) {
                    currentPlacementid = vpl.placementid;
                    this.fimForm.patchValue({
                        placementid : vpl.placementid
                    });
                 }
                }
            });
          }
          const details = (this.placeinforDropdown || []).find(x => x.placementid === this.placementDetails?.placementid)
          this.placementDetails = details;
    }

    private fimTypeCheck(){
        return this.fimForm.get('fimtype')?.value &&
        (this.fimForm.get('fimtype')?.value.includes(this.placementFIM_old)
        || this.fimForm.get('fimtype')?.value.includes(this.placementFIM_new));
    }
    // Assosiated to getPlacementDropdown method
    private handleFilteredDataAccordingToPlacementtypekeyFn(filteredData: any, validPlacementList: any[], currentSelDate: moment.Moment) {
        filteredData.map((element: any) => {
            if (element.placementtypekey === 'PRPL') {
                this.handleIfPRPLfn(element, validPlacementList, currentSelDate);
            } else {
                element.placementtype = 'Living Arrangement';
                element.placementname = element.primarycaregiver ? element.primarycaregiver : element.livingarrangementtype;
            }
            if (element.placementname !== null) {
                const duplicate = validPlacementList.find(x => x.placementid === element.placementid);
                if (!duplicate && element.placementname) {
                    validPlacementList.push(element);
                }
            }
        });
    }
    // Assosiated to getPlacementDropdown method
    private handleIfPRPLfn(element: any, validPlacementList: any[], currentSelDate: moment.Moment) {
        element.placementtype = 'Provider Placement';
        if (element.cpahomerevision.length > 0) {
            element.isCpaHome = true;
            element.cpahomerevision.forEach((item: any) => {
                if (item.providername !== null && item.providername !== undefined) {
                    this.handleIfProviderNameIsNotUndefinedFn(validPlacementList, item, element, currentSelDate);
                }
            });
        } else {
            element.placementname = (element.providerdetails) ? element.providerdetails.providername : null;
        }
    }
    // Assosiated to getPlacementDropdown method
    private handleIfProviderNameIsNotUndefinedFn(validPlacementList: any[], item: any, element: any, currentSelDate: moment.Moment) {
        if (!validPlacementList.some(x => x.placementname === item.providername && (this.viewForm === true && x.placementid === item.placement_uuid))) {
            const filterElement = { ...element };
            filterElement.placementname = item.providername;
            filterElement.placementid = item.placement_cpa_home_id;
            filterElement.startdate = item.entry_dt;
            filterElement.enddate = item.exit_dt;

            if ((currentSelDate.diff(moment(item.entry_dt), 'days') >= 0 && currentSelDate.diff(moment(item.entry_dt), 'days') <= 45
                || currentSelDate.diff(moment(item.exit_dt), 'days') >= 0 && currentSelDate.diff(moment(item.exit_dt), 'days') <= 45)
                || (!item.exit_dt && currentSelDate.diff(moment(item.entry_dt), 'days') >= 0)
                || ((item.entry_dt && item.exit_dt) && currentSelDate.diff(item.entry_dt, 'days') >= 0 && currentSelDate.diff(item.exit_dt, 'days') <= 45)) {
                validPlacementList.push(filterElement);
            }
        }
    }

    // Assosiated to getPlacementDropdown method
    private returnDropdownListFilteredDataFn(dropdownList: any, currentSelDate: moment.Moment) {
        return dropdownList.filter((item: any) => {
            const startDate = moment(item.startdate || item.livingstartdate);
            const endDate = moment(item.enddate || item.livingenddate);
            return this.validateStatusAndDateFn(item, currentSelDate, startDate, endDate);
        });
    }
    // Assosiated to getPlacementDropdown method
    private validateStatusAndDateFn(item: any, currentSelDate: moment.Moment, startDate: moment.Moment, endDate: moment.Moment) {
        return (item.isvoided === 0 || item.isvoided === null)
            &&
            (((currentSelDate.diff(startDate, 'days') >= 0) && item?.routingstatus === 'Approved' && !(item?.enddate || item?.livingenddate))
                || (currentSelDate.diff(startDate, 'days') >= 0 && currentSelDate.diff(startDate, 'days') <= 45 && item?.routingstatus === 'Approved')
                || (currentSelDate.diff(endDate, 'days') >= 0 && currentSelDate.diff(endDate, 'days') <= 45 && item?.routingstatus === 'Approved')
                || ((startDate && endDate) && currentSelDate.diff(startDate, 'days') >= 0 && currentSelDate.diff(endDate, 'days') <= 45 && item?.routingstatus === 'Approved')
                || ((item?.placementrevision && item?.placementrevision?.some((e: { status: string; approvedby: null; }) => e.status === 'Approved' && e.approvedby !== null)) && (currentSelDate.diff(startDate, 'days') >= 0 && currentSelDate.diff(startDate, 'days') <= 45) || (currentSelDate.diff(endDate, 'days') >= 0 && currentSelDate.diff(endDate, 'days') <= 45)));
    }

    getPlacementInfoList() {
        this.gethearingdetails()
        const placementLen = this.totalPlaceinfo.length;

        if( this.fimForm.get('meetingdate')?.value) {
            this._commonHttpService
                .getPagedArrayList(
                    new PaginationRequest({
                    page: 1,
                    limit: 10,
                    method: 'get',
                    where: { servicecaseid: this.id },
                    }),
                    'placement/getplacementbyservicecase?filter'
                ).subscribe((result: any) => {
                    this.totalPlaceinfo = result.data.filter((x: any) => x.placements.length);
                    this.getPlacementDropdown();
                });
        } else {
            placementLen && this.getPlacementDropdown();
        }
    }

    private getFimDropDown() {
        const source = forkJoin([
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Fim.MeetingTypesUrl),
            this._commonHttpService.getArrayList({ method: 'get' }, CaseWorkerUrlConfig.EndPoint.DSDSAction.Fim.FamilyMeetingTypesUrl + '?filter'),
            this._commonHttpService.getArrayList(
                {
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Fim.ParticipantTypesUrl + '?filter'
            )
        ]).pipe(
            map((result: any) => {
                return {
                    meetingType: result[0].map(
                        (res: any) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.meetingtypekey
                            })
                    ),
                    familyMeeting: result[1],
                    InformalSupport: this.filterUsingKey(result, 'IS'),
                    LdssStaff: this.filterUsingKey(result, 'LDSS'),
                    SchoolSystem: this.filterUsingKey(result, 'SS')
                };
            }),
            share(),);
        this.meetingTypesDropdown$ = source.pipe(pluck('meetingType'));
        this.familyMeetingTypesDropdown$ = source.pipe(pluck('familyMeeting'));
        this.informalSupportDropdown$ = source.pipe(pluck('InformalSupport'));
        this.ldssStaffDropdown$ = source.pipe(pluck('LdssStaff'));
        this.schoolSystemDropdown$ = source.pipe(pluck('SchoolSystem'));
        this.familyMeetingTypesDropdown$.subscribe((res: any) => {
            res.forEach((item: any) => {
                item.additionalProperty = false;
            });
            this.familyMeetingTypesDropdown = res;
        });

        //Consolidating all the different participant type key values in a single dropdown instead of iterating over in html
        this.allParticipantTypeDropdown$ = combineLatest([ 
            this.informalSupportDropdown$, 
            this.schoolSystemDropdown$,
            this.ldssStaffDropdown$ 
            ]).pipe( 
                map(([informalSupport, schoolSystem, ldssStaff]: any) => {
                    const allOptions = [ 
                        ...informalSupport, 
                        ...schoolSystem, 
                        ...ldssStaff,
                        //These 4 other values were already added in UI so for now just concatanating those as well 
                        //ideally should move them to the database with a new reference type key and fetch accordingly
                        { value: 'involvedperson', text: 'Involved Persons' }, 
                        { value: 'resourceparent', text: 'Resource Parent' }, 
                        { value: 'schoolstaff', text: 'School Staff' }, 
                        { value: 'kinshipcaregiver', text: 'Kinship Caregiver' }
                    ];
                
                    //Sorting the values for displaying in the dropbox
                    return allOptions.sort( (a,b) => a.text.localeCompare(b.text) );
                })
            );
    }

    //Mapping the participant type keys to corresponding text for display
    participantTypeKeyMap: Record<string, string> = { 
        IS: 'Informal Support', 
        LDSS: 'LDSS Staff', 
        SS: 'School System' 
    }; 

    //Ideally we should avoid this scenario, but there are already existing 'Administrator' values in
    //both School System and LDSS Staff reference type, so adding that key with '( )' in UI for clarity
    isParticipantTypeAdministrator(description: string, key: string) { 
        return description === 'Administrator' && this.participantTypeKeyMap[key] 
                    ? ` (${this.participantTypeKeyMap[key]})` : '';
     }

    filterUsingKey (result: any, key: any) {
        return result[2].filter((final: any) => final.participanttypekey === key)[0].participantsubtype.map(
            (res: any) =>
                new DropdownModel({
                    // text: res.typedescription,
                    // text: res.typedescription + ` (${this.participantTypeKeyMap[res.participanttypekey]})`,
                    text: res.typedescription + this.isParticipantTypeAdministrator(res.typedescription, res.participanttypekey),
                    value: res.participanttypekey + '~' + res.participantsubtypekey + '~' + res.typedescription
                }));
    }

    pageChanged(pagenumber: any) {
        this.getPageList(pagenumber.page);
    }

    private getPageList(pagenumber = 1) {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        if (this._session.getItem('ISADOPTION')) {
            this.isAdoptionCase = true;
        }
        if(!this.isAdoptionCase && this._session.getItem('CASE_TYPE') && this._session.getItem('CASE_TYPE') === 'ADOPTION'){
            this.isAdoptionCase = true;
        }
        const obj: any = {};
        if (this.isServiceCase) {
            obj['objectid'] = this.id;
            obj['objecttype'] = 'servicecase';
        } else if (this.isAdoptionCase){
            obj['objectid'] = this.id;
            obj['objecttype'] = 'adoptioncase';
        } 
            obj['intakeserviceid'] = this.id;
        this.fimList$ = this._commonHttpService
            .getArrayList(
                {
                    where: { ...obj, isExpungementSuperUser: isExpungementSuperUser,'iscaseexpunged':iscaseexpunged},
                    method: 'get',
                    page: pagenumber,
                    limit: 10
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Fim.FimListUrl + '?filter'
            ).pipe(
            map((res: any) => {
                this.disableSubmit = false;
                this.totalCount = (res?.data && res.data.length > 0 && res?.data[0]?.totalcount) ? res?.data[0]?.totalcount : 0 ;
                const returnresp = res.data;
                if (this.retrymeetingid) {
                   this.meetingListCheck = res.data.find((item: any) => item.meetingrecordingid === this.retrymeetingid);
                }
                if (this.meetingListCheck && this.retrymeetingid) {
                    this.editFim(this.meetingListCheck);
                    this.retrymeetingid = null;
                }
                return returnresp;
                
            }));
    }

    getRequestParam() {
        let inputRequest;
        const caseID = this.getCaseUuid();
        this.source = this.getSource();
        if (this.isServiceCaseData()) {
          inputRequest = {
            objectid: caseID,
            objecttypekey : 'servicecase',
            servicecaseid: caseID
          };
        } else if (this.isIntakeMode()) {
          inputRequest = {
            intakenumber: this.getIntakeNumber()
          };

        } else {
          inputRequest = {
            intakeserviceid: caseID
          };
        }

        return inputRequest;
      }

      getCaseUuid() {
        const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        let caseUUID = null;
        if (caseInfo) {
          caseUUID = caseInfo.intakeserviceid;
          this.caseNumber = caseInfo.da_number;
          if (this.isServiceCaseData()) {
            this.caseType = 'Service Case';
          } else {
            this.caseType = caseInfo.da_subtype ;
          }
        }
        if (caseID) {
          return caseID;
        }
        return caseUUID;
      }

      isServiceCaseData() {
        return this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
      }

      isIntakeMode() {
        return this.getIntakeNumber() ? true : false;
      }

      getRequestParamCollateral() {
        let inputRequest;
        const caseID = this.getCaseUuid();
        if (this.isServiceCaseData()) {
            inputRequest = {
                caseid: caseID,
                objecttype: 'servicecase',
                intakenumber: null,
            };
        } else if (this.isIntakeMode()) {
            inputRequest = {
                intakenumber: this.getIntakeNumber(),
                objecttype: 'intake',
                caseid: null
            };
      
        } else {
            inputRequest = {
              caseid: caseID,
              objecttype: 'case',
              intakenumber: null,
            };
        }
        return inputRequest;
    }

      getIntakeNumber() {
        const intakeStore = this._dataStoreService.getObj('intake');
        if (intakeStore && intakeStore.number) {
          return intakeStore.number;
        } else {
          return null;
        }
      }
      getSource() {

        if (this.isServiceCaseData()) {
         return AppConstants.CASE_TYPE.SERVICE_CASE;
        } else if (this.isIntakeMode()) {
          return AppConstants.CASE_TYPE.INTAKE;
        } else {
          return AppConstants.CASE_TYPE.CPS_CASE;
        }
        // need to add condition for adoption case
      }
      getPersonNameList(id: string | any[], list: any[],personid?: any, isView?: any) {
        const selectPersonList = list.filter((f: any) => id?.includes(f.personid || f.collateralid));
        this.selectPersonListforhearing= selectPersonList.filter((t: any)=>t?.userroles?.includes('Child'));
        const exselectPersonListforhearing=this.fimForm.controls.hearingdetails.value.map((t: { clientid: any; })=>t.clientid);
        const newaddPersonListforhearing= this.selectPersonListforhearing.filter(t=> !exselectPersonListforhearing.includes(t.personid || t.collateralid) )
       if(exselectPersonListforhearing.length>this.selectPersonListforhearing.length){
        const unchekedchild =this.fimForm.controls.hearingdetails.value.filter((t: { clientid: any; })=>(this.selectPersonListforhearing.map(f=>f.personid || f.collateralid).includes(t.clientid)));
        this.fimForm.controls.hearingdetails.reset();
        this.fimForm.setControl('hearingdetails', this._formBuilder.array([]));
        const control1 = <FormArray>this.fimForm.controls['hearingdetails'];
        unchekedchild.forEach((element: any) => {
            control1.push(this._formBuilder.group(element));
        });
    }        
        const control = <FormArray>this.fimForm.controls['hearingdetails'];
        newaddPersonListforhearing.forEach(val => {
            control.push(this._formBuilder.group({'clientid':val.personid || val.collateralid,'hearingdetails':null}));
        });
        this.selectPersonNameList = selectPersonList.map(item => item.fullname);
       this.getPlacementInfoList();
      }

      get meetingParticipantsControlFn() {
        return (this.fimForm.get('meetingparticipants') as FormArray).controls;
      }

      get hearingDetailsControlFn() {
        return (this.fimForm.get('hearingdetails') as FormArray).controls;
      }

      getTooltipFn(index: number): any {
        const hearingDetails = this.fimForm.get('hearingdetails') as FormArray;
        const clientid = hearingDetails.at(index)?.get('clientid')?.value;
        const details = hearingDetails.at(index)?.get('hearingdetails')?.value;
        return this.hearingdetailsTooltip(clientid, details) ?? '';
      }

      getClientIdValueFn(index: number): any {
        const hearingDetails = this.fimForm.get('hearingdetails') as FormArray;
        if (hearingDetails && hearingDetails.at(index)) {
            return hearingDetails.at(index)?.get('clientid')?.value;
        }
        return null;
    }
    
      
      
}