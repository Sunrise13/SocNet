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
    shareBubbles.showLinkedInBubble=YES;
    [shareBubbles show];
    

}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"View appeared %@",self);
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"View will appear %@",self);
}
-(void) viewWillDisappear:(BOOL)animated
{
    NSLog(@" %@View will disapper",self);
}
-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType
{
    SNSSocialNetworkType type = SNSSocialNetworkTypeFacebook;
    switch(bubbleType)
    {
        case AAShareBubbleTypeFacebook: type=SNSSocialNetworkTypeFacebook; break;
        case AAShareBubbleTypeLinkedIn: type=SNSSocialNetworkTypeLinkedIn; break;
        case AAShareBubbleTypeTwitter: type=SNSSocialNetworkTypeTwitter; break;
        case AAShareBubbleTypeVk: type=SNSSocialNetworkTypeVkontakte;   break;
        case AAShareBubbleTypeGooglePlus: type=SNSSocialNetworkTypeGooglePlus; break;
    }
    
    id socialNetwork= [_network getNetwork:type];
    self.some=socialNetwork;
    NSLog(@"in aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:  before share call%@",socialNetwork);
    NSLog(@"%@", socialNetwork);
    [socialNetwork share];
    NSLog(@"in aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:  after share call%@",socialNetwork);

}

-(void)aaShareBubblesDidHide
{
    NSLog(@"All Bubbles hidden");
}



@end
