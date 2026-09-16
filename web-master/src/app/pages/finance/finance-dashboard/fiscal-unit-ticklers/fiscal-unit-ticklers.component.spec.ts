import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FiscalUnitTicklersComponent } from './fiscal-unit-ticklers.component';

describe('FiscalUnitTicklersComponent', () => {
  let component: FiscalUnitTicklersComponent;
  let fixture: ComponentFixture<FiscalUnitTicklersComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FiscalUnitTicklersComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FiscalUnitTicklersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
