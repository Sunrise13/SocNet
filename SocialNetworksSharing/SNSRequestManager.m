//
//  SNSRequestManager.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 06.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import "SNSRequestManager.h"
#import "SNSVkViewController.h"
#import "AFNetworking.h"

@interface SNSRequestManager()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;


@end

@implementation SNSRequestManager

+ (SNSRequestManager*) sharedManager
{
    static SNSRequestManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SNSRequestManager alloc] init];
        
    });
    return manager;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        NSURL* url = [[NSURL alloc] initWithString: @"https://api.vk.com/method/"];
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    }
    return self;
}


@end


