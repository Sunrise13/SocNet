//
//  SLVTokenSocialManager.h
//  SocialNetworks
//
//  Created by Ostap R on 22.08.14.
//  Copyright (c) 2014 SoftServe Lv-120. All rights reserved.
//

#import "SLVDBManager.h"
#import "SLVOAuthSetup.h"
#import "SNSSocialNetworkType.h"


@class SLVSocialNetwork;
@class Users;

@protocol SLVTokenSocialManagerDelegate <NSObject>

@optional
-(void)userData:(Users *)user;

@end

@interface SLVTokenSocialManager : NSObject <SLVOAuthSetupDelegate>

@property (nonatomic) id <SLVTokenSocialManagerDelegate> delegate;
@property (nonatomic) SNSSocialNetworkType type;

-(void)getUser;
@end
