
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { forkJoin ,  Observable } from 'rxjs';
import { Validators, FormBuilder, FormGroup, FormControl } from '@angular/forms';
import { AlertService, AuthService, CommonHttpService, GenericService } from '../../../../../@core/services';

import { Router, ActivatedRoute } from '@angular/router';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { NewUrlConfig } from '../../../newintake-url.config';
import { Attachment } from '../_entities/attachmnt.model';
import { AttachmentUpload } from '../../_entities/newintakeModel';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'attachment-detail',
    templateUrl: './attachment-detail.component.html',
    styleUrls: ['./attachment-detail.component.scss'],
    standalone: false
})
export class AttachmentDetailComponent implements OnInit {
    intakeNumber: string;
    daNumber!: string;
    id: string;
    attachmentDetail!: FormGroup;
    attachmentClassificationTypeDropDown$!: Observable<DropdownModel[]>;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    @Output() modalDismiss = new EventEmitter();
    private token: AppUser;
    constructor(
        private formBuilder: FormBuilder,
        private route: ActivatedRoute,
        private router: Router,
        private _service: GenericService<Attachment>,
        private _dropDownService: CommonHttpService,
        private _authService: AuthService,
        private _alertService: AlertService
    ) {
        this.id = route.snapshot.parent?.params['id'];
        this.intakeNumber = route.snapshot.params['intakeNumber'];
        this.token = this._authService.getCurrentUser();
    }

    ngOnInit() {
        this.attachmentDetail = this.formBuilder.group({
            filename: [''],
            title: ['', [Validators.required, Validators.minLength(4), REGEX.NOT_EMPTY_VALIDATOR]],
            documentdate: new Date(),
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            documentattachment: this.formBuilder.group({
                attachmenttypekey: ['', Validators.required],
                attachmentclassificationtypekey: ['', Validators.required],
                attachmentdate: new Date(),
                sourceauthor: [''],
                attachmentsubject: [''],
                sourceposition: [''],
                attachmentpurpose: [''],
                sourcephonenumber: [''],
                acquisitionmethod: [''],
                sourceaddress: [''],
                locationoforiginal: [''],
                insertedby: [this.token.user.userprofile.displayname],
                note: [''],
                updatedby: [this.token.user.userprofile.displayname],
                activeflag: 1
            }),
            objecttypekey: ['ServiceRequest'],
            mime: [''],
            numberofbytes: [''],
            s3bucketpathname: [''],
            activeflag: [1],
            intakenumber: [this.intakeNumber],
            rootobjecttypekey: ['ServiceRequest'],
            insertedby: this.token.user.userprofile.displayname,
            updatedby: this.token.user.userprofile.displayname
        });
    }
    loadDropdown() {
        const source = forkJoin([
            this._dropDownService.getArrayList(
                {
                    nolimit: true
                },
                NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl + '?filter={}'
            ),
            this._dropDownService.getArrayList(
                {
                    nolimit: true
                },
                NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={}'
            )
        ]).pipe(
            map((result) => {
                return {
                    attachmentType: result[0].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.attachmenttypekey
                            })
                    ),
                    attachmentClassificationType: result[1].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.attachmentclassificationtypekey
                            })
                    )
                };
            }),
            share(),);
        this.attachmentTypeDropdown$ = source.pipe(pluck('attachmentType'));
        this.attachmentClassificationTypeDropDown$ = source.pipe(pluck('attachmentClassificationType'));
    }
    patchAttachmentDetail(fileInfo: AttachmentUpload) {
        this.attachmentDetail.patchValue({
            filename: fileInfo.filename,
            mime: fileInfo.mime,
            numberofbytes: fileInfo.numberofbytes,
            s3bucketpathname: fileInfo.s3bucketpathname
        });
    }
    saveAttachmentDetails() {
        this.router.routeReuseStrategy.shouldReuseRoute = function() {
            return false;
        };
        const attachmentDetail: any[] = [];
        attachmentDetail.push(this.attachmentDetail.value);
        this._service.endpointUrl = NewUrlConfig.EndPoint.Intake.SaveAttachmentUrl;
        this._service.createArrayList(attachmentDetail).subscribe(
            (response: any) => {
                if (response[0] && response[0].documentpropertiesid) {
                    this._alertService.success('Attachment added successfully!');
                    this.modalDismiss.emit();
                    let currentUrl = '/pages/newintake/my-newintake';
                    if (this.id) {
                        currentUrl = '/pages/newintake/my-newintake/' + this.id;
                    }
                    this.router.navigateByUrl(currentUrl).then(() => {
                        this.router.navigated = true;
                        this.router.navigate([currentUrl]);
                    });
                } else if (response[0] && response[0].Documentattachment) {
                    this._alertService.error(response[0].Documentattachment);
                } else {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            },
            (error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    getControlByIndexFn(index: string): FormControl {
        return this.attachmentDetail.controls[index] as FormControl;
    }
}
