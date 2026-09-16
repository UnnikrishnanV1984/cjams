import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { HttpService } from '../../../../@core/services/http.service';
import { CommonHttpService, AuthService, CommonDropdownsService, SessionStorageService, GenericService } from '../../../../@core/services';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';


@Injectable()
export class AssessmentService {

  id: string;
  serviceCaseId!: string | null;
  isServiceCase!: string;
  daNumber: string;

  INTERNAL_ASSESSMENTS = ['AOD', 'cans-v2', 'MFIRA'];

  constructor(private _router: Router,
    private _commonHttpService: CommonHttpService,
    private _http: HttpService,
    private authService: AuthService,
    private storage: SessionStorageService,
    private _commonDDService: CommonDropdownsService,
    private _service: GenericService<any>
    ) {
      this.id = this._commonDDService.getStoredCaseUuid();
      this.daNumber = this._commonDDService.getStoredCaseNumber();
    }


  // Maintain mapping of assessments to their respective mappings
  internalAssessmentTemplateMapping: any = {
    'AOD Form' : '5b597d5ee881f068be283c9a',
    'PADS Form' : '5b57e7f0e881f068be283c5b',
    'cans-v2' : '5d26ec3d927e9405e4c99fb1',
    'MFIRA' : '5b6d56a7e881f068be283e60',
    'AOD/PADS Form' : '5b597d5ee881f068be283c9a',
    'CANS-OUT OF HOME PLACEMENT SERVICE' : '5b90c64e8c425c47f9dd4d41',
    'Sex Trafficking(CST) Screening Interview Form' : '5e864df66afc67001c876d97',
    'SAFE-C': '5b6bdf89e881f068be283dd1',
    'SAFE-C OHP': '5b7ae9ede881f068be283ef5',
    'PLACEMENT REQUEST FORM - ATTACHMENT A' : '606b4bd8a4bf68001a52a9e7',
    'QUALIFIED INDIVIDUAL (QI) ASSESSMENT - ATTACHMENT B' : '606b4bd8a4bf68001a52a9e8',
    'FACILITATED MEETING REFERRAL FORM': '606b4bd8a4bf68001a52a9e9',
    'LAP (Lethality Assessment Program)':'606b4bd8a4bf68001a52a8e9',
    'Quick Youth Indicators for Trafficking (QYIT)': '2b4f455a-b4c5-4f41-9353-685e7850f2ef'
  };

  getservicecase() {
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
        if (this.isServiceCase) {
          this.serviceCaseId = this._commonDDService.getStoredCaseUuid();
        } else {
          this.serviceCaseId = null;
        }

  }

  getAliasNames(personid: any): Observable<any> {
    return this._service.getArrayList({
      method: 'get',
      where: {
        personid: personid
      }
    }, CommonUrlConfig.EndPoint.PERSON.AliasNameList);
  }

  getRelationShip(primaryuserid: string, secondaryuserid: any, relationshiparray: any[]) {
    let relationshipdesc= '';
    if(primaryuserid === secondaryuserid){
      relationshipdesc = 'Self';
    }else if(relationshiparray && relationshiparray.length) {
      const relationship = relationshiparray.filter(person => ( person.primaryuserid === primaryuserid && person.secondaryuserid === secondaryuserid ) );
      if(relationship && relationship.length) {
        relationshipdesc = relationship[0].description;
      }
    }

    return relationshipdesc;
  }


  // If the assessment record does not exist then create, else update the existing data
  saveAssessment(assessmentName: string, currentAssessmentId: string, submissionData: any) {
    return this.createAssessment(assessmentName, submissionData, submissionData.currentSubmissionId, submissionData.assessmentStaus);
}

  updateTemporaryId(temporaryId: string, updatedby: any, newId: string): Observable<any> {
    return this._commonHttpService.create(
      {
        method: 'post',
        temporaryId: temporaryId,
        newId: newId,
        updatedby: updatedby
      },
      'Documentproperties/updateTemporaryId'
    );
  }


