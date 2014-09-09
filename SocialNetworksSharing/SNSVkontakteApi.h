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

@protocol SNSVkApiDelegate <NSObject>

@optional
-(void)dataOfProfile:(NSDictionary *)data;
-(void)madeShare:(NSURL *)url;

@end

@interface SNSVkontakteApi : NSObject <SLVTokenSocialManagerDelegate, SNSSocialNetwork>


@property(nonatomic) Users * user;
@property(nonatomic) id<SNSVkApiDelegate> delegate;
@property(nonatomic) id<SNSSocialNetworkDataSource> dataSource;
@property(nonatomic) __block NSDictionary * response;
@property(nonatomic) SLVTokenSocialManager *oauth;


//@property(nonatomic) SLVOAuthSetup * setOauth;

@end
