import { NgModule, ModuleWithProviders } from '@angular/core';
import { CommonModule } from '@angular/common';
/* Entities */
import { AppUser } from './entities/authDataModel';

const ENTITIES = [
  AppUser
];

@NgModule({
  imports: [
    CommonModule,
  ],
  providers: [
    ...ENTITIES,
  ],
})
export class EntityModule {
  static forRoot(): ModuleWithProviders<EntityModule> {
    return {
      ngModule: EntityModule,
      providers: [
        ...ENTITIES,
      ],
    };
  }
}

