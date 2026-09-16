import {HttpEventType } from "@angular/common/http";
import { Injectable, Injector } from "@angular/core";
import { BehaviorSubject } from "rxjs";
import { HttpService } from "./http.service";
import { DynamicObject } from "../entities/common.entities";
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from "../../../../src/app/pages/case-worker/_entities/caseworker.data.constants";
import { CaseWorkerUrlConfig } from "../../../../src/app/pages/case-worker/case-worker-url.config";
import { DataStoreService } from "./data-store.service";
import { Router } from "@angular/router";
import { CommonHttpService } from "./common-http.service";
import { SessionStorageService } from "./storage.service";
import { AppConstants } from "../common/constants";
import { IntakeStoreConstants } from "../../../../src/app/pages/newintake/my-newintake/my-newintake.constants";
import { AlertService } from "./alert.service";
export class IntakeStore {
    number?: string;
    action?: string;
    traffickingupdate?: boolean;
    maltreatmentupdated?:boolean;
}
export class PersonInfoStore {
    personId?: string;
    sourceID?: string;
    clientId?: number;
    placementId?: number;
    removalId?: number;
    fromIVtab: boolean = false;
    source?: string;
    action?: string;
    data: any;
    searchData: any;
}

@Injectable({ providedIn: 'root' })
export class UploadSharedService {
    private _httpservice: HttpService;
    private _dataStoreService: DataStoreService;
    private _router: Router;
    private _commonService: CommonHttpService;
    private _sessionStorage: SessionStorageService;
    private _alert: AlertService;
    private uploadFileProgressSubject = new BehaviorSubject<DynamicObject>({} as DynamicObject);
    uploadFileProgress$ = this.uploadFileProgressSubject.asObservable();
    requestlist: any = [];
    caseworkerpageurl = '/pages/case-worker/';
    reportsummaryurl = '/dsds-action/attachment/attachment-upload/largefileupload';

