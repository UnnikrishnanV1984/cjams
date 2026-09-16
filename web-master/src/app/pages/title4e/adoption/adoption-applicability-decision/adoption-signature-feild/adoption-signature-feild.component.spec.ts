import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionSignatureFeildComponent } from './adoption-signature-feild.component';

describe('AdoptionSignatureFeildComponent', () => {
  let component: AdoptionSignatureFeildComponent;
  let fixture: ComponentFixture<AdoptionSignatureFeildComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionSignatureFeildComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionSignatureFeildComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
