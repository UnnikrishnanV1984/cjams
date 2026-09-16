import { NgModule, ModuleWithProviders } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FieldPermissionDirective } from './directives/field-permission.directive';
import { SharedDirectivesModule } from './directives/shared-directives.module';

const DIRECTIVES = [
    FieldPermissionDirective
];

@NgModule({
  imports: [
    CommonModule,
    SharedDirectivesModule
  ],
  declarations: [],
  providers: [
    ...DIRECTIVES,
  ],
})
export class DirectiveModule {
  static forRoot(): ModuleWithProviders<DirectiveModule> {
    return {
      ngModule: DirectiveModule,
      providers: [
        ...DIRECTIVES,
      ],
    };
  }
}

