#import "LasVeinteJuego.h"
#import "Operacion.h"

@implementation LasVeinteJuego

- (id) init {
    if (self = [super init]) {
        numOperacion = 0;
        operaciones = [self generarOperaciones:20 minOperaciones:3];
    }
    
    return self;
}

- (NSString *) getNombre {
    return NSLocalizedString(@"lasveinte", nil);
}

- (NSString *) getGameCenterId {
    return @"las_20";
}

- (NSString *) getAciertosAConseguir {
    return @"/20";
}

- (NSString *) getTemporizador {
    return @"00:00";
}

- (int) getMinutos {
    return 0;
}

- (int) getSegundos {
    return 0;
}

- (int) getSegundosEmpleados:(int) minutosEmpleados
                    segundos:(int) segundosEmpleados {
    
    return minutosEmpleados * 60 + segundosEmpleados;
}
@end