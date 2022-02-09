#import "Operacion.h"

@interface Juego : NSObject {
    int numOperacion;
    NSMutableArray *operaciones;
}

- (Operacion<Calculo> *) getOperacion;
- (NSMutableArray *) generarOperaciones:(int) numOperaciones
                         minOperaciones:(int) minOperaciones;
- (Operacion *) suma;
- (Operacion *) resta;
- (Operacion *) multiplica;
- (Operacion *) divide;

- (NSString *) getNombre;
- (NSString *) getGameCenterId;
- (NSString *) getAciertosAConseguir;
- (NSString *) getTemporizador;

- (int) getMinutos;
- (int) getSegundos;
- (int) getSegundosEmpleados:(int) minutosEmpleados
                    segundos:(int) segundosEmpleados;

@end