//
//  ViewController.h
//  nysketch
//
//  Created by gleb dobzhanskiy on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoinController.h"
#import "PicFrame.h"
#import "NYImagePicker.h"
#import "NYAppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import "CameraOverlayViewController.h"
#import <QuartzCore/QuartzCore.h>

@class JoinController;

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    BOOL isCancelled;
    UIImage *takenPhoto;
    UIImageView *curPhotoView;
    UIButton *uploadButton;
    UIButton *cancelButton;
    JoinController *curJoin;
    UIImagePickerController *imagePicker;
    UITextView *descriptionView;
    CameraOverlayViewController *cameraOverlay;
    UIView *busyView;
}

@property (nonatomic) BOOL isCancelled;
@property (nonatomic, retain) UIImage *takenPhoto;
@property (nonatomic, retain) IBOutlet UIImageView *curPhotoView;
@property (nonatomic, retain) IBOutlet UIButton *uploadButton;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;
@property (nonatomic, retain) JoinController *curJoin;
@property (nonatomic, retain) UIImagePickerController *imagePicker;
@property (nonatomic, retain) IBOutlet UITextView *descriptionView; 
@property (nonatomic, retain) IBOutlet UIView *busyView;

- (IBAction)onUpload:(id)sender;
- (IBAction)onCancel:(id)sender;

- (void) showImagePicker;
- (void) onUploaded;

- (IBAction)showEditBar;
- (IBAction)hiddeEditBar;
- (void) addRoundedCornersOfView:(UIView *)viev withRadious:(int)size andBorder:(int)width color:(UIColor *)color;

@end
