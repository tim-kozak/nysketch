//
//  ViewController.m
//  nysketch
//
//  Created by gleb dobzhanskiy on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import "ViewController.h"
#include <QuartzCore/QuartzCore.h>

@implementation ViewController

@synthesize isCancelled, curPhotoView, uploadButton, cancelButton, takenPhoto, curJoin, imagePicker, descriptionView, busyView;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    isCancelled = YES;
    
    self.imagePicker = [[NYImagePicker alloc] init];
    self.imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        cameraOverlay = [[CameraOverlayViewController alloc] init];
    } else {
        self.imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"author"])
    {
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"author"]);
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]);
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"caption"]);

        [[NSUserDefaults standardUserDefaults] objectForKey:@"author"];
        [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
        [[NSUserDefaults standardUserDefaults] objectForKey:@"caption"];
        
//        [self showImagePicker];
        [self performSelector:@selector(showImagePicker) withObject:nil afterDelay:0.1];
    }
    else 
    {
        curJoin = [[JoinController alloc] initWithNibName:@"JoinController" bundle:nil];
        
        [self.view addSubview:curJoin.view];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showImagePicker) name:@"readyForImage" object:nil];

    [self addRoundedCornersOfView:curPhotoView withRadious:5 andBorder:3 color:[UIColor blackColor]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!isCancelled)
    {    
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.takenPhoto = [info objectForKey:@"UIImagePickerControllerOriginalImage"]; 
    [self.curPhotoView setImage:self.takenPhoto];
    self.isCancelled = YES;
    [self dismissModalViewControllerAnimated:YES]; 
    
    UIView *photo = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 426)] autorelease];
    UIImageView *pv = [[[UIImageView alloc] initWithImage:takenPhoto] autorelease];
    pv.frame = CGRectMake(0, 0, 320, 426);
    [photo addSubview:pv];
    [photo addSubview:cameraOverlay.view];
    
    UIGraphicsBeginImageContext(photo.bounds.size);
    [photo.layer renderInContext:UIGraphicsGetCurrentContext()];
    //image with bubble
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); 
    
    [self.curPhotoView setImage:img];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
   // [picker release];
    isCancelled = YES;
    [self dismissModalViewControllerAnimated:YES];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) onUpload:(id)sender
{
    [self showEditBar];
    ASIFormDataRequest *prequest = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.94:3002/phrases/%@.json", [[NSUserDefaults standardUserDefaults] objectForKey:@"id"]]]] autorelease];
    

    [prequest setPostValue:@"put" forKey:@"_method"];
    
    
    [prequest setData:UIImageJPEGRepresentation(curPhotoView.image, 1) withFileName:@"photo" andContentType:@"image/JPEG" forKey:@"phrase[photo]"];
    
    
    
    
    [prequest setRequestMethod:@"PUT"];
    //[prequest setCompletionBlock:^{[self onUploaded];}];
    [prequest setDelegate:self];
    [prequest startAsynchronous];
    
    
    
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
    [self hiddeEditBar];
    NSLog(@"Uploaded successfully");
//    NSLog(@"%@", [request responseString]);
    
//    UIViewController *webHolder = [[[UIViewController alloc] init] autorelease];
//    UIWebView *wv = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
//    [webHolder.view addSubview:wv];
//    NSURLRequest *showcaseRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.2.94:3002/phrases/showcase"]];
//    [wv loadRequest:showcaseRequest];
//    [self presentModalViewController:webHolder animated:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://192.168.2.94:3002/phrases/showcase"]];
    
}    

- (IBAction)onCancel:(id)sender
{
    [self showImagePicker];
}

- (void) showImagePicker
{

    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"caption"]);
    [self.descriptionView setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"caption"]];

    NSString *nick = [[NSUserDefaults standardUserDefaults] objectForKey:@"author"];
    NSLog(@"%@", nick);


    
    cameraOverlay.bubblePosition = BubblePositionTop;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.cameraOverlayView = cameraOverlay.view;
        
    }
    
    
    [self presentModalViewController:self.imagePicker animated:YES];
    
    
}


- (void) showEditBar
{
    busyView.alpha = 0;
    busyView.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.300000011920929];
    busyView.alpha = 0.7;
    [UIView commitAnimations];
    
}

-(void) hiddeEditBar
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.300000011920929];
    busyView.alpha = 0;
    [UIView commitAnimations];
    busyView.hidden = YES;
    
}

- (void) onUploaded
{
    [[[[UIAlertView alloc] initWithTitle:@"UPLOADED!" message:@"Image has been uploaded successfully!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease] show];
    NSLog(@"Uploaded successfully");
}

- (void) addRoundedCornersOfView:(UIView *)viev withRadious:(int)size andBorder:(int)width color:(UIColor *)color
{
    CALayer * l = [viev layer];
	[l setMasksToBounds:YES];
	[l setCornerRadius:size];
	
	// You can even add a border
	[l setBorderWidth:width];
	[l setBorderColor:[color CGColor]];
}

-(void)dealloc
{
    [cameraOverlay dealloc];
    [super dealloc];
}


@end
