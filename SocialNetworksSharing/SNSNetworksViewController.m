//
//  SNSNetworksViewController.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 06.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//


#import "SNSNetworksViewController.h"
#import "AAShareBubbles.h"
#import "SNSNetworkFactory.h"
#import "SNSFacebook.h"
#import "SNSPostData.h"


@interface SNSNetworksViewController() <AAShareBubblesDelegate>
{
    
}
@end


@implementation SNSNetworksViewController


-(void)viewDidLoad
{
    _network = [SNSNetworkFactory new];
    
    AAShareBubbles *shareBubbles = [[AAShareBubbles alloc] initWithPoint:self.view.center
                                                                  radius:150
                                                                  inView:self.view];
    shareBubbles.delegate = self;
    shareBubbles.bubbleRadius = 30; // Default is 40
    shareBubbles.showFacebookBubble = YES;
    shareBubbles.showTwitterBubble = YES;
    shareBubbles.showGooglePlusBubble = YES;
    shareBubbles.showVkBubble = YES;
    shareBubbles.showInstagramBubble = YES;
    shareBubbles.showLinkedInBubble=YES;
    [shareBubbles show];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    
}
-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType
{
    SNSSocialNetworkType type;
    switch(bubbleType)
    {
        case AAShareBubbleTypeFacebook: type=SNSSocialNetworkTypeFacebook; break;
        case AAShareBubbleTypeLinkedIn: type=SNSSocialNetworkTypeLinkedIn; break;
    }
    id socialNetwork= [_network getNetwork:type];
    [socialNetwork settingDataSource:[SNSPostData sharedPostData]];
    [socialNetwork share];
    //[_network share];
    
    //[self.navigationController pushViewController:_network.controller animated:YES];
}

-(void)aaShareBubblesDidHide {
    NSLog(@"All Bubbles hidden");
}



@end
