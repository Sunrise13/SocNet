//
//  Header.h
//  SocialNetworksSharing
//
//  Created by Ostap R on 12.09.14.
//  Copyright (c) 2014 Ostap R. All rights reserved.
//

#import "SNSSocialNetwork.h"

@class Users;

@protocol SNSOAuthSetupDelegate <NSObject>

@required

-(void)userData:(Users *)user;

@end

@protocol SNSOAuthSetupProtocol <NSObject>

@required

-(void)setup;
@property(nonatomic, weak) id<SNSOAuthSetupDelegate> delegate;

@end

