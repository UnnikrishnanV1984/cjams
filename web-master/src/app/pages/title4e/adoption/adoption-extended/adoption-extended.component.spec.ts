import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionExtendedComponent } from './adoption-extended.component';

describe('AdoptionExtendedComponent', () => {
  let component: AdoptionExtendedComponent;
  let fixture: ComponentFixture<AdoptionExtendedComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionExtendedComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionExtendedComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
