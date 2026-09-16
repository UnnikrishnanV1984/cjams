import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InvestigationComaComponent } from './investigation-coma.component';

describe('InvestigationComaComponent', () => {
  let component: InvestigationComaComponent;
  let fixture: ComponentFixture<InvestigationComaComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InvestigationComaComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InvestigationComaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
