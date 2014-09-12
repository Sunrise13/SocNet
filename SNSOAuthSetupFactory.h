//
//  SNSOAuthSetupFactory.h
//  SocialNetworksSharing
//
//  Created by Ostap R on 12.09.14.
//  Copyright (c) 2014 Ostap R. All rights reserved.
//
#import "SNSSocialNetworkType.h"
#import "SNSOAuthSetupProtocol.h"



@interface SNSOAuthSetupFactory : NSObject

-(id<SNSOAuthSetupProtocol>)getSetupWithType:(SNSSocialNetworkType)type;

@end