   saveSafecAssessment(assessmentName: string, currentAssessmentId: any, submissionData: any) {
      return this.createSafecAssessment(assessmentName, submissionData, submissionData.currentSubmissionId, submissionData.assessmentStaus);
  }

  submitAssessmentForApproval(assessmentName: any, currentAssessmentId: any, currentSubmissionId: any, submissionData: any, assessmentStaus: any) {
    return this._commonHttpService.create(
      {
        method: 'post',
        internaltemplateid: this.internalAssessmentTemplateMapping[assessmentName],
        objectid: this.id,
        submissiondata : submissionData,
        assessmentid: currentAssessmentId,
        submissionid: currentSubmissionId,
        // routing is expecting this for service case!!!
        servicecaseid: this.id,
        assessmentstatustypekey1: assessmentStaus
      },
      'admin/assessment/createAssessmentInternal'
    );
  }

  // Save as draft and update once the assessment record is created
  patchAssessment(currentAssessmentId: string, submissionData: any) {
    const payload: any = {};
    payload['assessmentid'] = currentAssessmentId;
    payload['submissiondata'] = submissionData;
    return this._commonHttpService.patch(
      currentAssessmentId,
      payload,
      'admin/assessment'
    );
  }

  createAssessment(assessmentName: string, submissionData: any, currentSubmissionId: any, assessmentStatus: any) {
    return this._commonHttpService.create(
      {
        method: 'post',
        assessmentactor :  submissionData.assessmentactor ? submissionData.assessmentactor : [],
        externaltemplateid: this.internalAssessmentTemplateMapping[assessmentName],
        form: this.internalAssessmentTemplateMapping[assessmentName],
        objectid: this._commonDDService.getStoredCaseUuid(),
        servicecaseid: this.serviceCaseId,
        submissiondata : submissionData,
        submissionid: currentSubmissionId,
        assessmentstatustypekey1: assessmentStatus,
        comments:submissionData.comments
      },
      'admin/assessment/Add'
    );
  }


  createSafecAssessment(assessmentName: string, submissionData: any, currentSubmissionId: any, assessmentStatus: any) {
    let ischildsafe: any = null;
    if(submissionData.assessmentstatus == 'Accepted') {
     if (submissionData.dangerInfluencesIdentified == 'safetydecision1' || submissionData.dangerInfluencesIdentified == 'safetydecision2' || submissionData.dangerInfluencesIdentified == 'safetydecision3') {
      ischildsafe = 1;
      submissionData.assessmentactor.forEach((element: { issafe: any; }) => {
        element.issafe = ischildsafe
      });
     }  else if (submissionData.dangerInfluencesIdentified == 'safetydecision4' ) {
        ischildsafe = 0;
        submissionData.assessmentactor.forEach((element: { issafe: any; }) => {
          element.issafe = ischildsafe
        });
     }
    }
    return this._commonHttpService.create(
      {
        method: 'post',
        assessmentactor :  submissionData.assessmentactor ? submissionData.assessmentactor : [],
        externaltemplateid: this.internalAssessmentTemplateMapping[assessmentName],
        form: this.internalAssessmentTemplateMapping[assessmentName],
        objectid: this._commonDDService.getStoredCaseUuid(),
        servicecaseid: this.serviceCaseId,
        submissiondata : submissionData,
        submissionid: currentSubmissionId,
        assessmentstatustypekey1: assessmentStatus,
        ischildsafe: ischildsafe,
        comments:submissionData.comments,
        assessmentName:assessmentName
      },
      'admin/assessment/Add'
    );
  }

  getAssessmentsByTemplate(objectid: any, objectname: any, assessmenttemplateid: any) {
    return this._commonHttpService.getArrayList(
      {
        method: 'get',
        where: {
          objectid: objectid,
          objectname: objectname,
          assessmenttemplateid: assessmenttemplateid
        }
      },
      'admin/assessment'
    );
  }

  // for now returnig this list from UI, can move to DB
  getInternalAssessments() {
    return this.INTERNAL_ASSESSMENTS;
  }

}
