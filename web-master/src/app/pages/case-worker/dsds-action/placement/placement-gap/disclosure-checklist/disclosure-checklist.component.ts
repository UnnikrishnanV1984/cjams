import { Component, OnInit, Injector } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import jsPDF from 'jspdf';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import { PaginationRequest, PaginationInfo } from '../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { CommonHttpService, DataStoreService, SessionStorageService } from '../../../../../../@core/services';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { AuthService } from '../../../../../../@core/services/auth.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { DisclosureCheckList, RouteToSupervisor } from '../../_entities/placement.model';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { PlacementGapService } from '../placement-gap.service';
import { Html2CanvasService } from '../../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';
declare let google: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'disclosure-checklist',
    templateUrl: './disclosure-checklist.component.html',
    styleUrls: ['./disclosure-checklist.component.scss'],
    standalone: false
})
export class DisclosureChecklistComponent implements OnInit {

    placement: any;
    id!: string;
    daNumber!: string;
    disclosureCheklistForm!: FormGroup;
    approvalStatusForm!: FormGroup;
    providerSearchForm!: FormGroup;
    roleId!: AppUser;
    disClosure: any;
    disClosuseCheckList: DisclosureCheckList = new DisclosureCheckList();
    isSupervisor = false;
    isExistRecord = false;
    gapDisclosureExist=false;
    disableBtn = false;
    mandatoryField=false;
    submitStatus!: RouteToSupervisor;
    isApproved = false;
    isEnableComments = false;
    isInitialized = false;
    isViewForm!: boolean;
    placementGapDisclosureId!: string;
    isSuccessorGuardianExists = false;
    currProcess!: string;
    selectedViewProvider: any;
    selectedparent: any;
    guardianOneDob: any;
    guardianTwoDob: any;
    adoptiveparent1!: string;
    parent1providerid!: string;
    parent2providerid!: string;
    store: any;
    placementStrType: any;
    adoptiveparent2!: string;
    fcpaginationInfo: PaginationInfo = new PaginationInfo();
    selectedProvider: any;
    fcProviderSearch: any;
    parent1providername!: string;
    parent2providername!: string;
    markersLocation: any[] = [];
    zoom!: number;
    defaultLat = 39.29044;
    defaultLng = -76.61233;
    paginationInfo: PaginationInfo = new PaginationInfo();
    fcTotal: any;
    childCharacteristics!: any[];
    otherLocalDeptmntType!: any[];
    bundledPlcmntServicesType!: any[];
    genderDropdownItems!: any[];
    minAge!: number;
    maxAge!: number;
    gender!: string;
    lat = 51.678418;
    lng = 7.809007;
    showMap!: boolean;
    child: any;
    maxDate = new Date();
    showTitle4eFields = false;
    allowsubmit!: boolean;
    gapAlertMessage!: string;
    guardianonerelation!: string;
    guardiantworelation!: string;
    providerSearch!: any[];
    relationShipToRADropdownItems!: any[];
    gapplacementpopupid = '#gap-placement';
    gapalertmsg = 'Please complete Gap Agreement';
    caseworkerpageurl = '/pages/case-worker/';
    searchproviderpopupid = '#searchProvider';
    mappopupid = '#map-popup';

    private _authService: AuthService;
    private _httpService: CommonHttpService;
    private _formBuilder: FormBuilder;
    private route: ActivatedRoute;
    private _router: Router;
    private _dataStoreService: DataStoreService;
    private _alertService: AlertService;
    private _session: SessionStorageService;
    private _placementService: PlacementGapService;

    constructor(private injector : Injector,private html2canvas:Html2CanvasService){
        this._authService = injector.get<AuthService>(AuthService);
        this._httpService = injector.get<CommonHttpService>(CommonHttpService);
        this._formBuilder = injector.get<FormBuilder>(FormBuilder);
        this.route = injector.get<ActivatedRoute>(ActivatedRoute);
        this._router = injector.get<Router>(Router);
        this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
        this._alertService = injector.get<AlertService>(AlertService);
        this._session = injector.get<SessionStorageService>(SessionStorageService);
        this._placementService = injector.get<PlacementGapService>(PlacementGapService);
        this.store = this._dataStoreService.getCurrentStore();
    }