    constructor(private injector: Injector) {
        this._httpservice = this.injector.get<HttpService>(HttpService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._router = this.injector.get<Router>(Router);
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
        this._alert = this.injector.get<AlertService>(AlertService);
    }

    public presignUrlcallupload(request: any, file: File) {
        this.requestlist = [];
        this.uploadFileProgress$.subscribe(uploadprogress => {
            if(uploadprogress && uploadprogress.length > 0) {
                const uprogress = uploadprogress.filter((up: any) => up.ecmsdocumentid != request.deletedocid);
                if(uprogress && uprogress.length > 0) {
                    this.requestlist = uprogress;
                }                    
            }            
        });
        this.requestlist.push(request);
        const uploadurl = request.s3bucketpathname;
        const url = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UpdatePresignUrlAttachmentUrl;
        const payload = {
            presignedurlstatus: 1,
            ecmsdocumentid: request.ecmsdocumentid
        };
         this._commonService.create(payload,url).subscribe((_response) => {                          
            // No data or function to add or call                               
        });
        this._httpservice
            .uploadlargefile(file, uploadurl,request.fileSha256Hash).subscribe((event) => {
                this.setUploadFileProgress(this.requestlist);
                if (event.type === HttpEventType.UploadProgress && event.total) {
                    const percent = Math.round((100 * event.loaded) / event.total);
                    request.progress = percent;                    
                    return { status: 'progress', progress: percent };
                } else if (event.type === HttpEventType.Response) {
                    const uploadComplete = true;
                    request.uploadComplete = uploadComplete;
                    const payload = {
                        presignedurlstatus: 2,
                        ecmsdocumentid: request.ecmsdocumentid
                    }
                    this._commonService.create(payload,url).subscribe((_response) => {                          
                        // No data or function to add or call                            
                    });
                    return { status: 'done', body: event.body };
                } else {
                    return { status: 'other', event: event };
                }
            },
            (error) => {
              console.log('Unable to upload the file.',error);
              this._alert.error("File upload failed");
              this.uploadpendingdocumentsafterdisconnect(file);
              return false;
            }
        );
    }
    setUploadFileProgress(value: any) {
        this.uploadFileProgressSubject.next(value);
    }
    getUploadFileProgress() {
       return this.uploadFileProgressSubject.value;
    }
    clearUploadFileProgress() {
        this.uploadFileProgressSubject.next({});
    }
    routetodocumentsupload(item: any) {   
        if (item.casetype === 'servicecase') {
            item.source = 'SERVICE_CASE';
            this._sessionStorage.setTabKeyKey(item.casenumber);
            this._sessionStorage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
            const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.caseid + '/casetype';
            this._commonService.getAll(url).subscribe((response) => {
                const dsdsActionsSummary = response[0];
                if (dsdsActionsSummary) {
                    this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                    this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                    this._dataStoreService.setData(CASE_STORE_CONSTANTS.DA_NUMBER, item.casenumber);
                    this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_UID, item.caseid);
                    this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);  
                    this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.SERVICE_CASE);                  
                    const currentUrl = this.fetchservicecaserouteurl(item);                   
                    this._router.navigate([currentUrl], {queryParams: {retrydocument: true, retryid: item.additionalobjectid, retryobjecttype: item.additionalobjecttype, deletedocid: item.ecmsdocumentid }});
                }
            });
        } else if (item.casetype === 'intake') {
            item.source = 'INTAKE';
            const intake = Object.create(IntakeStore);
            intake.number = item.casenumber;
            intake.action = 'edit';
            this._dataStoreService.setObj('intake', intake);
            this._dataStoreService.clearStore();
            this._dataStoreService.clearStoreWithout();
            const url = '/pages/newintake/my-newintake/' + intake.number + '/edit/' + 'attachment';
            this._router.navigate([url],{queryParams: {retrydocument: true, retryid: item.additionalobjectid, deletedocid: item.ecmsdocumentid}});
        } else if (item.casetype === 'adoptioncase') {
            item.source = 'ADOPTION_CASE';
            this.routToDocumentsAdoptionCase(item);
        } else if(item.casetype === 'cps') {
            item.source = 'CPS_CASE';
            this._commonService.getById(item.casenumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
                const dsdsActionsSummary = response[0];
                const caseid = item.caseid ?? dsdsActionsSummary?.intakeserviceid;
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.DA_NUMBER, item.casenumber);
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_UID, caseid);
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, false);  
                const currentUrl = this.fetchcpscaserouteurl(item); 
                this._router.navigate([currentUrl],{queryParams: {retrydocument: true, retryid: item.additionalobjectid, retryobjecttype: item.additionalobjecttype, deletedocid: item.ecmsdocumentid}});
            });
        }else if(!item.casetype && item.objecttypekey === 'Person' && item.additionalobjecttype === 'foster-care') {
            const url = 'pages/title4e/foster-car/' + item.additionalobjectid;
            this._router.navigate([url], {queryParams: {retrydocument: true, deletedocid: item.ecmsdocumentid}});
        }else if(!item.casetype && item.objecttypekey === 'Person' && item.additionalobjecttype === 'guardianship') {
            const url = 'pages/title4e/guardianship/' + item.additionalobjectid;
            this._router.navigate([url], {queryParams: {retrydocument: true, deletedocid: item.ecmsdocumentid}});
        }else if(!item.casetype && item.objecttypekey === 'Person' && item.additionalobjecttype === 'adoption') {  
            const url = 'pages//title4e/adoption/' + item.additionalobjectid;
            this._router.navigate([url], {queryParams: {retrydocument: true, deletedocid: item.ecmsdocumentid}});
        }
    }
    fetchservicecaserouteurl(item: any): string | undefined {
        if(item.objecttypekey === 'courtorder') {
            this._sessionStorage.setItem('courthearingid', item.intakeservicerequesthearingid);
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber +  '/dsds-action/court/court-order';
        }
        if(item.objecttypekey === 'AdoptionSubsidy') {
            this._sessionStorage.setItem('transid', item.objectid);
            this._sessionStorage.setItem(CASE_STORE_CONSTANTS.ADOPTION_PERMANENCYPLANID, item.permanencyplanid);
            this._sessionStorage.setItem('transkey', 'subsidy');
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/sc-permanency-plan/placement/adoption/adoption-subsidy/agreement';
        }  
        if(item.objecttypekey === 'purchaseAuthReceipt') {
            this._sessionStorage.setItem('PurchaseAuthorization', item.client_id);
            this._sessionStorage.setItem('PurchaseAuthorizationServiceLog', item.service_log_id);
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/service-plan/service-log-activity/referred-services';
        } 
        if(item.objecttypekey === 'gapapplication') {
            this._sessionStorage.setItem(CASE_STORE_CONSTANTS.GAP_APPLICATION_ID, item.objectid);
            this._sessionStorage.setItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, item.permanencyplanid);
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/sc-permanency-plan/placement/placement-gap/application';
        }     
        if(item.objecttypekey === 'gapagreement') {
            this._sessionStorage.setItem(CASE_STORE_CONSTANTS.GAP_APPLICATION_ID, item.objectid);
            this._sessionStorage.setItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, item.permanencyplanid);
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/sc-permanency-plan/placement/placement-gap/agreement';
        }       
        if(item.objecttypekey === 'Person') {            
            if(item.additionalobjectid && item.additionalobjecttype) {
               return this.navigatetopersoninfo(item);
            }
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/attachment/attachment-upload/largefileupload/person/' + item.objectid;
        }
        if(item.additionalobjecttype === 'meetingrecording') {
            this._dataStoreService.setData('uploadattachmenttype', '1');
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/recording/family-involvement-meeting';
        }   
        if(item.additionalobjecttype === 'progressnote') {
            this._dataStoreService.setData('uploadattachmenttype', '1');
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/recording/notes';
        }   
    
        return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/attachment/attachment-upload/largefileupload';
    }

    fetchcpscaserouteurl(item: any): string | undefined {
        if(item.objecttypekey === 'courtorder') {
            this._sessionStorage.setItem('courthearingid', item.intakeservicerequesthearingid);
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber +  '/dsds-action/court/court-order';
        }
        if(item.objecttypekey === 'investigationappeal') {
            this._sessionStorage.setItem('investigationallegationmaltreatorsid', item.objectid);
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber +  '/dsds-action/investigation-findings';
        }
        if(item.objecttypekey === 'Person') {            
            if(item.additionalobjectid && item.additionalobjecttype) {
               return this.navigatetopersoninfo(item);
            }
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/attachment/attachment-upload/largefileupload/person/' + item.objectid;
        }
        return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/attachment/attachment-upload/largefileupload';
    }

    fetchadotioncaserouteurl(item: any): string | undefined {
        if(item.objecttypekey === 'courtorder') {
            this._sessionStorage.setItem('courthearingid', item.intakeservicerequesthearingid);
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber +  '/dsds-action/court/court-order';
        }
        if(item.objecttypekey === 'purchaseAuthReceipt') {
            this._sessionStorage.setItem('PurchaseAuthorization', item.client_id);
            this._sessionStorage.setItem('PurchaseAuthorizationServiceLog', item.service_log_id);
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/service-plan/service-log-activity/referred-services';
        } 
        if(item.objecttypekey === 'AdoptionSubsidy') {
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/placement/adoption/adoption-subsidy/agreement';
        }  
   
        if(item.objecttypekey === 'Person') {            
            if(item.additionalobjectid && item.additionalobjecttype) {
               return this.navigatetopersoninfo(item);
            }
            return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/attachment/attachment-upload/largefileupload/person/' + item.objectid;
        }
        return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/attachment/attachment-upload/largefileupload';
    }

    navigatetopersoninfo(item: any) {
        const personInfo = Object.create(PersonInfoStore);
        const data = {
            purposeId: null,
            caseNumber: null
          };
        if (item.source == 'INTAKE') {
            const intakePurpose = this._dataStoreService.getData(IntakeStoreConstants.purposeSelected);
            if (intakePurpose && intakePurpose.code !== 'ROACPS') {
                data.purposeId = intakePurpose.value;
            }
        } else {
            data.purposeId = this._dataStoreService.getData('da_typeid');
            data.caseNumber = item.casenumber;
        }
        personInfo.source = item.source;
        personInfo.sourceID = (item.source == 'INTAKE' ? item.casenumber : item.caseid);
        personInfo.personId = item.objectid;
        personInfo.action = AppConstants.ACTIONS.EDIT;
        personInfo.data = data;
        this._dataStoreService.setObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO, personInfo);
        localStorage.setItem('navigationInfo',JSON.stringify(personInfo));
        switch (item.additionalobjecttype) {
            case 'personexamination':
                return 'pages/person-info-cw/health/examination';
            case 'personbehavioralhealth':
                return 'pages/person-info-cw/health/behavioral-health';
            case 'personfmlymdclhstry':
                return 'pages/person-info-cw/health/family-history';
            case 'personhealthinsurance':
                return 'pages/person-info-cw/health/insurance-info';
            case 'personhlthfeeding':
                return 'pages/person-info-cw/health/feeding-info';
            case 'personhospitalization':
                return 'pages/person-info-cw/health/hospitalization';
            case 'personmedicalcondition':
                return 'pages/person-info-cw/health/diseases-conditions';
            case 'personmedicpshychotropic':
                return 'pages/person-info-cw/health/medication-psychotropic';
            case 'personphycisianinfo':
                return 'pages/person-info-cw/health/provider-info';
            case 'personsexualinfo':
                return 'pages/person-info-cw/health/re-productive-health';
            case 'birthhealthinfo':
                return 'pages/person-info-cw/health/birth-info';
            case 'firstquarter':
                return 'pages/person-info-cw/education';
            case 'secondquarter':
                return 'pages/person-info-cw/education';
            case 'thirdtquarter':
                return 'pages/person-info-cw/education';
            case 'fourthquarter':
                return 'pages/person-info-cw/education'; 
            case 'meetingrecording':
                this._dataStoreService.setData('uploadattachmenttype', '2');
                this._dataStoreService.setData('uploadpersonid', item.objectid);
                return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/recording/family-involvement-meeting';
            case 'progressnote':
                this._dataStoreService.setData('uploadattachmenttype', '2');
                this._dataStoreService.setData('uploadpersonid', item.objectid);
                return this.caseworkerpageurl + item.caseid + '/' + item.casenumber + '/dsds-action/recording/notes';           
          }
    }
      
    routToDocumentsAdoptionCase(item: any) {
        this._sessionStorage.setTabKeyKey(item.casenumber);
        this._sessionStorage.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, 'ADOPTION');
        this._sessionStorage.setItem('ISADOPTION', true);
        this._sessionStorage.setObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        if (item) {
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        }
        this._commonService.getById(item.casenumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            if (dsdsActionsSummary) {
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.DA_NUMBER, item.casenumber);
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_UID, item.caseid);
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, false);  
                const currentUrl = this.fetchadotioncaserouteurl(item); 
                this._router.navigate([currentUrl],{queryParams: {retrydocument: true, retryid: item.additionalobjectid, retryobjecttype: item.additionalobjecttype, deletedocid: item.ecmsdocumentid}});
            }
        });
    }

    uploadpendingdocumentsafterdisconnect(file: any) {
        let uprogress ;
        let uploadstatusretryfiles = this._sessionStorage.getItem('uploadstatusretryfiles') ? this._sessionStorage.getItem('uploadstatusretryfiles') : [];
        this.uploadFileProgress$.subscribe((uploadfile) => {           
            uprogress = uploadfile.filter((up: any) => up.progress > 0 && !up.uploadComplete);
            if(uprogress && uprogress.length > 0) {            
                uprogress.forEach((uprogg: any) => {  
                    if(file.ecmsdocumentid == uprogg.ecmsdocumentid) {
                        uploadstatusretryfiles.push(uprogg);
                        uprogg.uploadstatus = 'FAILED';
                        uprogg.progress = 0;
                        const url = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadStatusUpdateAttachmentUrl + '/' + file.ecmsdocumentid;
                        this._commonService.create({},url).subscribe((_response) => {                          
                            // No data or function to add or call                             
                        });
                    }         
                });  
                this._sessionStorage.setObj('uploadstatusretryfiles',uploadstatusretryfiles);          
            }
        });
    }

}