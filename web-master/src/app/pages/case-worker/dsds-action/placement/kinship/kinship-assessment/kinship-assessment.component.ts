
import {forkJoin as observableForkJoin,  Observable } from 'rxjs';

import {map, pluck} from 'rxjs/operators';
import { CommonHttpService } from './../../../../../../@core/services/common-http.service';
import { Component, OnInit } from '@angular/core';
import { DropdownModel } from '../../../../../../@core/entities/common.entities';
import { FormGroup, FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { KinshipListDetails } from '../../_entities/placement.model';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { DataStoreService } from '../../../../../../@core/services';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'kinship-assessment',
    templateUrl: './kinship-assessment.component.html',
    standalone: false
})
export class KinshipAssessmentComponent implements OnInit {
    id!: string;
    caseNumber!: string;
    kinshipForm!: FormGroup;
    currentDate = new Date();
    kinshipListDetails: KinshipListDetails[] = [];
    programDropDownDetails$!: Observable<DropdownModel[]>;
    subprogramDropDownDetails$!: Observable<DropdownModel[]>;
    constructor(private _commonHttpService: CommonHttpService, private _alertService: AlertService, private _formBuilder: FormBuilder, private route: ActivatedRoute,
        private _dataStoreService: DataStoreService) {}

    ngOnInit() {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.caseNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.loadDropDown();
        this.getKinshipList();
        this.kinshipForm = this._formBuilder.group({
            programareakey: '',
            subprogramareakey: '',
            startdate: '',
            enddate: '',
            kinshipcareprogramid: null
        });
    }
    private loadDropDown() {
        const source = observableForkJoin([
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    where: { referencetypeid: 11, teamtypekey: null }
                },
                'referencetype/gettypes' + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    where: { referencetypeid: 12, teamtypekey: null }
                },
                'referencetype/gettypes' + '?filter'
            )
        ]).pipe(map((result) => {
            return {
                program: result[0].map(
                    (res) =>
                        new DropdownModel({
                            text: res.description,
                            value: res.ref_key
                        })
                ),
                subprogram: result[1].map(
                    (resp) =>
                        new DropdownModel({
                            text: resp.description,
                            value: resp.ref_key
                        })
                )
            };
        }));
        this.programDropDownDetails$ = source.pipe(pluck('program'));
        this.subprogramDropDownDetails$ = source.pipe(pluck('subprogram'));
    }
    getKinshipList() {
        this._commonHttpService.getArrayList({ method: 'get', where: { intakeserviceid: this.id } }, 'kinshipcareprogram/kinshipcarelist?filter').subscribe((res) => {
            this.kinshipListDetails = res;
        });
    }
    kinshipSave(model: any) {
        const kinshipSaveObject = Object.assign(
            {
                intakeserviceid: this.id
            },
            model
        );
        this._commonHttpService.create(kinshipSaveObject, 'kinshipcareprogram/addupdate').subscribe(
            (res) => {
                this.getKinshipList();
                this.kinshipForm.reset();
                this._alertService.success('Kinship saved successfully');
            },
            (err) => {
                this.kinshipForm.reset();
            }
        );
    }
    editKinshp(model: any) {
        this.kinshipForm.patchValue(model);
    }
    deleteKinshp(kinshipId: any) {
        this._commonHttpService
            .patch(
                kinshipId,
                {
                    activeflag: 0
                },
                'kinshipcareprogram'
            )
            .subscribe(
                (res) => {
                    this.getKinshipList();
                    this._alertService.success('Kinship deleted successfully');
                }
            );
    }
}
