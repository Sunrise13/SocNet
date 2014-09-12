//
//  SNSOAuthSetupFactory.m
//  SocialNetworksSharing
//
//  Created by Ostap R on 12.09.14.
//  Copyright (c) 2014 Ostap R. All rights reserved.
//

#import "SNSOAuthSetupFactory.h"
#import "SNSSocialNetworkType.h"
#import "SNSOAuthSetupProtocol.h"
#import "SNSLinkedInOAuthSetup.h"

@implementation SNSOAuthSetupFactory

-(id<SNSOAuthSetupProtocol>)getSetupWithType:(SNSSocialNetworkType)type
{
    switch(type)
    {
        case SNSSocialNetworkTypeLinkedIn:
            return [SNSLinkedInOAuthSetup new];
            break;
        case SNSSocialNetworkTypeVkontakte:
            //Enter your code Alexandra
            break;
        default: NSLog(@"Add your service to switch statment above");
            [NSException raise:@"No OAuthSetup object" format:@"No OAuthSetup object for SNSSocialNetworkType with number: %i\n. Add OAuthSetup object to switch-case statment for service", type];
            break;
    }
    return nil;
}

@end
