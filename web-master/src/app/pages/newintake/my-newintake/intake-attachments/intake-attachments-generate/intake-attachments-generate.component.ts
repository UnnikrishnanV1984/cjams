import { Component, OnInit } from '@angular/core';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { GeneratedDocuments } from '../../_entities/newintakeSaveModel';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { IntakeStoreConstants } from '../../my-newintake.constants';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CommonHttpService, GenericService, AlertService, AuthService, DataStoreService } from '../../../../../@core/services';
import { Attachment } from '../_entities/attachmnt.model';
import { ActivatedRoute } from '@angular/router';
import { AppConfig } from '../../../../../app.config';
import { NewUrlConfig } from '../../../newintake-url.config';

@Component({
    selector: 'intake-attachments-generate',
    templateUrl: './intake-attachments-generate.component.html',
    styleUrls: ['./intake-attachments-generate.component.scss'],
    standalone: false
})
export class IntakeAttachmentsGenerateComponent implements OnInit {
  intakeNumber!: string;
  token!: AppUser;
  daNumber!: string;
  searchText = '';
  generatedDocuments: GeneratedDocuments[] = [];
  isCLW!: boolean;
  complaints: any[] = [];
  victims: any[] = [];
  generateDocForm!: FormGroup;
  id: string;
  baseUrl: string;
  isGenerateByVictim!: boolean;
  selectedDocument: any;
  generatedetailspopupid = '#generate-details';
  private store: any;
  constructor(
    private formBuilder: FormBuilder,
    private _commonService: CommonHttpService,
    private _service: GenericService<Attachment>,
    private route: ActivatedRoute,
    private _alertService: AlertService,
    private _authService: AuthService,
    private _store: DataStoreService
  ) {
    this.id = route.snapshot.params['id'];
    this.baseUrl = AppConfig.baseUrl;
    this.store = this._store.getCurrentStore();
  }

  ngOnInit() {
    this.intakeNumber = this.store[IntakeStoreConstants.intakenumber];
    this.token = this._authService.getCurrentUser();
    this.initGenerateDocForm();
    this.generatedDocuments = this.store[IntakeStoreConstants.generatedDocuments] ? this.store[IntakeStoreConstants.generatedDocuments] : [];
    this.loadGeneratedDocumentList(this.token);
  }

  initGenerateDocForm() {
    this.generateDocForm = this.formBuilder.group({
      complaint: [{ value: '', required: true }],
      victim: ['']
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

  private loadGeneratedDocumentList(user: AppUser) {
    this._commonService.getAllPaged({
      where: {
        roletypekey: 'JSCLW',
        intakenumber: this.intakeNumber
      },
      limit: 10,
      nolimit: true,
      page: 1
    },
      NewUrlConfig.EndPoint.Intake.GenerateDocumentList).subscribe((res: any) => {
        this.generatedDocuments = res;
        this.generatedDocuments.forEach(document => {
          document.isGenerated = document.generatedDateTime ? true : false;
        });
      });
    // }
  }

  downloadDocument(document: any) {
    this._store.setData(IntakeStoreConstants.generatedDocumentDownloadKey, [document.key]);
    this._store.setData('loadhtml', true);
  }

  downloadSelectedDocuments() {
    const selectedDocuments = this.getSelectedDocuments();
    if (selectedDocuments) {
      this._store.setData(IntakeStoreConstants.generatedDocumentDownloadKey, selectedDocuments.map(document => document.key));
      this._store.setData('loadhtml', true);
    }
  }

  getSelectedDocuments() {
    return this.generatedDocuments.filter(document => document.isSelected);
  }

  isFileSelected() {
    const selectedDocuments = this.getSelectedDocuments();
    if (selectedDocuments) {
      return selectedDocuments.length > 0;
    }

    return false;
  }

  generateNewDocument(document: any) {
    this.selectedDocument = document;
    document.isInProgress = true;
    if (!document.inputfields) {
      this.generateDocumnet(document);
    } else {
      this.initGenerateDocForm();
      this.isGenerateByVictim = false;
      const inputs = document.inputfields.split(',');
      if (inputs.includes('complaintid')) {
        this._commonService.getArrayList({
          where: { intakenumber: this.intakeNumber },
          limit: 10,
          nolimit: true,
          page: 1,
          method: 'get'
        },
          NewUrlConfig.EndPoint.Intake.Intakeservicerequestevaluations)
          .subscribe((res: any) => {
            this.complaints = res;
          });
      }

      if (inputs.includes('victim')) {
        this.isGenerateByVictim = true;
        this.generateDocForm.get('victim')?.setValidators(Validators.required);
      } else {
        this.generateDocForm.get('victim')?.clearValidators();
      }
      this.generateDocForm.get('victim')?.updateValueAndValidity();
      (<any>$(this.generatedetailspopupid)).modal('show');
      $(this.generatedetailspopupid).on('hidden.bs.modal', function () {
        document.isInProgress = false;
      });
    }
  }

  loadVictims() {
    const complaintid = this.generateDocForm.get('complaint')?.value;
    this._commonService
      .getArrayList({
        where: {
          intakeservicerequestevaluationid: complaintid
        },
        method: 'post'
      }, NewUrlConfig.EndPoint.Intake.getComplaintDetails).subscribe((response: any) => {
        const victims: any[] = [];
        response.data.forEach((complaint: any) => {
          complaint.victim.forEach((victim: any) => {
            victims.push(victim);
          });
        });
        this.victims = Array.from(new Set(victims));
      });
  }

  public generateDocumnet(document: any) {
    const documentKey: any[] = [];
    documentKey.push(document.documentkey);
    const generateDocDetails = this.generateDocForm.getRawValue();
    const complaintid = generateDocDetails.complaint ? [].concat(generateDocDetails.complaint) : [];
    const victimid = generateDocDetails.victim ? [].concat(generateDocDetails.victim) : [];
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: {
        intakenumber: this.intakeNumber,
        documenttemplatekey: documentKey,
        reportername: this.token.user.userprofile.displayname,
        reporteddate: new Date(),
        screenername: this.token.user.userprofile.displayname,
        isdraft: false,
        downloadtype: document.downloadtype,
        intakeservicerequestevaluationid: complaintid,
        victim: victimid
      },
      method: 'post'
    }), 'evaluationdocument/generateintakedocument')
      .subscribe(res => {
        if (res.data && res.data.length) {
          this._store.setData(IntakeStoreConstants.generatedDocuments, this.generatedDocuments);
          (<any>$(this.generatedetailspopupid)).modal('hide');
          this.loadGeneratedDocumentList(this.token);
        }
      }, (err) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        document.isInProgress = false;
      });
  }

  generateSelectedDocuments() {
    this.generatedDocuments.forEach(document => {
      if (document.isSelected) {
        this.generateNewDocument(document);
      }

    });
  }

}
