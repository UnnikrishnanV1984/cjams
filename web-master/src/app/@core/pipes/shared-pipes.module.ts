import { CommonModule, CurrencyPipe } from '@angular/common';
import { NgModule } from '@angular/core';

import { KeysPipe } from './array-keys.pipe';
import { ValidDateFormatPipe } from './custom-date.pipe';
import { FilterPipe } from './filter.pipe';
import { OrderByPipe } from './orderby.pipe';
import { NoDataDisplayPipe } from './table-no-data.pipe';
import { SearchFormArrayPipe } from './custom-formarray-filter.pipe';
import { CjamsTitleCasePipe } from './cjams-title-case.pipe';
import { EllipsisPipe } from './ellipsis.pipe';
import { FilterNoMatchPipe } from './filter-no-match.pipe';
import { MaskPipe } from './ssnMask.pipe';
import { MaskPipessn } from './maskssnpipe.pipe';
import { MaskZipPipe } from './zipcode.pipe';
import { AliasDisplayPipe } from './alias-display.pipe';
import { CountDownTimer } from './count-down.pipe';
import { CjamsCurrencyPipe } from './cjams-currency.pipe';
import { FormatUrlPipe } from './format-url.pipe';
import { PhonenumberSortPipe } from './phonenumber-sort.pipe';
@NgModule({
    imports: [CommonModule],
    declarations: [
        ValidDateFormatPipe, 
        OrderByPipe, 
        KeysPipe, 
        NoDataDisplayPipe, 
        FilterPipe, 
        SearchFormArrayPipe,
        CjamsTitleCasePipe,
        EllipsisPipe,
        FilterNoMatchPipe,
        MaskPipe,
        MaskZipPipe,
        AliasDisplayPipe,
        CountDownTimer,
        CjamsCurrencyPipe,
        FormatUrlPipe,
        PhonenumberSortPipe,
        MaskPipessn
    ],
    exports: [
        ValidDateFormatPipe,
        OrderByPipe, 
        KeysPipe, 
        NoDataDisplayPipe, 
        FilterPipe, 
        SearchFormArrayPipe,
        CjamsTitleCasePipe, 
        EllipsisPipe,
        FilterNoMatchPipe,
        MaskPipe,
        MaskZipPipe,
        AliasDisplayPipe,
        CountDownTimer,
        CjamsCurrencyPipe,
        FormatUrlPipe,
        PhonenumberSortPipe,
        MaskPipessn
    ],
    providers: [
        ValidDateFormatPipe,
        OrderByPipe, 
        KeysPipe, 
        NoDataDisplayPipe, 
        FilterPipe, 
        SearchFormArrayPipe, 
        EllipsisPipe,
        FilterNoMatchPipe,
        MaskPipe,
        MaskZipPipe,
        CurrencyPipe,
        FormatUrlPipe,
        PhonenumberSortPipe,
        MaskPipessn
    ]
})
export class SharedPipesModule {}