    ngOnInit() {
        this._placementService.checkDataAvailability();
        this.initFormGroup();
        this.getRelationList();
        this.currProcess = 'search';
        this.roleId = this._authService.getCurrentUser();
        if (this.roleId.role.name === 'apcs') {
            this.isSupervisor = true;
            this.disclosureCheklistForm.disable();
            this.placementGapDisclosureId = this._session.getItem('Placement-Gap-Disclosure-Id');
            this._session.setItem('Placement-Gap-Disclosure-Id', null);
            this.getPageforSupervisor();
        }
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.child = this._dataStoreService.getData('placed_child');
        this.disclosureCheklistForm.patchValue({ servicecaseid: this.id });

        this.disclosureCheklistForm.patchValue({ enteredby: this.roleId.user.userprofile.displayname});
        this.isInitialized = true;

        if (this.isInitialized && this._dataStoreService.getData('placement_child')) {
            this.placement = this._dataStoreService.getData('placement_child');
            if (this.placement) {
                this.getDisclosureCheckList();
                this.getPage();

                if (this.placement.providerdetails) {
                    this.disclosureCheklistForm.patchValue({
                        guardianoneproviderid: this.placement.providerdetails.provider_id
                    });
                }

                if (this.placement.permanencyplanid) {
                    this.disclosureCheklistForm.patchValue({
                        permanencyplanid: this.placement.permanencyplanid
                    });
                }



                this.isInitialized = false;
            }
        }

        if (this.roleId.role.name === 'apcs') {
            this.getPageforSupervisor();
        }
    }


    generatePDF_html() {
      const doc = new jsPDF('p', 'mm', 'a4');
      const formIdData: any = document.getElementById('disclosure-Cheklist-Form');
      this.html2canvas.capture(formIdData).then(function(
          canvas
      ) {
          const imgData = canvas.toDataURL('image/png');
          const pageHeight = 300;
          const imgWidth = 205;
          const imgHeight = (canvas.height * imgWidth) / canvas.width;
          let heightLeft = imgHeight;
          let position = 0;
  
          doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
          heightLeft -= pageHeight;
  
          while (heightLeft >= 0) {
              position = heightLeft - imgHeight;
              doc.addPage();
              doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
              heightLeft -= pageHeight;
          }
  
          doc.save('GAP-disclosure-checklist.pdf');
      });
    }
  
    generatePDF() { 
      const req = {
          ...this.store, 
      };

      const payload = {
          method: 'post',
          count: -1,
          page: 1,
          limit: 20,
          where: req,
          documntkey: [
                  'gapagreementdc'
              ],
          strongattachmentsecondaryguardian : this.disclosureCheklistForm.value.strongattachmentsecondaryguardian , 
          consultationguardianshiparrangement: this.disclosureCheklistForm.value.consultationguardianshiparrangement,
          strongattachmentprimaryguardian: this.disclosureCheklistForm.value.strongattachmentprimaryguardian, 
        };

      this._httpService.create(payload, 'gapapplication/getgappdftoprint').subscribe(
          response => {
            if (response) {
              setTimeout(() => {
                  window.open(response.data.documentpath);
              }, 2000);
            } else {
                this._alertService.error('Error in processing, please try again later.');
            }
      });
 
  }

    routingUpdate() {
        const comment = 'Guardianship Submitted for review';
        this.submitStatus = Object.assign({
            objectid: this.disClosuseCheckList ? this.disClosuseCheckList.gapdisclosureid : '',
            eventcode: 'GADR',
            status: this.approvalStatusForm.value.routingstatus,
            comments: this.approvalStatusForm.value.comments,
            notifymsg: comment,
            routeddescription: comment,
            servicecaseid: this.id
        });
        if (!this.disClosuseCheckList.gapdisclosureid) {
            return this._alertService.error('Please select child');
        } else if (this.roleId.role.name === 'apcs' && this.approvalStatusForm.value.routingstatus === 'Review') {
            return this._alertService.error('Please select review status!');
        } else {
            this._httpService.create(this.submitStatus, 'routing/routingupdate').subscribe(
                _res => {
                    this._alertService.success('Disclosure Checklist ' + this.submitStatus.status + ' Successfully!');
                    this.isApproved = true;
                    this.getPage();
                }
            );
        }
    }

