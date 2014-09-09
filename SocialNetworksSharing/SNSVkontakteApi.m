//
//  SNSVkontakteApi.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 08.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import "SNSVkontakteApi.h"

@implementation SNSVkontakteApi


-(instancetype)init
{
    self=[super init];
    //_user=[[SLVOAuthSetup new]getUser];
    
    return self;
}

-(void)userData:(Users *)user
{
    self.user=user;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userData" object:self];
}


-(void)settingDataSource:(id<SNSSocialNetworkDataSource>)dataSource
{
    self.dataSource=dataSource;
}



#pragma mark - Ostap__to_mij_mynulyj_metop_share()
-(void)share
{
    if(!self.user)
    {self.oauth=[SLVTokenSocialManager new];
        self.oauth.delegate=self;
        self.oauth.type=SNSSocialNetworkTypeVkontakte;
       [self.oauth getUser];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(share) name:@"userData" object:nil];
        return;
    }
    
    NSString * accessToken = @"d176f24a3174431f434ccd8096c7edb4af03ed39a977e4dc57e1b8792e5c2f38ae91122f88719267c0397"; //should be from DB
    //self.setOa=[SLVOAuthSetup new];
    //[self.setOauth setupWithServiceType:SNSSocialNetworkTypeVkontakte];
    
    UIImage *image = [[SNSPostData sharedPostData] getImage];
    
    NSString *user_id = @"13058851";
    
    NSString *getWallUploadServer = [NSString stringWithFormat:@"https://api.vk.com/method/photos.getWallUploadServer?owner_id=%@&access_token=%@", user_id, accessToken];
    NSDictionary *uploadServer = [self sendRequest:getWallUploadServer];
    NSString *upload_url = [[uploadServer objectForKey:@"response"] objectForKey:@"upload_url"];
    
    //  2
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    NSDictionary *postDictionary = [self sendPOSTRequest:upload_url withImageData:imageData];

    NSString *hash = [postDictionary objectForKey:@"hash"];
    NSString *photo = [postDictionary objectForKey:@"photo"];
    NSString *server = [postDictionary objectForKey:@"server"];
    
    //  3
    NSString *saveWallPhoto = [NSString stringWithFormat:@"https://api.vk.com/method/photos.saveWallPhoto?owner_id=%@&access_token=%@&server=%@&photo=%@&hash=%@", user_id, accessToken,server,photo,hash];
    saveWallPhoto = [saveWallPhoto stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *saveWallPhotoDict = [self sendRequest:saveWallPhoto];
    
    NSDictionary *photoDict = [[saveWallPhotoDict objectForKey:@"response"] lastObject];
    NSString *photoId = [photoDict objectForKey:@"id"];
    
    //  4
    
    
    NSLog(@"photoID: %@", photoId);
    
    NSString *postToWallLink = [NSString stringWithFormat:@"https://api.vk.com/method/wall.post?owner_id=%@&access_token=%@&message=%@&attachment=%@", user_id, accessToken, @"NSString", photoId];
    
    NSDictionary *postToWallDict = [self sendRequest:postToWallLink];
    NSString *errorMsg = [[postToWallDict objectForKey:@"error"] objectForKey:@"error_msg"];
    if(errorMsg) {
        [self sendFailedWithError:errorMsg];
    }

}

- (NSDictionary *) sendRequest:(NSString *)reqURl {
    NSLog(@"Sending request: %@", reqURl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reqURl]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60.0];
    
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    id jsonData = [NSJSONSerialization JSONObjectWithData: responseData options:NSJSONReadingAllowFragments error:nil];
    
    if([jsonData isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict = (NSMutableDictionary*) jsonData;
        
        NSString *errorMsg = [[dict objectForKey:@"error"] objectForKey:@"error_msg"];
        
        NSLog(@"Server response: %@ \nError: %@", dict, errorMsg);
        
        return dict;
    }
    return nil;
}

- (NSDictionary *) sendPOSTRequest:(NSString *)reqURl withImageData:(NSData *)imageData {
    NSLog(@"Sending request: %@", reqURl);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reqURl]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request addValue:@"8bit" forHTTPHeaderField:@"Content-Transfer-Encoding"];
    
    CFUUIDRef uuid = CFUUIDCreate(nil);
    NSString * uuidString = [[NSString alloc] init];
    CFRelease(uuid);
    NSString *stringBoundary = [NSString stringWithFormat:@"0xKhTmLbOuNdArY-%@",uuidString];
    NSString *endItemBoundary = [NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;  boundary=%@", stringBoundary];
    
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"photo\"; filename=\"photo.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
    [body appendData:[[NSString stringWithFormat:@"%@",endItemBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    id jsonData = [NSJSONSerialization JSONObjectWithData: responseData options:NSJSONReadingAllowFragments error:nil];
    
    if([jsonData isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict = (NSMutableDictionary*) jsonData;
        
        NSString *errorMsg = [[dict objectForKey:@"error"] objectForKey:@"error_msg"];
        
        NSLog(@"Server response: %@ \nError: %@", dict, errorMsg);
        
        return dict;
    }
    return nil;
}

- (void) sendFailedWithError:(NSString *)error {
    NSLog(@"errrOOOOOOOrrrr");
}

@end

