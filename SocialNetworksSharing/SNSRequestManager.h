//
//  SNSRequestManager.h
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 06.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNSVkontakte.h"
#import "SNSUser.h"

@interface SNSRequestManager : NSObject

@property (strong, nonatomic, readonly) SNSUser* currentUser;


+ (SNSRequestManager*) sharedManager;

- (void) authorizeUser: (void(^) (SNSUser* user)) completion;

@end



