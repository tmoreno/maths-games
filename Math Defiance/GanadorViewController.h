#import <UIKit/UIKit.h>
#import "BButton.h"
#import "google-admob/GADBannerView.h"

@interface GanadorViewController : UIViewController{
    NSString *textoTweet;
    GADBannerView *banner;
}

@property (weak, nonatomic) NSString *tipoJuego;
@property (weak, nonatomic) NSString *gameCenterId;
@property (weak, nonatomic) NSString *nombreJuego;
@property (nonatomic) NSInteger numAciertos;
@property (nonatomic) NSInteger segundosEmpleados;

@property (weak, nonatomic) IBOutlet UILabel *ganadorLabel;
@property (weak, nonatomic) IBOutlet UILabel *informacionLabel;
@property (weak, nonatomic) IBOutlet BButton *otraVezButton;
@property (weak, nonatomic) IBOutlet BButton *menuButton;
@property (weak, nonatomic) IBOutlet BButton *tweetButton;

@end
