import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { EligibleDetailsComponent } from './eligible-details.component';

describe('EligibleDetailsComponent', () => {
  let component: EligibleDetailsComponent;
  let fixture: ComponentFixture<EligibleDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ EligibleDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(EligibleDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
