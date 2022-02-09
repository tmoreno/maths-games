#import <UIKit/UIKit.h>
#import "google-analytics/GAI.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, retain) id<GAITracker> tracker;

@end