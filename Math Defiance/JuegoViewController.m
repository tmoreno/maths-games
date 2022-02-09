#import "JuegoViewController.h"
#import "SieteEnTreintaJuego.h"
#import "ElMinutoJuego.h"
#import "LasVeinteJuego.h"
#import "Operacion.h"
#import "GanadorViewController.h"
#import "BButton.h"

int const MAX_MINUTOS = 15;

@interface JuegoViewController ()

@end

@implementation JuegoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        numTeclasPulsadas = 0;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = _tipoJuego;
    
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
    
    [[BButton appearance] setButtonCornerRadius:[NSNumber numberWithFloat:35.0f]];
    
    [[_resultadoUILabel layer] setCornerRadius:7.0];
    [_botonC setTitle:NSLocalizedString(@"borrar", nil) forState:UIControlStateNormal];
    
    NSString *iconString = [NSString fa_stringFromFontAwesomeStrings:[NSString fa_allFontAwesomeStrings]
                                                             forIcon:FAIconChevronLeft];
    
    _botonVolver.titleLabel.font = [UIFont fontWithName:kFontAwesomeFont
                                                   size:_botonVolver.titleLabel.font.pointSize];
    
    [_botonVolver setTitle:iconString forState:UIControlStateNormal];

    
    [self cargarJuego];
}

- (void) cargarJuego {
    // Si la última vez que se jugó se falló el cálculo y se terminó el juego, la siguiente
    // vez que queramos jugar hay que poner la label del resultado en blanco
    [_resultadoUILabel setBackgroundColor:[UIColor blackColor]];
    
    if([_tipoJuego isEqualToString:@"sieteentreinta"]){
        [self aplicarTema:[UIColor colorWithRed:191/255.0 green:231/255.0 blue:242/255.0 alpha:1]
                     tipo:BButtonTypeInfo];
        
        juego = [[SieteEnTreintaJuego alloc] init];
    }
    else if([_tipoJuego isEqualToString:@"minuto"]){
        [self aplicarTema:[UIColor colorWithRed:206/255.0 green:234/255.0 blue:206/255.0 alpha:1]
                     tipo:BButtonTypeSuccess];
        
        juego = [[ElMinutoJuego alloc] init];
    }
    else{
        [self aplicarTema:[UIColor colorWithRed:251/255.0 green:230/255.0 blue:202/255.0 alpha:1]
                     tipo:BButtonTypeWarning];
        
        juego = [[LasVeinteJuego alloc] init];
    }
    
    numAciertos = 0;
    aciertosAConseguir = [juego getAciertosAConseguir];
    [_marcadorUILabel setText:[NSString stringWithFormat:@"%d%@", numAciertos, aciertosAConseguir]];
    
    [self siguienteOperacion];
    
    [self comenzarJuego:[juego getTemporizador]
                minutos:[juego getMinutos]
               segundos:[juego getSegundos]];
}

- (void) aplicarTema:(UIColor *) color
                tipo:(int) tipo {
    [[self view] setBackgroundColor:color];
    
    [_boton1 setType:tipo];
    [_boton1 setStyle:BButtonStyleBootstrapV3];
    
    [_boton2 setType:tipo];
    [_boton2 setStyle:BButtonStyleBootstrapV3];
    
    [_boton3 setType:tipo];
    [_boton3 setStyle:BButtonStyleBootstrapV3];
    
    [_boton4 setType:tipo];
    [_boton4 setStyle:BButtonStyleBootstrapV3];
    
    [_boton5 setType:tipo];
    [_boton5 setStyle:BButtonStyleBootstrapV3];
    
    [_boton6 setType:tipo];
    [_boton6 setStyle:BButtonStyleBootstrapV3];
    
    [_boton7 setType:tipo];
    [_boton7 setStyle:BButtonStyleBootstrapV3];
    
    [_boton8 setType:tipo];
    [_boton8 setStyle:BButtonStyleBootstrapV3];
    
    [_boton9 setType:tipo];
    [_boton9 setStyle:BButtonStyleBootstrapV3];
    
    [_boton0 setType:tipo];
    [_boton0 setStyle:BButtonStyleBootstrapV3];
    
    if (tipo == BButtonTypeInfo) {
        [_botonC setTitleColor:[UIColor bb_infoColorV3]  forState:UIControlStateNormal];
    }
    else if (tipo == BButtonTypeSuccess){
        [_botonC setTitleColor:[UIColor bb_successColorV3]  forState:UIControlStateNormal];
    }
    else {
        [_botonC setTitleColor:[UIColor bb_warningColorV3]  forState:UIControlStateNormal];
    }
}

- (void) siguienteOperacion {
    operacionActual = [juego getOperacion];
    
    // Cuando la operación actual vale nulo es porque el juego ha terminado
    if(operacionActual != nil){
        [_operacionUILabel setText:[NSString stringWithFormat:@"%d %@ %d = ",
                                    [operacionActual operando1],
                                    [operacionActual tipoCalculo],
                                    [operacionActual operando2]]];
    }
    else {
        [cronometro invalidate];
        [self performSegueWithIdentifier:@"juegoterminado" sender:self];
    }
    
    [_resultadoUILabel setText:@""];
}

