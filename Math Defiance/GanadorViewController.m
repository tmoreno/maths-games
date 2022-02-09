#import <Social/Social.h>
#import "GanadorViewController.h"
#import "JuegoViewController.h"
#import "AppDelegate.h"
#import "GameKitHelper.h"

@interface GanadorViewController ()

@end

@implementation GanadorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([_tipoJuego isEqualToString:@"minuto"]){
        [_informacionLabel setText:[NSString stringWithFormat:NSLocalizedString(@"hashecho", nil),
                                    _numAciertos]];
        
        textoTweet = [NSString stringWithFormat:NSLocalizedString(@"hehecho", nil), _numAciertos, _nombreJuego];
    }
    else{
        if(_segundosEmpleados >= 60){
            [_informacionLabel setText:[NSString stringWithFormat:
                                        NSLocalizedString(@"hastardadoenminutos", nil),
                                        _segundosEmpleados / 60,
                                        _segundosEmpleados % 60]];
            
            textoTweet = [NSString stringWithFormat:NSLocalizedString(@"hetardadoenminutos", nil),
                          _segundosEmpleados / 60,
                          _segundosEmpleados % 60,
                          _nombreJuego];
        }
        else{
            [_informacionLabel setText:[NSString stringWithFormat:
                                        NSLocalizedString(@"hastardadoensegundos", nil), _segundosEmpleados]];
            
            textoTweet = [NSString stringWithFormat:NSLocalizedString(@"hetardadoensegundos", nil),
                          _segundosEmpleados, _nombreJuego];
        }
    }
    
    [[self view] setBackgroundColor:[UIColor colorWithRed:240/255.0 green:243/255.0 blue:245/255.0 alpha:1]];
    [_ganadorLabel setText:NSLocalizedString(@"conseguido", nil)];
    
    [[BButton appearance] setButtonCornerRadius:[NSNumber numberWithFloat:10.0f]];
    
    [_otraVezButton setTitle:NSLocalizedString(@"otravez", nil) forState:UIControlStateNormal];
    [_otraVezButton setType:BButtonTypePrimary];
    [_otraVezButton setStyle:BButtonStyleBootstrapV3];
    
    [_menuButton setTitle:NSLocalizedString(@"menu", nil) forState:UIControlStateNormal];
    [_menuButton setType:BButtonTypePrimary];
    [_menuButton setStyle:BButtonStyleBootstrapV3];
    
    [_tweetButton setTitle:NSLocalizedString(@"enviartweet", nil) forState:UIControlStateNormal];
    [_tweetButton setType:BButtonTypeTwitter];
    [_tweetButton setStyle:BButtonStyleBootstrapV3];
    
    [self enviarPuntuacion];
    
    banner = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0,
                                                             0.0,
                                                             GAD_SIZE_320x50.width,
                                                             GAD_SIZE_320x50.height)];
    banner.adUnitID = ADMOB_ID;
    banner.rootViewController = self;
    [[self view] addSubview:banner];
    
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, IOS_ID_DEVICE_1, nil];
    [banner loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"otravez"]) {
        JuegoViewController *vc = [segue destinationViewController];
        [vc setTipoJuego:_tipoJuego];
    }
}

- (IBAction)enviarTweet:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [tweetSheet setInitialText:textoTweet];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NSLocalizedString(@"error", nil)
                                  message:NSLocalizedString(@"errorenviartweet", nil)
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void) enviarPuntuacion {
    int score;
    
    if([_gameCenterId isEqualToString:@"el_minuto"]){
        score = _numAciertos;
    }
    else{
        score = _segundosEmpleados;
    }
    
    [[GameKitHelper sharedGameKitHelper] submitScore:(int64_t)score category:_gameCenterId];
}
@end