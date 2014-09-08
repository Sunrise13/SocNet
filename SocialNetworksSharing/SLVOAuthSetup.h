//
//  SLVOAuthSetup.h
//  SocialSharing
//
//  Created by Ostap R on 19.08.14.
//  Copyright (c) 2014 SoftServe LV-120. All rights reserved.
//

#import "SNSSocialNetworkType.h"
@class Users;


@protocol SLVOAuthSetupDelegate <NSObject>

@required
-(void)userData:(Users *)user;

@end

@interface SLVOAuthSetup : UIViewController <UIWebViewDelegate>

@property (nonatomic) __block id<SLVOAuthSetupDelegate> delegate;

-(void)setupWithServiceType:(SNSSocialNetworkType)serviceType;

@end



