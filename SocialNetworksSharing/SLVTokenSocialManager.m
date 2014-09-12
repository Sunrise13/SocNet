//
//  SLVTokenSocialManager.m
//  SocialNetworks
//
//  Created by Ostap R on 22.08.14.
//  Copyright (c) 2014 SoftServe Lv-120. All rights reserved.
//

#import "SLVTokenSocialManager.h"
#import "SNSOAuthSetupFactory.h"

@interface SLVTokenSocialManager()

@property (nonatomic) SNSOAuthSetupFactory * oauthSetupFactory;
@property (nonatomic) id<SNSOAuthSetupProtocol> oauthSetup;
@property (nonatomic) SLVDBManager *dbManager;

@end

@implementation SLVTokenSocialManager

-(void)getUser
{
    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"Users"];
    NSString * serviceName;
    switch(self.type)
    {
        case SNSSocialNetworkTypeLinkedIn:
            serviceName=@"LinkedIn";
            break;
        case SNSSocialNetworkTypeVkontakte:
            //Add name of your serive Sasha
            break;
        default:
            [NSException raise:@"No service name string" format:@"Assign name of your service with enum number:%i to serviceName variable in switch statment",self.type];
   
    }
    
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"serviceType==[c]\"%@\"", serviceName];
    [request setPredicate:pred];
    NSArray *service=[self.dbManager.context executeFetchRequest:request error:nil];
    if([service count]==0)
    {
        self.oauthSetupFactory=[SNSOAuthSetupFactory new];
        self.oauthSetup=[_oauthSetupFactory getSetupWithType:self.type];
        
        [self.oauthSetup setDelegate:self];
        [self.oauthSetup setup];
        
    }
    else
    {
        [self.delegate userData:service[0]];
    }
    
    
}

-(void)userData:(Users *)user
{
    [self.delegate userData:user];
}

@end
