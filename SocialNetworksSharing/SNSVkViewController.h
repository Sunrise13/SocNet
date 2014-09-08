//
//  SNSVkViewController.h
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 06.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNSNetworksViewController.h"

@interface VkToken : NSObject
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSDate* expirationDate;
@property (strong, nonatomic) NSString* userID;
@end

typedef void(^LoginCompletionBlock)(VkToken* token);

@interface SNSVkViewController : UIViewController

@property (weak, nonatomic) UIWebView * authView;
-(id) initWithBlock:(LoginCompletionBlock) completionBlock;

@end
