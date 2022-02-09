#import <UIKit/UIKit.h>
#import "BButton.h"
#import "google-admob/GADBannerView.h"

@interface SeleccionarJuegoViewController : UIViewController{
    GADBannerView *banner;
}

@property (weak, nonatomic) IBOutlet BButton *sieteEnTreintaButton;
@property (weak, nonatomic) IBOutlet BButton *elMinutoButton;
@property (weak, nonatomic) IBOutlet BButton *lasVeinteButton;

@end
