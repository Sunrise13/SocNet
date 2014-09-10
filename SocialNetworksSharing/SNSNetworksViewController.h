//
//  SNSNetworksViewController.h
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 06.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SNSViewController.h"
#import <Social/Social.h>
#import "SNSNetworkFactory.h"


@interface  SNSNetworksViewController : UIViewController

@property (strong, nonatomic) SNSNetworkFactory* network;
@property (strong, nonatomic) id<SNSSocialNetwork> some;

//
/////////////////////////////////////////////////////////////////
/////GOOGLE +                                                ////
//@property(strong, nonatomic) SNSGoogleShare * GoogleShar;  ////
/////                                                        ////
/////TWITTER ^                                               ////
//@property(strong, nonatomic) SNSTwitterShare *twitterShare;////
/////                                                        ////
/////FaceBook f                                              ////
//@property(strong,nonatomic)SNSFaceBookShare *facebookShare;////
/////                                                        ////
/////VKONTAKTE                                               ////
//@property(strong, nonatomic) SNSVkViewController * VkShare;////
/////////////////////////////////////////////////////////////////
//@property (nonatomic) SNSLInShareViewController * linkedIn;
//SLViewController
@property(strong, nonatomic) UIViewController * mainController;

@end
