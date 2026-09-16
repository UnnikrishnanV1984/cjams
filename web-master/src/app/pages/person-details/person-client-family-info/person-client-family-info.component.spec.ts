import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonClientFamilyInfoComponent } from './person-client-family-info.component';

describe('PersonClientFamilyInfoComponent', () => {
  let component: PersonClientFamilyInfoComponent;
  let fixture: ComponentFixture<PersonClientFamilyInfoComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonClientFamilyInfoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonClientFamilyInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