    getPageforSupervisor() {
      let permanencyplanid = '';
      permanencyplanid = this._session.getItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
      const storeplanid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
      permanencyplanid = (permanencyplanid) ? permanencyplanid : storeplanid;

        this._httpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 10,
                    where: {
                        objectid: (this?.placementGapDisclosureId !== 'null') ? (this?.placementGapDisclosureId) : null,
                        permanencyplanid: (this?.placementGapDisclosureId !== 'null') ? null : permanencyplanid,
                        objecttype: (this?.placementGapDisclosureId !== 'null') ? 'disclosure' : null
                    },
                    method: 'get'
                }),
                'gapdisclosure/getguardianship' + '?filter'
            )
            .subscribe(
                (checkList) => {
                    if (checkList.data && checkList.data.length) {
                      (<any>$(this.gapplacementpopupid)).modal('hide');
                        this.disClosure = checkList.data[0];
                        const data = checkList.data[0];
                        this.patchDisclosureCheckList(this.disClosure);
                        this.patchGuardians(data.guardianoneproviderid);
                        if (!this.placement) {
                            this.disclosureCheklistForm.patchValue({
                                guardianoneproviderid: data.guardianoneproviderid
                            });
                        }
                    } else if (this.roleId.role.name === 'apcs' && checkList.data && checkList.data.length === 0) {
                        this.isApproved = true;
                    }
                }
            );
    }
    getPage() {
      let getpermanencyplanid = null;
      getpermanencyplanid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);

      this._httpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        permanencyplanid: (this.placement && this.placement.permanencyplanid) ? this.placement.permanencyplanid : getpermanencyplanid
                    },
                    method: 'get'
                }),
                'gapdisclosure/getguardianship' + '?filter'
            )
            .subscribe(
                (checkList) => {
                  // virginia.moore@maryland.gov --3294121
                    if (checkList.data && checkList.data.length) {
                      (<any>$(this.gapplacementpopupid)).modal('hide');
                      const gapData = checkList.data[0];
                      this.guardiantworelation = gapData.guardiantworelation;
                      this.guardianonerelation = gapData.guardianonerelation;
                      this.handleByCheckingRoutingstatusFn(gapData, checkList);
                    } else if (this.roleId.role.name === 'apcs' && checkList.data.length === 0) {
                        this.isApproved = true;
                    } else if (this.roleId.role.name !== 'apcs' && checkList.data.length === 0) {
                        this._alertService.warn('Please fill disclosure checklist');
                        this.isApproved = true;
                    } else {
                        this.gapAlertMessage = 'Please complete Application';
                        (<any>$(this.gapplacementpopupid)).modal('show');
                    }
                }
            );
    }

    // Assosiated to getPage method
  private handleByCheckingRoutingstatusFn(gapData: any, checkList: any) {
    const gapapplication = (Array.isArray(gapData.gapapplication)) ? gapData.gapapplication[0] : null;
    if (gapapplication && gapapplication.routingstatus === 'Approved') {
      this.disClosure = checkList.data[0];
      const data = checkList.data[0];
      this.getAgreement(data.gapid);
      this.patchGuardians(data.guardianoneproviderid);
      this.disclosureCheklistForm.patchValue({
        gapid: data.gapid,
        successorguardianname: data.successorguardianname
      });
      this.patchDisclosureCheckList(this.disClosure);
      this._placementService.setGapId(data.gapid);
    } else {
      this.gapAlertMessage = 'Please complete Application';
      (<any>$(this.gapplacementpopupid)).modal('show');
    }
  }

    private getAgreement(gapId: any) {
      this._httpService
          .getArrayList(
              {
                  method: 'get',
                  page: 1,
                  limit: 10,
                  where: { gapid:  gapId }
              },
              'gapagreement/list?filter'
          )
          .subscribe(res => {
              if((!res || res?.length===0) || (res[0]?.routingstatusnew !== 'Approved') || (res[0]?.routingstatus !== 'Approved')) {
                this.gapAlertMessage = this.gapalertmsg;
                (<any>$(this.gapplacementpopupid)).modal('show');
              }
          });
  }
  

    navigateTo() {
        (<any>$(this.gapplacementpopupid)).modal('hide');
     if (this.disClosure) {
          const gapdisclosure = this.disClosure.gapapplication;
           (<any>$(this.gapplacementpopupid)).modal('hide');
           if (!gapdisclosure || (gapdisclosure[0] && gapdisclosure[0].routingstatus !== 'Approved')) {
               const currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/application';
               this._router.navigate([currentUrl]);
           } else {
            const currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/agreement';
            this._router.navigate([currentUrl]);
          }
       } else {
           const currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/agreement';
           this._router.navigate([currentUrl]);
       }
    }



  patchDisclosureCheckList(model: any) {
    this.disclosureCheklistForm.patchValue({ disclosuredate: new Date() });

    this.handleIfGapdisclosureFn(model);
    const provider = this.handlePlacementFn();

    const disData = this.disclosureCheklistForm.getRawValue();

    if (this.disClosuseCheckList && this.disClosuseCheckList.disclosuredate) {
      this.disclosureCheklistForm.patchValue({
        disclosuredate: this.disClosuseCheckList.disclosuredate
      })
    } else {
      this.disclosureCheklistForm.patchValue({
        disclosuredate: disData.disclosuredate,
      })
    }
    if (model.gapapplication[0].planmeetingdate) {
      this.disclosureCheklistForm.patchValue({
        dateofplanning: model.gapapplication[0].planmeetingdate,
      })
    }
    if (model.gapapplication[0].planmeetingdate && !this.disClosuseCheckList.orientationmeetingdate) {
      this.disclosureCheklistForm.patchValue({
        orientationmeetingdate: model.gapapplication[0].planmeetingdate,
      })
    } else if (this.disClosuseCheckList && this.disClosuseCheckList.orientationmeetingdate) {
      this.disclosureCheklistForm.patchValue({
        orientationmeetingdate: this.disClosuseCheckList.orientationmeetingdate,
      })
    }

    this.guardianTwoDob = model.two_dob_dt;
    this.guardianOneDob = model.one_dob_dt;
    this.disclosureCheklistForm.patchValue({
      ...this.handleDisclosureCheklistFormCond1Fn(model, provider, disData),
      ...this.handleDisclosureCheklistFormCond2Fn(),
      ...this.handleDisclosureCheklistFormCond3Fn(model),
    });

    this.decideSecondaryGuardianInfo();
  }
  // Assosiated with patchDisclosureCheckList method
  private handlePlacementFn() {
    const placement = this._dataStoreService.getData('placement_child');
    let provider = { guardianoneid: null, guardianoneproviderid: null };
    if (placement && placement.providerdetails) {
      provider = {
        guardianoneid: placement.providerdetails.providername,
        guardianoneproviderid: placement.providerdetails.provider_id
      };
    }
    return provider;
  }
  // Assosiated with patchDisclosureCheckList method
  private handleIfGapdisclosureFn(model: any) {
    if (model.gapdisclosure && model.gapdisclosure.length > 0) {
      this.disClosuseCheckList = model.gapdisclosure[0];
      this.approvalStatusForm.patchValue({
        routingstatus: this.disClosuseCheckList.routingstatus ? this.disClosuseCheckList.routingstatus : '',
        comments: this.disClosuseCheckList.comments ? this.disClosuseCheckList.comments : ''
      });
      if (this.approvalStatusForm.value.routingstatus === 'Approved' || this.approvalStatusForm.value.routingstatus === 'Rejected') {
        this.isApproved = true;
        this.rejectComments(this.approvalStatusForm.value.routingstatus);
      }
      if (this.approvalStatusForm.value.routingstatus === 'Approved' || this.approvalStatusForm.value.routingstatus === 'Review') {
        this.isExistRecord = true;
        this.disclosureCheklistForm.disable();
      }
    } else {
      this.disClosuseCheckList = Object.assign({});
      this.isExistRecord = false;
    }
  }

  // Assosiated with patchDisclosureCheckList method
  private handleDisclosureCheklistFormCond3Fn(model: any) {
    return {
      isconsultationchildage: this.disClosuseCheckList ? this.disClosuseCheckList.isconsultationchildage : null,
      isguardianattach: this.disClosuseCheckList ? this.disClosuseCheckList.isguardianattach : null,
      isguardiantwoattach: this.disClosuseCheckList ? this.disClosuseCheckList.isguardiantwoattach : null,

      successionaddendumdate: model.successionaddendumdate,
      cofinaldate: model.cofinaldate,
      successorguardianname: model.successorguardianname,
      empprogramstartdate: model.empprogramstartdate,
      empprogramname: model.empprogramname,
      fosterhomeapprover: model.fosterhomeapprover,
      primaryrelationshipkey: this.getRelation(model.primaryrelationshipkey),
      secondaryrelationshipkey: this.getRelation(model.secondaryrelationshipkey)
    };
  }
  // Assosiated with patchDisclosureCheckList method
  private handleDisclosureCheklistFormCond2Fn() {
    return {
      isothergapfinsupport: this.disClosuseCheckList ? this.disClosuseCheckList.isothergapfinsupport : null,
      iscgattendedorientation: this.disClosuseCheckList ? this.disClosuseCheckList.iscgattendedorientation : null,
      isrequirementdiscussed: this.disClosuseCheckList ? this.disClosuseCheckList.isrequirementdiscussed : null,
      iscgparticipategap: this.disClosuseCheckList ? this.disClosuseCheckList.iscgparticipategap : null,
      iscgenteredagreement: this.disClosuseCheckList ? this.disClosuseCheckList.iscgenteredagreement : null,
      iscgcompleteauthorization: this.disClosuseCheckList ? this.disClosuseCheckList.iscgcompleteauthorization : null,
      iscgaftercareservice: this.disClosuseCheckList ? this.disClosuseCheckList.iscgaftercareservice : '',
      isneedadditionalservices: this.disClosuseCheckList ? this.disClosuseCheckList.isneedadditionalservices : null,
      iscgcompleteannualreview: this.disClosuseCheckList ? this.disClosuseCheckList.iscgcompleteannualreview : null,
      issuspendedfromguardian: this.disClosuseCheckList ? this.disClosuseCheckList.issuspendedfromguardian : null,

      consultationguardianshiparrangement: this.disClosuseCheckList ? this.disClosuseCheckList.isconsultationchildage : null,
      strongattachmentprimaryguardian: this.disClosuseCheckList ? this.disClosuseCheckList.isguardianattach : null,
      strongattachmentsecondaryguardian: this.disClosuseCheckList ? this.disClosuseCheckList.isguardiantwoattach : null,

      issuccessorguardianexists: this.disClosuseCheckList ? this.disClosuseCheckList.issuccessorguardianexists : null
    };
  }
  // Assosiated with patchDisclosureCheckList method
  private handleDisclosureCheklistFormCond1Fn(model: any, provider: any, disData: any) {
    return {
      guardianoneproviderid: model.guardianoneproviderid ? model.guardianoneproviderid : provider.guardianoneproviderid,
      guardianonename: (model.guardianoneprovidername) ? model.guardianoneprovidername : '-',
      guardiantwoname: (model.guardiantwoprovidername) ? model.guardiantwoprovidername : '-',
      guardianoneid: (model.guardianoneid) ? model.guardianoneid : provider.guardianoneid,
      guardiantwoid: (model.guardiantwoid) ? model.guardiantwoid : '',
      enteredby: (model.enteredby ? model.enteredby : model.applicationenteredby),
      dateofplanning: model.gapdisclosure?.[0]?.dateofplanning ?? null,
      gapdisclosureid: this.disClosuseCheckList ? this.disClosuseCheckList.gapdisclosureid : null,
      ischildplacedsixmonths: this.disClosuseCheckList.ischildplacedsixmonths ? this.disClosuseCheckList.ischildplacedsixmonths : disData.ischildplacedsixmonths,
      isproviderapprovedgap: this.disClosuseCheckList.isproviderapprovedgap ? this.disClosuseCheckList.isproviderapprovedgap : disData.isproviderapprovedgap,
      iscourthearingcustody: this.disClosuseCheckList.iscourthearingcustody ? this.disClosuseCheckList.iscourthearingcustody : disData.iscourthearingcustody,
      isreunificationremoved: this.disClosuseCheckList.isreunificationremoved ? this.disClosuseCheckList.isreunificationremoved : disData.isreunificationremoved,
      isadoptionremoved: this.disClosuseCheckList.isadoptionremoved ? this.disClosuseCheckList.isadoptionremoved : disData.isadoptionremoved,
      iscgprovidesafe: this.disClosuseCheckList ? this.disClosuseCheckList.iscgprovidesafe : null
    };
  }

    rejectComments(status: any) {
        if (status === 'Rejected') {
            this.isEnableComments = true;
        } else {
            this.isEnableComments = false;
            this.approvalStatusForm.patchValue({ comments: '' });
        }
    }

    initFormGroup() {

        this.disclosureCheklistForm = this._formBuilder.group({
            servicecaseid: [null],
            gapdisclosureid: [null],
            gapid: [null],
            permanencyplanid: [null],
            guardianoneid: [null],
            guardiantwoid: [null],
            guardianonename: [null],
            guardiantwoname: [null],
            guardianoneproviderid: [null],
            guardiantwoproviderid: [null],
            disclosuredate: [{value: new Date(), disabled: true}],
            dateofplanning: [null],
            ischildplacedsixmonths: [{value: null, disabled: true}],
            isproviderapprovedgap: [{value: null, disabled: true}],
            iscourthearingcustody: [{value: null, disabled: true}],
            isreunificationremoved: [{value: null, disabled: true}],
            isadoptionremoved: [{value: null, disabled: true}],
            iscgprovidesafe: [null, Validators.required],
            isothergapfinsupport: [null, Validators.required],
            iscgattendedorientation: [null, Validators.required],
            orientationmeetingdate: [null],
            isrequirementdiscussed: [null, Validators.required],
            iscgparticipategap: [null, Validators.required],
            iscgenteredagreement: [null, Validators.required],
            iscgcompleteauthorization: [null, Validators.required],
            iscgaftercareservice: [null, Validators.required],
            isneedadditionalservices: [null, Validators.required],
            iscgcompleteannualreview: [null, Validators.required],
            issuspendedfromguardian: [null, Validators.required],
            consultationguardianshiparrangement: [null],
            strongattachmentprimaryguardian: [null],
            strongattachmentsecondaryguardian: [null],
            enteredby: [null],

            issuccessorguardianexists: [null],
            isconsultationchildage: [null],
            isguardianattach: [null],
            isguardiantwoattach: [null],

            successionaddendumdate: [null],
            cofinaldate: [null],
            successorguardianname: [null],
            empprogramstartdate: [null],
            empprogramname: [null],
            fosterhomeapprover: [null],
            primaryrelationshipkey: [null],
            secondaryrelationshipkey: [null],

        });
        this.approvalStatusForm = this._formBuilder.group({
            routingstatus: [''],
            comments: ['']
        });

        this.providerSearchForm = this._formBuilder.group({
            childcharacteristics: [null],
            bundledplacementservices: [null],
            otherLocalDeptmntTypeId: [null],
            placementstructures: [null],
            zipcode: null,
            isLocalDpt: [true],
            firstname: null,
            middlename: null,
            lastname: null,
            isgender: [false],
            isAge: [false],
            providerid: null,
            agemin: null,
            agemax: null,
            gender: null
          });
    }
    addDislosureChecklist(checklist: any) {
      this.mandatoryField=true;
      if(this.disclosureCheklistForm.status=='INVALID'){
        return;
      }
        this.disableBtn = true;
        const saveDisclose = this.conditionValidation();
        checklist.ischildplacedsixmonths = this.disclosureCheklistForm['controls'].ischildplacedsixmonths.value;
        checklist.iscourthearingcustody = this.disclosureCheklistForm['controls'].iscourthearingcustody.value;
        checklist.isproviderapprovedgap = this.disclosureCheklistForm['controls'].isproviderapprovedgap.value;
        checklist.isreunificationremoved = this.disclosureCheklistForm['controls'].isreunificationremoved.value;
        checklist.isadoptionremoved = this.disclosureCheklistForm['controls'].isadoptionremoved.value;
        if (saveDisclose) {
            const dislosureChecklistDetails = Object.assign(
                {
                    servicecaseid: this.id,
                },
                checklist
            );
            delete dislosureChecklistDetails.guardiantwo;
            delete dislosureChecklistDetails.guardianone;
            delete dislosureChecklistDetails.primaryrelationshipkey;
            delete dislosureChecklistDetails.secondaryrelationshipkey;
            this._httpService.create(dislosureChecklistDetails, 'gapdisclosure/add').subscribe(
                res => {
                    if (res === 'Guardianship Already Exist') {
                        this._alertService.error('Guardianship Already Exist');
                    } else {
                        this.isExistRecord = true;
                        this.getPage();
                        this._alertService.success('Disclosure Checklist Submitted for Supervisor Approval!');
                    }
                      if(!res.gapdisclosureid){
                      this.disableBtn = false;
                    }
                },
                _error => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    this.disableBtn = false;

                }
            );
        }
    }
    conditionValidation(): boolean {
        if (!this.placement) {
            this._alertService.warn('Please select child');
            return false;
        } else if (!this.disclosureCheklistForm.value.orientationmeetingdate && this.disclosureCheklistForm.value.iscgattendedorientation) {
            this._alertService.warn('Please fill orientation meeting date');
            return false;
        }
        return true;
    }

    patchGuardians(provider_id: any) {
      this._httpService.getArrayList(
        {
          where: { provider_id: provider_id },
          method: 'get'
        },
        'tb_provider/getproviderguardians?filter'
      ).subscribe(res => {
        if (res[0]) {
          const getproviderguardians = res[0].getadoptiveparents;
          if (getproviderguardians.length) {
             const guardiandetails = getproviderguardians[0];
             this.guardianOneDob = guardiandetails.adoptiveparent1dob ? guardiandetails.adoptiveparent1dob  : null ;
             this.guardianTwoDob = guardiandetails.adoptiveparent2dob ? guardiandetails.adoptiveparent2dob : null; 
             this.disclosureCheklistForm.patchValue(this.returnGaurdianDetailsFn(guardiandetails, provider_id));                
          }
        }
      });
    }
    // Assosiated to patchGuardians method
  private returnGaurdianDetailsFn(guardiandetails: any, provider_id: any): { [key: string]: any; } {
    return {
      guardianoneproviderid: guardiandetails.provider_id ? guardiandetails.provider_id : provider_id,
      guardianonename: guardiandetails.adoptiveparent1 ? guardiandetails.adoptiveparent1 : null,
      guardiantwoname: guardiandetails.adoptiveparent2 ? guardiandetails.adoptiveparent2 : null,
    };
  }

    getDisclosureCheckList() {
        this._httpService
            .getArrayList(
                new PaginationRequest({
                    where: {
                        servicecaseid: this.id,
                        intakeservicerequestactorid: this.placement.intakeservicerequestactorid,
                        placementtype: 'gapdisclosure'
                    },
                    method: 'get'
                }),
                'permanencyplan/permanencyplanvalidation' + '?filter'
            )
            .subscribe(
                (checkList) => {
                    const selectedPlacementChecklist = (Array.isArray(checkList) && checkList.length) ? checkList[0] : null;
                    if (selectedPlacementChecklist) {
                        this.disclosureCheklistForm.patchValue({
                            ischildplacedsixmonths: (selectedPlacementChecklist.ischildincare === 1) ? true : false,
                            iscourthearingcustody: (selectedPlacementChecklist.ischawardcustody === 1) ? true : false,
                            isproviderapprovedgap: true,
                            isreunificationremoved: true,
                            isadoptionremoved: true
                        });
                        const data = this.disclosureCheklistForm.getRawValue();
                        this.allowsubmit = (data.ischildplacedsixmonths && data.iscourthearingcustody) ? true : false;
                    }
                }
            );
    }

    decideSecondaryGuardianInfo() {
        this.isSuccessorGuardianExists = this.disclosureCheklistForm.getRawValue().issuccessorguardianexists;
    }

    openDisabilityForm() {
        this._router.navigate(['disability/' + this.child.personid + '/create'], { relativeTo: this.route });
    }

    openDisabilityList() {
        this._router.navigate(['disability/' + this.child.personid + '/list'], { relativeTo: this.route });
    }

    toggleTitle4e(data: any) {
        this.showTitle4eFields = data.checked;
    }

    getChildCharacteristics() {
        this._httpService.getArrayList(new PaginationRequest({
          where: {
            'picklist_type_id': '43'
          },
          nolimit: true,
          method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.childCharacteristicsUrl).subscribe(result => {
          this.childCharacteristics = result;
        });
      }

    getOtherLocalDeptmntType() {
        this._httpService.getArrayList(new PaginationRequest({
          where: {
            'picklist_type_id': '104'
          },
          nolimit: true,
          method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.otherLocalDeptmntTypeUrl).subscribe(result => {
          this.otherLocalDeptmntType = result;
        });
      }

      getBundledPlcmntServicesType() {
        this._httpService.getArrayList(new PaginationRequest({
          nolimit: true,
          method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.bundledPlcmntServicesTypeUrl).subscribe(result => {
          this.bundledPlcmntServicesType = result;
        });
      }

      resetproviderSearchForm() {
        this.providerSearchForm.reset();
        this.currProcess = 'search';
      }

    onSearchParent1() {
        (<any>$(this.searchproviderpopupid)).modal('show');
        this.selectedparent = 'parent1';

    }
    onSearchParent2() {
        (<any>$(this.searchproviderpopupid)).modal('show');
        this.selectedparent = 'parent2';
    }

    selectProvider() {

        if (this.selectedparent === 'parent1') {
            this.disclosureCheklistForm.patchValue({'guardianoneid': this.returnProvidernameFn() });
            this.disclosureCheklistForm.patchValue({'guardianoneproviderid': this.returnProviderIdFn() });
            this.parent1providerid = this.returnProviderIdFn() ;
            this.parent1providername = this.returnProvidernameFn();
        } else if (this.selectedparent === 'parent2') {
            this.disclosureCheklistForm.patchValue({'guardiantwoid': this.returnProvidernameFn() });
            this.disclosureCheklistForm.patchValue({'guardiantwoproviderid': this.returnProviderIdFn() });
            this.parent2providerid = this.returnProviderIdFn() ;
            this.parent2providername = this.returnProvidernameFn();
        }
        (<any>$(this.searchproviderpopupid)).modal('hide');
        this.resetproviderSearchForm();

    }
    // Assosiated with selectProvider method
  private returnProviderIdFn(): any {
    return ((this.selectedProvider && this.selectedProvider.provider_id) ? this.selectedProvider.provider_id : null);
  }
  // Assosiated with selectProvider method
  private returnProvidernameFn(): any {
    return ((this.selectedProvider && this.selectedProvider.providername) ? this.selectedProvider.providername : null);
  }

    CheckFormControlValue(formControl: any) {
        return (formControl && formControl !== '') ? formControl : null;
    }

    getFcProviderSearch() {
        if (this.providerSearchForm.invalid) {
          this._alertService.error('Please fill required fields');
          return false;
        }

        const formValues = this.providerSearchForm.getRawValue();
        if (formValues.isgender && !formValues.gender) {
          this._alertService.error('Please select gender');
          return false;
        }
        formValues.gender = (formValues?.isgender) ? (formValues?.gender) : null;

        Object.keys(this.providerSearchForm.controls).forEach(key => {
          formValues[key] = this.CheckFormControlValue(formValues[key]);
        });
        const body: any = {};
        Object.assign(body, formValues);
        body['isLocalDpt'] = true;
        body['localdepartmenthomecaregiver'] = true;
        body['childcharacteristics'] = formValues.childcharacteristics ? formValues.childcharacteristics[0] : null;
        body['otherLocalDeptmntTypeId'] = formValues.otherLocalDeptmntTypeId ? formValues.otherLocalDeptmntTypeId[0] : null;
        body['placementstructures'] = formValues.placementstructures ? formValues.placementstructures[0] : null;
        body['bundledplacementservices'] = formValues.bundledplacementservices ? formValues.bundledplacementservices[0] : null;

        this._httpService.getPagedArrayList(new PaginationRequest({
          where: body,
          page: this.paginationInfo.pageNumber,
          limit: 10,
          method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fcProviderSearchUrl).subscribe(result => {
          this.fcProviderSearch = result.data;
          this.fcTotal = result.count;
          (<any>$('#fc_list')).click();
          this.currProcess = 'select';
        });
      }

      backToSearchList() {
        this.currProcess = 'select';
        this.selectedProvider = null;
      }

      backToSearch() {
        this.currProcess = 'search';
        this.selectedProvider = null;
      }

      getRangeArray(n: number): any[] {
        return Array(n);
      }


      listMap(provider: any) {
        this.zoom = 13;
        this.defaultLat = 39.29044;
        this.defaultLng = -76.61233;
        (<any>$(this.mappopupid)).modal('show');
        this.markersLocation = [];
        const geocoder = new google.maps.Geocoder();
        if (geocoder) {
          geocoder.geocode({ 'address': provider.providerdetails[0].address }, (results: any, status: any) => {
            if (status === google.maps.GeocoderStatus.OK) {
              this.markersLocation = [];
              const marker = { lat: results[0].geometry.location.lat(), lng: results[0].geometry.location.lng() };
              this.lat = marker.lat;
              this.lng = marker.lng;
              this.markersLocation.push(marker);
              this.defaultLat = marker.lat;
              this.defaultLng = marker.lng;
              (<any>$(this.mappopupid)).modal('show');
              setTimeout(() => {
                this.showMap = true;
              }, 300);
            } 
          });
        }
      }
      mapClose() {
        this.markersLocation = [];
        this.showMap = false;
      }


      selectedViewProv(provId: any) {
        this.selectedViewProvider = provId;
      }

      selectedProv(provId: any) {
        this.selectedProvider = provId ;
      }
      getRelationList() {
        this._httpService.getArrayList(
          {
            where: { activeflag: 1, teamtypekey: this._authService.getAgencyName() },
            method: 'get',
            nolimit: true
          },
          CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
            .RelationshipTypesUrl + '?filter'
        ).subscribe(data => {
          if (data && data.length) {
            this.relationShipToRADropdownItems = data;
          }
        });
      }
      getRelation(key: any) {
        let decription = '';
        if(key != null && key != undefined && key !=''){
          this.relationShipToRADropdownItems.forEach(item => {
            if(item.relationshiptypekey == key){
              decription = item.description;
              return item.description;
            }
          });
          return decription;
        }
      }

      getPlacementStrType(providerId: any) {
        this._httpService.getArrayList(new PaginationRequest({
          where: {
            'structure_service_cd': 'P',
            'provider_id': providerId
          },
          nolimit: true,
          method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.placementStrTypeUrl).subscribe(result => {
          this.placementStrType = result;
        });
      }

      loadGenderDropdownItems() {
        this._httpService.create(
          {
            where: { activeflag: 1 },
            method: 'post',
            nolimit: true
          },
          CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.GenderTypeUrl + '/genderlist'
        ).subscribe((genderList) => {
          this.genderDropdownItems = genderList;
        });
        // text: res.typedescription,
        // value: res.gendertypekey
      }

      closeMap() {
        this.markersLocation = [];
        this.showMap = false;
        (<any>$(this.mappopupid)).modal('hide');
      }

      fcPageChanged(_event: any) {
        // No data or function to call or add
      }

      chooseProvider(_event: any) {
        // No data or function to call or add
      }

}