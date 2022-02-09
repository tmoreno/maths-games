#import <UIKit/UIKit.h>
#import "Juego.h"
#import "Operacion.h"
#import "BButton.h"
#import "google-analytics/GAITrackedViewController.h"
#import "google-admob/GADBannerView.h"

@interface JuegoViewController : GAITrackedViewController {
    int minutoActual;
    int segundoActual;
    NSTimer *cronometro;
    
    int numAciertos;
    NSString *aciertosAConseguir;
    
    int numTeclasPulsadas;
    
    Juego *juego;
    Operacion<Calculo> *operacionActual;
    
    GADBannerView *banner;
}

@property (weak, nonatomic) NSString *tipoJuego;

@property (weak, nonatomic) IBOutlet UILabel *temporizadorUILabel;
@property (weak, nonatomic) IBOutlet UILabel *marcadorUILabel;
@property (weak, nonatomic) IBOutlet UILabel *operacionUILabel;
@property (weak, nonatomic) IBOutlet UILabel *resultadoUILabel;

@property (weak, nonatomic) IBOutlet BButton *boton1;
@property (weak, nonatomic) IBOutlet BButton *boton2;
@property (weak, nonatomic) IBOutlet BButton *boton3;
@property (weak, nonatomic) IBOutlet BButton *boton4;
@property (weak, nonatomic) IBOutlet BButton *boton5;
@property (weak, nonatomic) IBOutlet BButton *boton6;
@property (weak, nonatomic) IBOutlet BButton *boton7;
@property (weak, nonatomic) IBOutlet BButton *boton8;
@property (weak, nonatomic) IBOutlet BButton *boton9;
@property (weak, nonatomic) IBOutlet BButton *boton0;
@property (weak, nonatomic) IBOutlet UIButton *botonC;
@property (weak, nonatomic) IBOutlet UIButton *botonVolver;

- (IBAction)pulsar1:(id)sender;
- (IBAction)pulsar2:(id)sender;
- (IBAction)pulsar3:(id)sender;
- (IBAction)pulsar4:(id)sender;
- (IBAction)pulsar5:(id)sender;
- (IBAction)pulsar6:(id)sender;
- (IBAction)pulsar7:(id)sender;
- (IBAction)pulsar8:(id)sender;
- (IBAction)pulsar9:(id)sender;
- (IBAction)pulsar0:(id)sender;
- (IBAction)pulsarBorrar:(id)sender;
- (IBAction)pulsarSalir:(id)sender;

@end