- (void) comenzarJuego:(NSString*) temporizador
               minutos:(int) minutos
              segundos:(int) segundos{
    
    [_temporizadorUILabel setText:temporizador];
    minutoActual = minutos;
    segundoActual = segundos;
    
    // Distinguimos si el temporizador va hacia delante o hacia atrás
    if(minutos == 0 && segundos == 0){
        cronometro = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(countupUpdate:)
                                                    userInfo:nil
                                                     repeats:YES];
    }
    else{
        cronometro = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(countdownUpdate:)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

- (void)countupUpdate:(NSTimer*)timer {
    if (minutoActual < MAX_MINUTOS){
        if(segundoActual == 59) {
            minutoActual++;
            segundoActual = 0;
        }
        else {
            segundoActual++;
        }
        
        [_temporizadorUILabel setText:[NSString stringWithFormat:@"%02d%@%02d",minutoActual,@":",segundoActual]];
    }
    else {
        [timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"juegoterminado", nil)
                                                        message:NSLocalizedString(@"volveraintentar", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"no", nil)
                                              otherButtonTitles:NSLocalizedString(@"si", nil), nil];
        [alert show];
    }
}

- (void)countdownUpdate:(NSTimer*)timer {
    if (minutoActual > 0 || (minutoActual == 0 && segundoActual > 0)){
        if(segundoActual == 0) {
            minutoActual--;
            segundoActual = 59;
        }
        else if(segundoActual > 0){
            segundoActual--;
        }
        
        [_temporizadorUILabel setText:[NSString stringWithFormat:@"%02d%@%02d",minutoActual,@":",segundoActual]];
    }
    else {
        [timer invalidate];
        
        // Si el juego no tiene un mínimo de aciertos a conseguir, cuando se acaba el tiempo el juego
        // termina mostrando el resultado como ganador
        if([aciertosAConseguir isEqualToString:@""]){
            [self performSegueWithIdentifier:@"juegoterminado" sender:self];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"juegoterminado", nil)
                                                            message:NSLocalizedString(@"volveraintentar2", nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"no", nil)
                                                  otherButtonTitles:NSLocalizedString(@"si", nil), nil];
            [alert show];
        }
    }
}

- (void) pulsarTeclaNumerica:(int) numero {
    numTeclasPulsadas++;
    
    if(_resultadoUILabel.text.length < 3){
        [_resultadoUILabel setText:[NSString stringWithFormat:@"%@%d", _resultadoUILabel.text, numero]];
    }
    
    [self performSelector:@selector(comprobarResultado) withObject:nil afterDelay:1];
}

- (void) comprobarResultado {
    if(numTeclasPulsadas == 1){
        NSInteger resultado = [_resultadoUILabel.text intValue];
        
        if ([operacionActual calcular] == resultado) {
            [_marcadorUILabel setText:[NSString stringWithFormat:@"%d%@", ++numAciertos, aciertosAConseguir]];
            
            [_resultadoUILabel setBackgroundColor:[UIColor blackColor]];
            
            [self siguienteOperacion];
        }
        else {
            [_resultadoUILabel setBackgroundColor:[UIColor redColor]];
        }
    }
    
    numTeclasPulsadas--;
}

- (IBAction)pulsar1:(id)sender {
    [self pulsarTeclaNumerica:1];
}

- (IBAction)pulsar2:(id)sender {
    [self pulsarTeclaNumerica:2];
}

- (IBAction)pulsar3:(id)sender {
    [self pulsarTeclaNumerica:3];
}

- (IBAction)pulsar4:(id)sender {
    [self pulsarTeclaNumerica:4];
}

- (IBAction)pulsar5:(id)sender {
    [self pulsarTeclaNumerica:5];
}

- (IBAction)pulsar6:(id)sender {
    [self pulsarTeclaNumerica:6];
}

- (IBAction)pulsar7:(id)sender {
    [self pulsarTeclaNumerica:7];
}

- (IBAction)pulsar8:(id)sender {
    [self pulsarTeclaNumerica:8];
}

- (IBAction)pulsar9:(id)sender {
    [self pulsarTeclaNumerica:9];
}

- (IBAction)pulsar0:(id)sender {
    if(_resultadoUILabel.text.length != 0){
        [self pulsarTeclaNumerica:0];
    }
}

- (IBAction)pulsarBorrar:(id)sender {
    [_resultadoUILabel setBackgroundColor:[UIColor blackColor]];
    [_resultadoUILabel setText:@""];
}

- (IBAction)pulsarSalir:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"terminarjuego", nil)
                                                    message:NSLocalizedString(@"terminarjuegodesc", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"no", nil)
                                          otherButtonTitles:NSLocalizedString(@"si", nil), nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([[alertView title] isEqualToString:NSLocalizedString(@"terminarjuego", nil)]){
        if(buttonIndex == 1){
            [cronometro invalidate];
            
            [self performSegueWithIdentifier:@"volver" sender:self];
        }
    }
    else{
        if(buttonIndex == 0){
            [self performSegueWithIdentifier:@"volver" sender:self];
        }
        else{
            [self cargarJuego];
        }
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"juegoterminado"]) {
        int segundosEmpleados = [juego getSegundosEmpleados:minutoActual segundos:segundoActual];
        
        GanadorViewController *vc = [segue destinationViewController];
        [vc setNombreJuego:[juego getNombre]];
        [vc setGameCenterId:[juego getGameCenterId]];
        [vc setTipoJuego:_tipoJuego];
        [vc setNumAciertos:numAciertos];
        [vc setSegundosEmpleados:segundosEmpleados];
    }
}
@end
