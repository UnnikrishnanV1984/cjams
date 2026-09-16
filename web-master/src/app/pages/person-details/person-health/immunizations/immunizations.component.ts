import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { AlertService, CommonHttpService, AuthService } from '../../../../@core/services';
import { PersonDetailsService } from '../../person-details.service';
import { NgxfUploaderService, FileError } from 'ngxf-uploader';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { AppConfig } from '../../../../app.config';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { HttpHeaders } from '@angular/common/http';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
// tslint:disable-next-line:import-blacklist
import { Subject, Observable } from 'rxjs';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'immunizations',
    templateUrl: './immunizations.component.html',
    styleUrls: ['./immunizations.component.scss'],
    standalone: false
})
export class ImmunizationsComponent implements OnInit {
  immunizationForm!: FormGroup;
  uploadedFile!: File;
  token: AppUser;
  resourceId: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  private pageStream$ = new Subject<number>();
  immunization: any[] = [];
  canDisplayPager$!: Observable<boolean>;
  totalRecords$!: Observable<number>;
  showData = false;

  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    public _personDetailService: PersonDetailsService,
    private _commonHttpService: CommonHttpService,
    private _uploadService: NgxfUploaderService,
    private _authService: AuthService) {
    this.token = this._authService.getCurrentUser();
  }

  ngOnInit() {
    this.immunizationForm = this.formbulider.group({
      isimmunefileavail: null,
      reportedby: '',
      immunizationdocname: '',
      immunizationdocpath: ''
    });
    this.paginationInfo.pageNumber = 1;
    this.getPage(1);
  }

  uploadFile(file: any): void {
    if (!(file instanceof File)) {
      return;
    }

    this.uploadedFile = file;
    this.uploaddata();
  }

  private uploaddata() {
    this._uploadService
      .upload({
        url: AppConfig.baseUrl + '/' + CommonUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl,
        headers: new HttpHeaders().set('ctype', 'file'),
        filesKey: ['file'],
        files: this.uploadedFile,
        process: true
      })
      .subscribe(
        (response) => {
          if (response.status === 1 && response.data) {
            this._alertSevice.success('Added Successfully');
            this._alertSevice.success('File Uploaded Succesfully!');
            this.immunizationForm.patchValue({
              immunizationdocname: this.uploadedFile.name,
              immunizationdocpath: response.data.s3bucketpathname
            });
          }
        },
        (err) => {
          console.error(err);
          this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        } 
      );
  }

  addUpdate(immunizationForm: any) {
    immunizationForm.personid = this._personDetailService.person.personid;
    this._commonHttpService.create(immunizationForm, CommonUrlConfig.EndPoint.PERSON.MEDICAL.immunizationAdd).subscribe(result => {
      this.resetForm();
      this._alertSevice.success('Immunization details saved successfully!');
      this.getPage(1);
    }, error => {
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  resetForm() {
    this.immunizationForm.reset();
    this.showData = false;
    this.immunizationForm.enable();
  }

  getPage(page: number) {
    this._commonHttpService.getArrayList(new PaginationRequest(
      {
        method: 'get',
        where: { personid: this._personDetailService.person.personid },
        nolimit: true
      }), CommonUrlConfig.EndPoint.PERSON.MEDICAL.immunizationListing + '?filter').subscribe(result => {
        this.immunization = result;
        if (result && result.length > 0) {
          const resultdata = result.find(data => data.isimmunefileavail === 'No' || data.isimmunefileavail === 'false' || data.isimmunefileavail === false);
          if (resultdata) {
            this.immunizationForm.patchValue({
              isimmunefileavail: false
            });
          }
        }
      });
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
    this.pageStream$.next(this.paginationInfo.pageNumber);
  }

  neglectSelection(value: any) {
    this.showData = value;
  }

}
