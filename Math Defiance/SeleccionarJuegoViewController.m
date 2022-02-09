#import "SeleccionarJuegoViewController.h"
#import "JuegoViewController.h"
#import "GameKitHelper.h"

@interface SeleccionarJuegoViewController ()

@end

@implementation SeleccionarJuegoViewController

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
    
    [_sieteEnTreintaButton setTitle:NSLocalizedString(@"sienteentreinta", nil) forState:UIControlStateNormal];
    [_elMinutoButton setTitle:NSLocalizedString(@"elminuto", nil) forState:UIControlStateNormal];
    [_lasVeinteButton setTitle:NSLocalizedString(@"lasveinte", nil) forState:UIControlStateNormal];
    
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
    
    [[GameKitHelper sharedGameKitHelper] authenticateLocalPlayer];
    
    [[BButton appearance] setButtonCornerRadius:[NSNumber numberWithFloat:10.0f]];
    
    [_sieteEnTreintaButton setType:BButtonTypeInfo];
    [_sieteEnTreintaButton setStyle:BButtonStyleBootstrapV3];
    
    [_elMinutoButton setType:BButtonTypeSuccess];
    [_elMinutoButton setStyle:BButtonStyleBootstrapV3];
    
    [_lasVeinteButton setType:BButtonTypeWarning];
    [_lasVeinteButton setStyle:BButtonStyleBootstrapV3];
    
    [[self view] setBackgroundColor:[UIColor colorWithRed:240/255.0 green:243/255.0 blue:245/255.0 alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    JuegoViewController *vc = [segue destinationViewController];
    [vc setTipoJuego:segue.identifier];
}

@end
