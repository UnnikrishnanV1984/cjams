import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ContactlogComponent } from './contactlog.component';

describe('ContactlogComponent', () => {
  let component: ContactlogComponent;
  let fixture: ComponentFixture<ContactlogComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ContactlogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContactlogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
