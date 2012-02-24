//
//  PicFrame.h
//  nysketch
//
//  Created by gleb dobzhanskiy on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicFrame : NSObject
{
    NSString *description;
    NSString *picId;
    NSString *nickName;
    UIImage  *frameImage;
}

@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *picId;
@property (nonatomic, retain) NSString *nickName;
@property (nonatomic, retain) UIImage *frameImage;




@end
