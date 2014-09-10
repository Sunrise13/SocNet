//
//  SLVLinkedInApi.h
//  Social Networks
//
//  Created by Ostap R on 18.08.14.
//  Copyright (c) 2014 SoftServe Lv-120. All rights reserved.
//

#import "Users.h"
#import "SLVTokenSocialManager.h"
#import "SNSPostData.h"

@class REComposeViewController;
@protocol SLVLinkedInApiDelegate <NSObject>

@optional
-(void)dataOfProfile:(NSDictionary *)data;
-(void)madeShare:(NSURL *)url;

@end

@interface SLVLinkedInApi : NSObject <SLVTokenSocialManagerDelegate>


@property(nonatomic) Users * user;
@property(nonatomic) id<SLVLinkedInApiDelegate> delegate;
@property(nonatomic) id<SNSSocialNetworkDataSource> dataSource;

@property(nonatomic) SLVTokenSocialManager *oauth;

-(NSDictionary *)getProfile;
-(void)share;
-(void)settingDataSource:(id<SNSSocialNetworkDataSource>)dataSource;

@end
