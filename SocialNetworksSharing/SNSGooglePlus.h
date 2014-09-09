//
//  SNSGooglePlus.h
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 08.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <Foundation/Foundation.h>
#import <GooglePlus/GooglePlus.h>
#import "SNSNetworksViewController.h"
#import "SNSSocialNetwork.h"

@interface SNSGooglePlus : NSObject <GPPSignInDelegate, SNSSocialNetwork, GPPShareDelegate>

@property(assign, nonatomic) BOOL authorised;
@property(weak, nonatomic) SNSNetworksViewController * controller;
@property(weak, nonatomic) GPPSignIn*signIN;


@end