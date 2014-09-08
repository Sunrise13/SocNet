//
//  SNSNetworkFactory.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 06.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import "SNSNetworkFactory.h"
#import "SNSNetworksViewController.h"
#import "SNSFacebook.h"
#import "SLVLinkedInApi.h"
#import "SNSGooglePlusViewController.h"

@implementation SNSNetworkFactory

-(id) getNetwork:(SNSSocialNetworkType) type
{
    
    switch (type)
    {
        case SNSSocialNetworkTypeFacebook:
            return [[SNSFacebook alloc]  init];
            break;
        case SNSSocialNetworkTypeLinkedIn:
            return [[SLVLinkedInApi alloc] init];
            break;
        case SNSSocialNetworkTypeTwitter:
            break;
        case SNSSocialNetworkTypeVkontakte:
            break;
        case SNSSocialNetworkTypeGooglePlus:
            return [[SNSGooglePlusViewController alloc] init];
    }
    return nil;
} 

-(void) share
{
}

@end
