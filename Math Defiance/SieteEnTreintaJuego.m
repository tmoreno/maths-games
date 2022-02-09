#import "SieteEnTreintaJuego.h"
#import "Operacion.h"

@implementation SieteEnTreintaJuego

- (id) init {
    if (self = [super init]) {
        numOperacion = 0;
        operaciones = [[NSMutableArray alloc] init];
        
        int numSumas = 0;
        int numRestas = 0;
        int numMultiplica = 0;
        int numDivide = 0;
        int tipoOperacion;
        Operacion *operacion;
        while ((numSumas + numRestas + numMultiplica + numDivide) < 7) {
            operacion = nil;
            tipoOperacion = arc4random() % 4;
            
            switch (tipoOperacion) {
                case 0:
                    if(numSumas < 2 && ![[[operaciones lastObject] tipoCalculo] isEqualToString:@"+"]){
                        numSumas++;
                        operacion = [self suma];
                    }
                    break;
                    
                case 1:
                    if(numRestas < 2 && ![[[operaciones lastObject] tipoCalculo] isEqualToString:@"-"]){
                        numRestas++;
                        operacion = [self resta];
                    }
                    break;
                    
                case 2:
                    if(numMultiplica < 2 && ![[[operaciones lastObject] tipoCalculo] isEqualToString:@"*"]){
                        numMultiplica++;
                        operacion = [self multiplica];
                    }
                    break;
                    
                case 3:
                    if(numDivide < 2 && ![[[operaciones lastObject] tipoCalculo] isEqualToString:@"/"]){
                        numDivide++;
                        operacion = [self divide];
                    }
                    break;
                    
                default:
                    numSumas++;
                    operacion = [self suma];
                    break;
            }
            
            if(operacion != nil){
                [operaciones addObject: operacion];
            }
        }
    }
    
    return self;
}

- (NSString *) getNombre {
    return NSLocalizedString(@"sienteentreinta", nil);
}

- (NSString *) getGameCenterId {
    return @"7_en_30";
}

- (NSString *) getAciertosAConseguir {
    return @"/7";
}

- (NSString *) getTemporizador {
    return @"00:30";
}

- (int) getMinutos {
    return 0;
}

- (int) getSegundos {
    return 30;
}

- (int) getSegundosEmpleados:(int) minutosEmpleados
                    segundos:(int) segundosEmpleados {
    
    return 30 - segundosEmpleados;
}
@end