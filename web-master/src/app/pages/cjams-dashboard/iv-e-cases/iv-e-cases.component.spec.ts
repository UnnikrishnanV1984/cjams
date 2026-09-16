import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IvECasesComponent } from './iv-e-cases.component';

describe('DashPreIntakeComponent', () => {
  let component: IvECasesComponent;
  let fixture: ComponentFixture<IvECasesComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IvECasesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IvECasesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
