//
//  SNSUser.h
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 06.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNSUser : NSObject

@property (nonatomic,strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) UIImage* imageURL;

- (id) initWithServerResponse: (NSDictionary*) responseObject;

@end
