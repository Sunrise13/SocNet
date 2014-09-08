//
//  SNSPostData.h
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 08.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNSViewController.h"
#import "SNSSocialNetworkDataSource.h"


@interface SNSPostData : NSObject <SNSSocialNetworkDataSource>

@property (nonatomic, copy) NSString * postText;
@property (nonatomic, strong) UIImage * postImage;

+ (id)sharedPostData;
-(void) setWithText: (NSString*) text;
-(void) setWithImage: (UIImage*) image;





@end
