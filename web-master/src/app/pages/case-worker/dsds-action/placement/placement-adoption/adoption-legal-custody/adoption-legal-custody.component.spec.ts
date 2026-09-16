import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionLegalCustodyComponent } from './adoption-legal-custody.component';

describe('AdoptionLegalCustodyComponent', () => {
  let component: AdoptionLegalCustodyComponent;
  let fixture: ComponentFixture<AdoptionLegalCustodyComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionLegalCustodyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionLegalCustodyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
