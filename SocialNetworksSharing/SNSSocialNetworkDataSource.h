//
//  SNSSocialNetworkDataSource.h
//  SocialNetworksSharing
//
//  Created by Ostap R on 08.09.14.
//  Copyright (c) 2014 Ostap R. All rights reserved.
//

#ifndef SocialNetworksSharing_SNSSocialNetworkDataSource_h
#define SocialNetworksSharing_SNSSocialNetworkDataSource_h

@protocol SNSSocialNetworkDataSource

@optional
-(NSString*)shareText;
-(UIImage*)shareImage;

@end

#endif
