#import "ElMinutoJuego.h"
#import "Operacion.h"

@implementation ElMinutoJuego

- (id) init {
    if (self = [super init]) {
        numOperacion = 0;
        operaciones = [self generarOperaciones:60 minOperaciones:12];
    }
    
    return self;
}

- (NSString *) getNombre {
    return NSLocalizedString(@"elminuto", nil);
}

- (NSString *) getGameCenterId {
    return @"el_minuto";
}

- (NSString *) getAciertosAConseguir {
    return @"";
}

- (NSString *) getTemporizador {
    return @"01:00";
}

- (int) getMinutos {
    return 1;
}

- (int) getSegundos {
    return 0;
}

- (int) getSegundosEmpleados:(int) minutosEmpleados
                    segundos:(int) segundosEmpleados {
    return 60;
}
@end