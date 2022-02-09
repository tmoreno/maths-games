#import <GameKit/GameKit.h>

@interface GameKitHelper : NSObject<GKGameCenterControllerDelegate> {
    BOOL _gameCenterFeaturesEnabled;
}

@property (nonatomic, readonly) NSError* lastError;

+(id) sharedGameKitHelper;

-(void) authenticateLocalPlayer;

-(void) submitScore:(int64_t)score
           category:(NSString*)category;

@end