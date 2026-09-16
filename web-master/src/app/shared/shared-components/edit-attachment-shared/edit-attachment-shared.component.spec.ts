import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { EditAttachmentSharedComponent } from './edit-attachment-shared.component';

describe('EditAttachmentSharedComponent', () => {
  let component: EditAttachmentSharedComponent;
  let fixture: ComponentFixture<EditAttachmentSharedComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ EditAttachmentSharedComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(EditAttachmentSharedComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
