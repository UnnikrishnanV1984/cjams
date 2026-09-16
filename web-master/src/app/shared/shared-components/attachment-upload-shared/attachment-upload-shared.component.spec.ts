import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AttachmentUploadSharedComponent } from './attachment-upload-shared.component';

describe('AttachmentUploadSharedComponent', () => {
  let component: AttachmentUploadSharedComponent;
  let fixture: ComponentFixture<AttachmentUploadSharedComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AttachmentUploadSharedComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AttachmentUploadSharedComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
