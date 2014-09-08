//
//  SLVLinkedInViewController.h
//  Social Networks
//
//  Created by Ostap R on 18.08.14.
//  Copyright (c) 2014 SoftServe Lv-120. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNSSocialNetwork.h"

@class SLVLinkedInApi;
@class SLVViewController;

@interface SLVLInShareViewController : UIViewController <SNSSocialNetwork>

@property (nonatomic) SLVViewController *controllerWithData;
@property (nonatomic) SLVLinkedInApi * api;
@property (nonatomic) UIWebView *webView;
-(void)shareText:(NSString *)text image:(UIImage *)image;
@end
