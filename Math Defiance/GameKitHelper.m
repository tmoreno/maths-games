#import "GameKitHelper.h"

@implementation GameKitHelper

+(id) sharedGameKitHelper {
    static GameKitHelper *sharedGameKitHelper;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedGameKitHelper = [[GameKitHelper alloc] init];
    });
    
    return sharedGameKitHelper;
}

-(void) authenticateLocalPlayer {
    
    GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];
    
    __weak GKLocalPlayer* blockLocalPlayer = localPlayer;
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error) {
        
        [self setLastError:error];
        
        if (blockLocalPlayer.isAuthenticated) {
            _gameCenterFeaturesEnabled = YES;
        }
        else if(viewController) {
            [self presentViewController:viewController];
        }
        else {
            _gameCenterFeaturesEnabled = NO;
        }
    };
}

-(void) setLastError:(NSError*)error {
    _lastError = [error copy];
    
    if (_lastError) {
        NSLog(@"GameKitHelper ERROR: %@", [[_lastError userInfo] description]);
    }
}

-(UIViewController*) getRootViewController {
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

-(void)presentViewController:(UIViewController*)vc {
    UIViewController* rootVC = [self getRootViewController];
    
    [rootVC presentViewController:vc animated:YES completion:nil];
}

-(void) gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController{
    
}

-(void) submitScore:(int64_t)score
           category:(NSString*)category {

    if (_gameCenterFeaturesEnabled) {
        GKScore* gkScore = [[GKScore alloc] initWithCategory:category];
        
        gkScore.value = score;
        
        [gkScore reportScoreWithCompletionHandler:^(NSError* error) {
            if(error){
                NSLog(@"Error %@", error);
            }
        }];
    }
}
@end
