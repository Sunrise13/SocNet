//
//  SNSLinkedInShare.h
//  SocialNetworksSharing
//
//  Created by Ostap R on 10.09.14.
//  Copyright (c) 2014 Ostap R. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNSSocialNetwork.h"
#import <REComposeViewController.h>

@class REComposeViewController;

@interface SNSLinkedInShare : NSObject <SNSSocialNetwork>

@property(nonatomic) REComposeViewController * shareViewController;
-(void)share;

@end
