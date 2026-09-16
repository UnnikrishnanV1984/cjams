import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';

import { DangerWorker, PersonDetail } from '../../../_entities/involvedperson.data.model';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'involved-person-role-danger-to-worker',
    templateUrl: './involved-person-role-danger-to-worker.component.html',
    styleUrls: ['./involved-person-role-danger-to-worker.component.scss']
})
export class InvolvedPersonRoleDangerToWorkerComponent implements OnInit {
    @Input() dangerWorker: DangerWorker[] = [];
    @Input() dangerPersonFormGroup: FormGroup;
    @Input() person$: Observable<PersonDetail>;
    dangerToWorkerFormGroup: FormGroup;
    personId: string;
    danger?: number;
    constructor(private formBuilder: FormBuilder, route: ActivatedRoute) {
        this.personId = route.snapshot.params.personid;
    }

    ngOnInit() {
        this.dangerToWorkerFormBuilderGroup();

        if (this.personId !== '0') {
            this.person$.subscribe(result => {
                this.danger = result.data.personbasicdetails.dangerlevel;
                if (this.danger === 1) {
                    this.dangerToWorkerFormGroup.get('dangerreason').enable();
                }
                this.dangerToWorkerFormGroup.patchValue(
                    result.data.personbasicdetails
                 );
            });
        }
    }

    dangerToWorkerFormBuilderGroup() {
        this.dangerToWorkerFormGroup = this.dangerPersonFormGroup;
        this.dangerToWorkerFormGroup.get('dangerreason').disable();
    }
}
