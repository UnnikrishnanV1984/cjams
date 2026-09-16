import { Component, OnInit } from '@angular/core';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'case-closure',
    templateUrl: './case-closure.component.html',
    styleUrls: ['./case-closure.component.scss'],
    standalone: false
})
export class CaseClosureComponent implements OnInit {
    caseDetailsShow!: boolean;
    
    ngOnInit() {
        this.caseDetailsShow = false;
    }
    cancelStatus() {
        this.caseDetailsShow = false;
    }
    addCaseHistory() {
        this.caseDetailsShow = true;
    }
}
