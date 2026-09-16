
import {of as observableOf, EMPTY,  Observable, Subject } from 'rxjs';

import {share, pluck, map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { CommonHttpService, AlertService, GenericService } from '../../../../../@core/services';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { ResourceConsult, ResourceList } from '../../_entities/newintakeModel';
import { NewUrlConfig } from '../../../newintake-url.config';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { ActivatedRoute } from '@angular/router';
import moment from 'moment';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'resource-consult',
    templateUrl: './resource-consult.component.html',
    styleUrls: ['./resource-consult.component.scss'],
    standalone: false
})
export class ResourceConsultComponent implements OnInit {
    recsourceConsultForm: FormGroup;
    id: string;
    popUpText = 'Add';
    btnName = 'Add';
    intakeservicerequestconsultreviewid: string;
    resourceID: string;
    isView: boolean;
    canDisplayPager$: Observable<boolean>;
    totalRecords$: Observable<number>;
    resourceCOnsult$: Observable<ResourceConsult[]>;
    resourceCOnsult: ResourceConsult;
    paginationInfo: PaginationInfo = new PaginationInfo();
    private pageStream$ = new Subject<number>();
    selectType$ = new Observable<DropdownModel[]>();
    resourceList$ = new Observable<ResourceList[]>();
    recsourceConsultUserForm: FormGroup;
    recsourceConsultUser$ = new Observable<Array<any>>();
    recsourceConsultUser = [];
    deleteresourcepopupid = '#delete-resource-popup';
    constructor(
        private _formBuilder: FormBuilder,
        private _service: GenericService<ResourceConsult>,
        private _commonHttpService: CommonHttpService,
        private _alertService: AlertService,
        private route: ActivatedRoute
    ) { }

    ngOnInit() {
        this.id = this.route.snapshot.parent.parent.parent.parent.parent.params['id'];
        this.loadForm();
        this.loadresourceConsultUserForm();
        this.listDropdown();
        this.pageStream$.subscribe((pageNumber) => {
            this.paginationInfo.pageNumber = pageNumber;
            this.getPage(this.paginationInfo.pageNumber);
        });
        this.getPage(1);
    }

    loadForm() {
        this.recsourceConsultForm = this._formBuilder.group({
            resourceconsultuser: [''],
            notes: ['', Validators.required],
            date: ['', Validators.required],
            time: ['', Validators.required]
        });
    }

    loadresourceConsultUserForm() {
        this.recsourceConsultUser$ = EMPTY;
        this.recsourceConsultUser = [];
        this.recsourceConsultUserForm = this._formBuilder.group({
            name: ['', Validators.required],
            consultreviewusertype: [''],
        });
    }

    addrecsourceConsultUser() {
        const nameModel = this.recsourceConsultUserForm.get('name').value;
        const consultreviewusertypeModel = this.recsourceConsultUserForm.get('consultreviewusertype').value;
        if (nameModel && consultreviewusertypeModel) {
            this.recsourceConsultUser.push({
                name: nameModel,
                consultreviewusertypekey: consultreviewusertypeModel.value,
                consultreviewusertype: consultreviewusertypeModel.text,
                onDelete: false,
                intakeservicerequestconsultreviewconfigid: null
            });
            this.recsourceConsultUser$ = observableOf(this.recsourceConsultUser);
            this.recsourceConsultUserForm.reset();
        }
    }

