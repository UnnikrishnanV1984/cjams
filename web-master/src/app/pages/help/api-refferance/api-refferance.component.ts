import { Component, OnInit } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'api-refferance',
    templateUrl: './api-refferance.component.html',
    styleUrls: ['./api-refferance.component.scss'],
    standalone: false
})
export class ApiRefferanceComponent implements OnInit {
    safeUrl!: SafeResourceUrl;
    constructor(public sanitizer: DomSanitizer) {}

    ngOnInit() {
        this.safeUrl = this.sanitizer.bypassSecurityTrustResourceUrl(
            'https://welfare.myhcue.co/api-reference'
        );
    }
}
