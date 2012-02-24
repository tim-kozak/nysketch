//
//  CameraOverlayViewController.h
//  nysketch
//
//  Created by Paul Nadolinskiy on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraOverlayViewController : UIViewController
{
    int bubblePosition;
}

@property int bubblePosition;
@property (retain, nonatomic) IBOutlet UITextView *bubbleTextView;
@property (retain, nonatomic) IBOutlet UIImageView *bubbleImageView;
@property (retain, nonatomic) IBOutlet UIView *bubbleHolder;

@end

typedef enum {
    BubblePositionTop= 0,
    BubblePositionBottom
} BubblePosition;