    deleteUser(configid, i: number) {
        if (this.recsourceConsultUser.length <= 1 && configid) {
            this._alertService.error('Minimum one user required!');
        } else {
            if (configid) {
                this._service.endpointUrl = NewUrlConfig.EndPoint.DSDSAction.Contact.DeleteResourceUserURL;
                this._service.remove(configid).subscribe(
                    response => {
                        this.recsourceConsultUser.splice(i, 1);
                        this.recsourceConsultUser$ = observableOf(this.recsourceConsultUser);
                        this._alertService.success('Resource consult review user deleted successfully');
                    },
                    error => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                this.recsourceConsultUser.splice(i, 1);
                this.recsourceConsultUser$ = observableOf(this.recsourceConsultUser);
                this._alertService.success('Resource consult review user deleted successfully');
            }
        }
    }

    deleteUsercheck(i: number) {
        this.recsourceConsultUser[i].onDelete = true;
    }

    cancelDelete(i: number) {
        this.recsourceConsultUser[i].onDelete = false;
    }

    saveResourceConsult(resourceCOnsult) {
        if (this.recsourceConsultUser.length < 1) {
            this._alertService.error('Minimum one user required!');
        } else {
            if (this.recsourceConsultUser) {
                this.recsourceConsultUser.forEach(element => {
                    delete element.consultreviewusertype;
                    delete element.onDelete;
                });
                resourceCOnsult.resourceConsultUser = Object.assign(this.recsourceConsultUser);
            }
            if (resourceCOnsult.date) {
                const timeSplit = resourceCOnsult.time.split(':');
                if (!(resourceCOnsult.date instanceof Date)) {
                    resourceCOnsult.date = new Date(resourceCOnsult.date);
                }
                resourceCOnsult.date.setHours(timeSplit[0]);
                resourceCOnsult.date.setMinutes(timeSplit[1]);
            }
            resourceCOnsult.intakeserviceid = this.id;
            resourceCOnsult.intakeservicerequestconsultreviewid = this.intakeservicerequestconsultreviewid;
            this._commonHttpService.create(resourceCOnsult, NewUrlConfig.EndPoint.DSDSAction.Contact.AddResourceConsultURL).subscribe(
                result => {
                    this._alertService.success('Resource consult details saved successfully!');
                    this.getPage(1);
                    (<any>$('#cls-add-resource')).click(); // NOSONAR
                    this.clearItem();
                },
                error => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    clearItem() {
        this.recsourceConsultForm.reset();
        this.recsourceConsultForm.enable();
        this.recsourceConsultUserForm.reset();
        this.recsourceConsultUserForm.enable();
        this.recsourceConsultUser = [];
        this.recsourceConsultUser$ = EMPTY;
        this.popUpText = 'Add';
        this.btnName = 'Add';
        this.resourceID = null;
        this.intakeservicerequestconsultreviewid = null;
        this.isView = false;
    }
    showDeletePop(resourceid) {
        this.resourceID = resourceid.intakeservicerequestconsultreviewid;
        (<any>$(this.deleteresourcepopupid)).modal('show'); // NOSONAR
    }

    showEditPopup(resource) {
        this.resourceID = resource.intakeserviceid;
        if (this.resourceID) {
            this.popUpText = 'Edit';
            this.btnName = 'Update';
            this.intakeservicerequestconsultreviewid = resource.intakeservicerequestconsultreviewid;
        } else {
            this.intakeservicerequestconsultreviewid = null;
        }

        resource.time = moment(resource.date).format('HH:mm');
        this.recsourceConsultUser = [...resource.resourceconsultuser];
        this.recsourceConsultUser.forEach(data => {
            data.onDelete = false;
        });
        this.recsourceConsultUser$ = observableOf(this.recsourceConsultUser);
        this.recsourceConsultForm.patchValue(resource);
        this.recsourceConsultForm.enable();
        this.isView = false;
        (<any>$('#add')).modal('show'); // NOSONAR
    }

    showViewPopup(resource) {
        this.popUpText = 'View';
        resource.time = moment(resource.date).format('HH:mm');
        this.recsourceConsultUser = resource.resourceconsultuser;
        this.recsourceConsultUser$ = observableOf(this.recsourceConsultUser);
        this.recsourceConsultForm.patchValue(resource);
        this.recsourceConsultForm.disable();
        this.isView = true;
        (<any>$('#add')).modal('show'); // NOSONAR
    }

    deleteResource() {
        this._service.endpointUrl = NewUrlConfig.EndPoint.DSDSAction.Contact.DeleteResourceURL;
        this._service.remove(this.resourceID).subscribe(
            response => {
                this.getPage(1);
                this._alertService.success('Resource consult review deleted successfully');
                this.resourceID = null;
                (<any>$(this.deleteresourcepopupid)).modal('hide'); // NOSONAR
            },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                (<any>$(this.deleteresourcepopupid)).modal('hide'); // NOSONAR
            }
        );
    }
    private mergeDateTime(dateobj, timeobj) {
        const Dateobj: any = new Date(dateobj);
        const timeSplit = timeobj.split(':');
        const TimeHour = timeSplit[0];
        const TimeMin = timeSplit[1];

        Dateobj.setHours(TimeHour);
        Dateobj.setMinutes(TimeMin);

        return Dateobj;
    }

    listDropdown() {
        this.selectType$ = this._commonHttpService.getArrayList(
            {
                method: 'get',
                where: {},
                order: 'description ASC' // cw-006 : Ascending order list
            },
                NewUrlConfig.EndPoint.DSDSAction.Contact.GetSelectTypeURL + '?filter').pipe(map(items => {
            return items.map(
                list =>
                    new DropdownModel({
                        text: list.description,
                        value: list.consultreviewusertypekey
                    })
            );
        }));
    }

    getPage(page: number) {
        const source = this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest(
                    {
                        method: 'get',
                        where: { intakeserviceid: this.id },
                        page: this.paginationInfo.pageNumber,
                        limit: this.paginationInfo.pageSize,
                    }),
                NewUrlConfig.EndPoint.DSDSAction.Contact.GetResourceConsultURL + '?filter'
            ).pipe(map((result: any) => {
                return {
                    data: result,
                    count: result.length > 0 ? result[0].totalcount : 0,
                    canDisplayPager: result.length > 0 ? result[0].totalcount > this.paginationInfo.pageSize : false
                };
            }),share(),);
        this.resourceList$ = source.pipe(pluck('data'));
        if (page === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }


    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

}
