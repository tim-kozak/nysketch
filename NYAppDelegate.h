//
//  AppDelegate.h
//  nysketch
//
//  Created by gleb dobzhanskiy on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface NYAppDelegate : UIResponder <UIApplicationDelegate>
{
    
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

+ (NYAppDelegate*) AppDelegate;

@end
