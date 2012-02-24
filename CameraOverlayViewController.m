
//
//  CameraOverlayViewController.m
//  nysketch
//
//  Created by Paul Nadolinskiy on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CameraOverlayViewController.h"

@implementation CameraOverlayViewController
@synthesize bubblePosition;
@synthesize bubbleTextView;
@synthesize bubbleImageView;
@synthesize bubbleHolder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (BubblePositionTop == bubblePosition) {
            bubbleHolder.frame = CGRectMake(0, 0, bubbleHolder.frame.size.width, bubbleHolder.frame.size.height);
            bubbleImageView.image = [UIImage imageNamed:@"speechBubbleUp.png"];
        } else {
            bubbleHolder.frame = CGRectMake(0, 270, bubbleHolder.frame.size.width, bubbleHolder.frame.size.height);
            bubbleImageView.image = [UIImage imageNamed:@"speechBubbleDown.png"];
        }
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    bubbleTextView.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"caption"];
    if (BubblePositionTop == bubblePosition) {
        bubbleHolder.frame = CGRectMake(0, 0, bubbleHolder.frame.size.width, bubbleHolder.frame.size.height);
        bubbleImageView.image = [UIImage imageNamed:@"speechBubbleUp.png"];
    } else {
        bubbleHolder.frame = CGRectMake(0, 270, bubbleHolder.frame.size.width, bubbleHolder.frame.size.height);
        bubbleImageView.image = [UIImage imageNamed:@"speechBubbleDown.png"];
    }
}

- (void)viewDidUnload
{
    [self setBubbleTextView:nil];
    [self setBubbleImageView:nil];
    [self setBubbleHolder:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [bubbleTextView release];
    [bubbleImageView release];
    [bubbleHolder release];
    [super dealloc];
}
@end
