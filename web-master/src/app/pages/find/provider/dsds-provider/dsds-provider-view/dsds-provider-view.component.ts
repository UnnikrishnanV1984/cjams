
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { Observable } from 'rxjs';
import {
    ProviderAgencyListing, ProviderAgencyTaxListing, ProviderNonAgreementDetail,
    ProviderNonAgreementMedicailDetail, AgencyAddress, AgencyServiceListing
} from '../../../_entities/find-entity.module';
import { FindUrlConfig } from '../../../find.url.config';

declare let $: any;

@Component({
    selector: 'dsds-provider-view',
    templateUrl: './dsds-provider-view.component.html',
    styleUrls: ['./dsds-provider-view.component.scss'],
    standalone: false
})
export class DsdsProviderViewComponent implements OnInit {

    constructor(private route: ActivatedRoute, private _commonService: CommonHttpService) {
        this.agencyListingDetails$ = new Observable<ProviderAgencyListing>();
    }

    id!: string;
    agencyListingDetails$: Observable<ProviderAgencyListing>;
    agencyNpiNTaxonomy$!: Observable<ProviderNonAgreementDetail>;
    agencyAddressDetails$!: Observable<AgencyAddress[]>;
    agencyServiceDetails$!: Observable<AgencyServiceListing[]>;
    agencyTaxListing!: ProviderAgencyTaxListing;
    federalTaxList = {
        'taxno26': '',
        'taxno28': '',
        'taxno29': '',
        'taxno49': '',
        'taxno89': ''
    };

    ngOnInit() {
        this.id = this.route.snapshot.params['id'];
        this.getAgencyAddressListingDetails();
        this.getAgencyListingDetails();
        this.getAgencyServiceListingDetails();
        this.showProviderViewModel();
    }

    showProviderViewModel() {
       $('#dsdsProvider-View-Details').modal('show');
    }

    getAgencyListingDetails() {
        const url = FindUrlConfig.EndPoint.ProviderSearch.agency;

        const source = this._commonService.getArrayList(
            {
                include: ['Providernonagreementmedicaiddetail', 'Providernonagreementdetail'],
                where: { agencyid: this.id },
                method: 'get'
            }
            , url).pipe(map(res => new ProviderAgencyListing(res[0])),share(),);
        this.agencyListingDetails$ = source;
        this.agencyNpiNTaxonomy$ = source.pipe(pluck('Providernonagreementdetail'),map(
            res => new ProviderNonAgreementDetail(res[0])),);

        source.pipe(pluck('Providernonagreementmedicaiddetail'),map(
            (res: ProviderNonAgreementMedicailDetail[]) => {
                res.forEach(data => {
                    if (data.medicaidtypekey === '26') {
                        this.federalTaxList.taxno26 = data.value;
                    }
                    if (data.medicaidtypekey === '28') {
                        this.federalTaxList.taxno28 = data.value;
                    }
                    if (data.medicaidtypekey === '29') {
                        this.federalTaxList.taxno29 = data.value;
                    }
                    if (data.medicaidtypekey === '49') {
                        this.federalTaxList.taxno49 = data.value;
                    }
                    if (data.medicaidtypekey === '89') {
                        this.federalTaxList.taxno89 = data.value;
                    }
                });
            }),);

    }

    getAgencyAddressListingDetails() {
        const url = FindUrlConfig.EndPoint.ProviderSearch.agencyaddresses;
        this.agencyAddressDetails$ = this._commonService.getArrayList(
            {
                include: 'Agencyaddresstype',
                where: { agencyid: this.id },
                method: 'get'
            }
            , url).pipe(map((data: AgencyAddress[]) => {
                return data;
            }));
    }

    getAgencyServiceListingDetails() {
        const url = FindUrlConfig.EndPoint.ProviderSearch.agencyservices;
        this.agencyServiceDetails$ = this._commonService.getArrayList(
            {
                include: 'Service',
                where: { agencyid: this.id },
                method: 'get'
            }
            , url).pipe(map((data: AgencyServiceListing[]) => {
                return data;
            }));
    }
}
