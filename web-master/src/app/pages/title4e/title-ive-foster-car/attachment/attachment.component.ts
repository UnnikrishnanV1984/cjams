import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Attachment } from '../../../newintake/my-newintake/intake-attachments/_entities/attachmnt.model';
import { CommonHttpService } from '../../../../@core/services';
import { Titile4eUrlConfig } from '../../../title4e/_entities/title4e-dashboard-url-config';
import { PaginationRequest, PaginationInfo} from '../../../../@core/entities/common.entities';
import { AppConfig } from '../../../../app.config';
import { DocumentUploadListSharedComponent } from '../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { FormBuilder, FormGroup } from '@angular/forms';
import moment from 'moment';
import _ from 'lodash';


@Component({
    selector: 'attachment',
    templateUrl: './attachment.component.html',
    styleUrls: ['./attachment.component.scss'],
    standalone: false
})
export class AttachmentComponent implements OnInit {

  personid: any = '';
  downldSrcURL: any;
  documentPropertiesId: any;
  documentId: any;
  baseUrl: string;
  clientId: any;
  isCLW: any;
  uploadedFiles: Attachment[] = [];
  @ViewChild(DocumentUploadListSharedComponent) documentuploaded!: DocumentUploadListSharedComponent;
  uploadNumber = '123434';
  load = false;
  userfilteredAttachmentGrid: Attachment[] = [];
  paginationInfoperson: PaginationInfo = new PaginationInfo();
  personDocumentFilterForm!: FormGroup;
  servicecaseid: any;
  totalRecordsperson = 0;
  subCategories: any[] = [];
  categories: any[] = [];
  removalId: any;
  additionalobjectid!: string;
  constructor(
    private readonly route: ActivatedRoute,
    private readonly _dropDownService: CommonHttpService,
    private readonly formBuilder: FormBuilder,
  ) {
    this.baseUrl = AppConfig.baseUrl;
   }

  ngOnInit() {
    this.clientId =  this.route.snapshot.params['clientId'];
    this.removalId = this.route.snapshot.params['removalId'];
    this.additionalobjectid = this.clientId + '/' + this.removalId;
    this._dropDownService
    .getSingle(
        {
            code:'person_id',
            value: this.clientId,
            ownerSystem: 'CJAMS',
            method: 'post'
        },
        'Documentproperties/ecmsclientdetails'
    )
    .subscribe((result) => {
      if (result && result.personId) {
        this.personid = result.personId;
        this.personattachment(this.personid);
        this.documentuploaded?.closeupload(this.personid);
      }
    });
    this.isTabSwitched();
    this.personDocumentFilterForm = this.formBuilder.group({
      category: [null],
      subcategory: [null],
      worker: [null],
      title: [null],
      actualdocumentdate:null
  });

  this.loadFilterDropdowns();
  }

  isTabSwitched(){
    $('.intake-tabs a').on('shown.bs.tab', (event) => {
        const x = $(event.target).text();
        if(x.includes("ATTACHMENT") && this.personid){
            this.documentuploaded.closeupload(this.personid);
        }
    });
  }

  FileUploaded(event:any) {
    if (event && this.personid) {
      this.personattachment(this.personid);
    }
  }
  
  uploadclosed(event:any){
    if(event){
    this.documentuploaded.closeupload(this.personid);
    this.load = true;
    }
  }

  updateLoad() {
    this.load = false;
  }

  private personattachment(personid:any) {
    this.uploadedFiles = [];
    this.userfilteredAttachmentGrid = [];
    const documentFilter = this.personDocumentFilterForm.value;
    let category = null;
    let subcategory = null;
    if (Array.isArray(documentFilter.category) && documentFilter.category.length) {
        category = `{"${documentFilter.category.join('","')}"}`;
    }
    if (Array.isArray(documentFilter.subcategory) && documentFilter.subcategory.length) {
        subcategory = `{"${documentFilter.subcategory.join('","')}"}`;
    }

    this._dropDownServiceApi(category, subcategory, documentFilter);
  }

