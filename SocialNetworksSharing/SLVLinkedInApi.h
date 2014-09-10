//
//  SLVLinkedInApi.h
//  Social Networks
//
//  Created by Ostap R on 18.08.14.
//  Copyright (c) 2014 SoftServe Lv-120. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SLVViewController.h"
#import "Users.h"
#import "SLVOAuthSetup.h"
#import "SLVTokenSocialManager.h"
#import "SNSSocialNetwork.h"
#import "SNSPostData.h"

@class REComposeViewController;
@protocol SLVLinkedInApiDelegate <NSObject>

@optional
-(void)dataOfProfile:(NSDictionary *)data;
-(void)madeShare:(NSURL *)url;

@end

@interface SLVLinkedInApi : NSObject <SLVTokenSocialManagerDelegate, SNSSocialNetwork>


@property(nonatomic) Users * user;
@property(nonatomic) id<SLVLinkedInApiDelegate> delegate;
@property(nonatomic) id<SNSSocialNetworkDataSource> dataSource;
@property(nonatomic) __block NSDictionary * response;
@property(nonatomic) SLVTokenSocialManager *oauth;

-(NSDictionary *)getProfile;
//-(void)makeShare;
@end
