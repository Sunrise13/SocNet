//
//  SNSLinkedInOAuthSetup.h
//  SocialNetworksSharing
//
//  Created by Ostap R on 12.09.14.
//  Copyright (c) 2014 Ostap R. All rights reserved.
//

#import "SNSLinkedInOAuthWebLoginViewController.h"
#import "SNSOAuthSetupProtocol.h"

@interface SNSLinkedInOAuthSetup : NSObject <SNSOAuthSetupProtocol>

@property (nonatomic, weak) __block id<SNSOAuthSetupDelegate> delegate;
@property (nonatomic) SNSLinkedInOAuthWebLoginViewController * UIWebViewController;
@property (nonatomic) UIWebView * webView;
-(void)setup;



@end