  private _dropDownServiceApi(category: any, subcategory: any, documentFilter: any) {
    const inputreq = {
      personid: this.personid,
      intakenumber: this.servicecaseid ? this.servicecaseid : null,
      servicerequestid: null,
      servicecaseid: null,
      adoptioncaseid: null,
      objecttypekey: 'Person',
      category: category,
      subcategory: subcategory,
      worker: documentFilter.worker,
      title: documentFilter.title,
      sortcolumn: 'updatedon',
      sortby: 'desc',
      actualdocumentdate: documentFilter.actualdocumentdate
    };

    this._dropDownService
      .getPagedArrayList(
        new PaginationRequest({
          where: inputreq,
          method: 'get',
          page: this.paginationInfoperson.pageNumber,
          limit: 10
          // nolimit : true
        }),
        `${Titile4eUrlConfig.EndPoint.Attachment.AttachmentGridUrl}?filter`).subscribe((response: any) => {
          if (response && Array.isArray(response) && response.length) {
            this.Titile4eResponse(response);
          } else {
            this.userfilteredAttachmentGrid = [];
          }
        });
  }

  private Titile4eResponse(response: any[]) {
    let result = response[0].searchcaseworkerattachments;
    if (result) {
      this.totalRecordsperson = result[0].count;

      result = result.map((item:any) => {
        item.numberofbytes = this.humanizeBytes(item.numberofbytes);
        item.documentattachment = (item.documentattachment && Array.isArray(item.documentattachment) && item.documentattachment.length > 0) 
        ? item.documentattachment[0] : item.documentattachment;
        return item;
      });

      this.userfilteredAttachmentGrid = result;
      this.userfilteredAttachmentGrid.forEach((attach:any) => {
        attach.uplodeddate = moment(attach.insertedon).format('MM/DD/YYYY hh:mm A');
        attach.actualdocumentdate = (attach.actualdocumentdate) ? moment(attach.actualdocumentdate).format('MM/DD/YYYY') : null;
      });
      this.uploadedFiles = this.userfilteredAttachmentGrid;
    } else {
      this.userfilteredAttachmentGrid = [];
    }
  }

  filterPersonDocuments() {
    this.personattachment(this.personid);
  }
  
  resetPersonFilterDocuments() {
    this.personDocumentFilterForm.reset();
    this.personattachment(this.personid);
  }

  humanizeBytes(bytes: number): string {
    if (bytes === 0) {
        return '0 Byte';
    }
    const k = 1024;
    const sizes: string[] = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
    const i: number = Math.floor(Math.log(bytes) / Math.log(k));
    return `${parseFloat((bytes / Math.pow(k, i)).toFixed(2))} ${sizes[i]}`;
}

loadFilterDropdowns() {
  this._dropDownService
  .getSingle(
      {},
      `${Titile4eUrlConfig.EndPoint.Attachment.AttachmentClassificationTypeUrl}?filter={"nolimit": true}`
  )
  .subscribe(data => {
      if (data && data.length > 0) {
         const categories = data.filter((item:any) => item.typedescription.startsWith('CW-'));
         this.categories = _.uniqBy(categories, 'typedescription');
         //To accomodate the data from migration the subcategory list is being added to the categories
         this.categories.map((item:any)=>{
             item.subcategory = item.typedescription
         })
         this.categories.push(...categories)
         this.categories = _.uniqBy(this.categories, 'subcategory');
         this.categories = _.sortBy(this.categories,'subcategory');
         this.subCategories = data.filter((item:any) => item.typedescription.startsWith('CW-'));
         this.loadAttachmentDropDown();
      } else {
          this.categories = [];
      }
  });
}

pdpageChanged(pageNumber: any) {
  this.paginationInfoperson.pageNumber = pageNumber;
  this.personattachment(this.personid);
}
loadAttachmentDropDown() {
  this._dropDownService.getArrayList(
          {
              method: 'get',
              where: {
                  referencetypeid: 1000,
                  teamtypekey: 'CW',
                  order: 'displayorder ASC'
              }
          },
          'referencetype/gettypes' + '?filter'
      )
      .subscribe((item) => {
          for (const i of item) {
              if(i.parentkey === null ){
                  this.categories.push({
                          activeflag: i.activeflag,
                          attachmentclassificationtypekey: '',
                          datavalue: 0,
                          editable: 0,
                          effectivedate: '',
                          expirationdate: '',
                          sequencenumber: 0,
                          subcategory: i.value_text,
                          typedescription: i.value_text
                      });
              }else{
                  this.subCategories.push({
                      activeflag: i.activeflag,
                      attachmentclassificationtypekey: '',
                      datavalue: 0,
                      editable: 0,
                      effectivedate: '',
                      expirationdate: '',
                      sequencenumber: 0,
                      subcategory: i.value_text,
                      typedescription: i.value_text
                  });
              }
          }
      });
}
}
