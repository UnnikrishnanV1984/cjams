import { Component, OnInit } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'report',
    templateUrl: './report.component.html',
    styleUrls: ['./report.component.scss'],
    standalone: false
})
export class ReportComponent implements OnInit {
    // reports: any;
    safeUrl: SafeResourceUrl = '';
    constructor(public sanitizer: DomSanitizer) {}

    ngOnInit() {
        // this.reports = <any>reports;
        // this.safeUrl = this.sanitizer.bypassSecurityTrustResourceUrl('http://52.230.81.18:8080/SpagoBI/servlet/AdapterHTTP?PAGE=LoginPage&userID=biadmin&password=biadmin&NEW_SESSION=TRUE');
        // this.safeUrl = this.sanitizer.bypassSecurityTrustResourceUrl(
        //     'https://welfare.myhcue.co/SpagoBI/servlet/AdapterHTTP?PAGE=LoginPage&userID=biadmin&password=biadmin&NEW_SESSION=TRUE'
        // );
    }
    
}
