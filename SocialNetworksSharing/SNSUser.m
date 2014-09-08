//
//  SNSUser.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 06.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import "SNSUser.h"

@implementation SNSUser


- (id) initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super init];
    if (self)
    {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        
        NSString* urlString = [responseObject objectForKey:@"photo_50"];
        if (urlString)
        {
            self.imageURL = [NSURL URLWithString:urlString];
        }
        
    }
    return self;
}

@end
