//
//  SLVOAuthSetup.h
//  SocialSharing
//
//  Created by Ostap R on 19.08.14.
//  Copyright (c) 2014 SoftServe LV-120. All rights reserved.
//

#import "SNSLinkedInOAuthWebLoginViewController.h"
#import "SNSSocialNetworkType.h"
@class Users;


@protocol SLVOAuthSetupDelegate <NSObject>

@required
-(void)userData:(Users *)user;

@end

@interface SLVOAuthSetup :NSObject <UIWebViewDelegate>

@property (nonatomic) __block id<SLVOAuthSetupDelegate> delegate;
@property (nonatomic) SNSLinkedInOAuthWebLoginViewController * UIWebViewController;
@property (nonatomic) UIWebView * webView;
-(void)setupWithServiceType:(SNSSocialNetworkType)serviceType;

@end



