#import "Juego.h"
#import "OperacionSumar.h"
#import "OperacionRestar.h"
#import "OperacionMultiplicar.h"
#import "OperacionDividir.h"

#define MINIMO 20
#define MAXIMO 99

#define MAX_MULTI_2 90
#define MAX_MULTI_3 60

#define MIN_DIV 11
#define MAX_DIV 50

@implementation Juego

- (Operacion<Calculo> *) getOperacion {
    if(numOperacion < [operaciones count]){
        return [operaciones objectAtIndex:numOperacion++];
    }
    else{
        return nil;
    }
}

- (NSString *) getNombre {
    return @"";
}

- (NSString *) getGameCenterId {
    return @"";
}

- (NSString *) getAciertosAConseguir {
    return @"";
}

- (NSString *) getTemporizador {
    return @"";
}

- (int) getMinutos {
    return 0;
}

- (int) getSegundos {
    return 0;
}

- (int) getSegundosEmpleados:(int) minutosEmpleados
                    segundos:(int) segundosEmpleados {
    return 0;
}

- (NSMutableArray *) generarOperaciones:(int) numOperaciones
                         minOperaciones:(int) minOperaciones {
    
    int numSumas = 0;
    int numRestas = 0;
    int numMultiplica = 0;
    int numDivide = 0;
    
    int tipoOperacion;
    Operacion *operacion;
    NSMutableArray *operacionesGeneradas = [[NSMutableArray alloc] init];
    
    while ((numSumas + numRestas + numMultiplica + numDivide) < numOperaciones) {
        operacion = nil;
        tipoOperacion = arc4random() % 4;
        
        switch (tipoOperacion) {
            case 0:
                if([self operacionPermitida:@"+" array:operacionesGeneradas]){
                    if(numSumas < minOperaciones){
                        numSumas++;
                        operacion = [self suma];
                    }
                    else if ([self operacionPermitida:@"-" array:operacionesGeneradas] &&
                             numRestas < minOperaciones){
                        numRestas++;
                        operacion = [self resta];
                    }
                    else if ([self operacionPermitida:@"*" array:operacionesGeneradas] &&
                             numMultiplica < minOperaciones){
                        numMultiplica++;
                        operacion = [self multiplica];
                    }
                    else if ([self operacionPermitida:@"/" array:operacionesGeneradas] &&
                             numDivide < minOperaciones){
                        numDivide++;
                        operacion = [self divide];
                    }
                    else{
                        numSumas++;
                        operacion = [self suma];
                    }
                }
                break;
                
            case 1:
                if([self operacionPermitida:@"-" array:operacionesGeneradas]){
                    if(numRestas < minOperaciones){
                        numRestas++;
                        operacion = [self resta];
                    }
                    else if ([self operacionPermitida:@"+" array:operacionesGeneradas] &&
                             numSumas < minOperaciones){
                        numSumas++;
                        operacion = [self suma];
                    }
                    else if ([self operacionPermitida:@"*" array:operacionesGeneradas] &&
                             numMultiplica < minOperaciones){
                        numMultiplica++;
                        operacion = [self multiplica];
                    }
                    else if ([self operacionPermitida:@"/" array:operacionesGeneradas] &&
                             numDivide < minOperaciones){
                        numDivide++;
                        operacion = [self divide];
                    }
                    else{
                        numRestas++;
                        operacion = [self resta];
                    }
                }
                break;
                
            case 2:
                if([self operacionPermitida:@"*" array:operacionesGeneradas]){
                    if(numMultiplica < minOperaciones){
                        numMultiplica++;
                        operacion = [self multiplica];
                    }
                    else if ([self operacionPermitida:@"+" array:operacionesGeneradas] &&
                             numSumas < minOperaciones){
                        numSumas++;
                        operacion = [self suma];
                    }
                    else if ([self operacionPermitida:@"-" array:operacionesGeneradas] &&
                             numRestas < minOperaciones){
                        numRestas++;
                        operacion = [self resta];
                    }
                    else if ([self operacionPermitida:@"/" array:operacionesGeneradas] &&
                             numDivide < minOperaciones){
                        numDivide++;
                        operacion = [self divide];
                    }
                    else{
                        numMultiplica++;
                        operacion = [self multiplica];
                    }
                }
                break;
                
            case 3:
                if([self operacionPermitida:@"/" array:operacionesGeneradas]){
                    if(numDivide < minOperaciones){
                        numDivide++;
                        operacion = [self divide];
                    }
                    else if ([self operacionPermitida:@"+" array:operacionesGeneradas] &&
                             numSumas < minOperaciones){
                        numSumas++;
                        operacion = [self suma];
                    }
                    else if ([self operacionPermitida:@"-" array:operacionesGeneradas] &&
                             numRestas < minOperaciones){
                        numRestas++;
                        operacion = [self resta];
                    }
                    else if ([self operacionPermitida:@"*" array:operacionesGeneradas] &&
                             numMultiplica < minOperaciones){
                        numMultiplica++;
                        operacion = [self multiplica];
                    }
                    else{
                        numDivide++;
                        operacion = [self divide];
                    }
                }
                break;
                
            default:
                if([self operacionPermitida:@"+" array:operacionesGeneradas]){
                    numSumas++;
                    operacion = [self suma];
                }
                else if ([self operacionPermitida:@"-" array:operacionesGeneradas]){
                    numRestas++;
                    operacion = [self resta];
                }
                else if ([self operacionPermitida:@"*" array:operacionesGeneradas]){
                    numMultiplica++;
                    operacion = [self multiplica];
                }
                else{
                    numDivide++;
                    operacion = [self divide];
                }
                break;
        }
        
        if(operacion != nil){
            [operacionesGeneradas addObject: operacion];
        }
    }
    
    return operacionesGeneradas;
}

- (BOOL) operacionPermitida:(NSString *)tipoOperacion
                      array:(NSArray *) array {
    BOOL operacionPermitida = TRUE;
    
    if([array count] >= 2){
        NSString *ultimoTipoOperacion = [[array objectAtIndex:[array count] - 1] tipoCalculo];
        NSString *penultimoTipoOperacion = [[array objectAtIndex:[array count] - 2] tipoCalculo];
        
        if([ultimoTipoOperacion isEqualToString:tipoOperacion] ||
           [penultimoTipoOperacion isEqualToString:tipoOperacion]){
            operacionPermitida = FALSE;
        }
    }
    
    return operacionPermitida;
}

- (Operacion *) suma {
    NSInteger op1;
    NSInteger op2;
    
    do {
        op1 = MINIMO + arc4random() % (MAXIMO - MINIMO + 1);
        op2 = arc4random() % (MAXIMO - op1 + 1);
    } while (![self operandosValidos:op1 op2:op2]);
    
    if(op1 > op2){
        return [[OperacionSumar alloc] initOperacionWith:op1 operando2:op2];
    }
    else{
        return [[OperacionSumar alloc] initOperacionWith:op2 operando2:op1];
    }
}

- (Operacion *) resta {
    NSInteger op1;
    NSInteger op2;
    
    do {
        op1 = MINIMO + arc4random() % (MAXIMO - MINIMO + 1);
        op2 = arc4random() % (MAXIMO - op1 + 1);
    } while (![self operandosValidos:op1 op2:op2]);
    
    if(op1 > op2){
        return [[OperacionRestar alloc] initOperacionWith:op1 operando2:op2];
    }
    else{
        return [[OperacionRestar alloc] initOperacionWith:op2 operando2:op1];
    }
}

- (Operacion *) multiplica {
    NSInteger op1;
    NSInteger op2;
    
    do {
        op2 = 2 + arc4random() % 2;
        
        if(op2 == 2){
            op1 = MINIMO + arc4random() % (MAX_MULTI_2 - MINIMO + 1);
        }
        else{
            op1 = MINIMO + arc4random() % (MAX_MULTI_3 - MINIMO + 1);
        }
    } while (op1 % 10 == 0);
    
    return [[OperacionMultiplicar alloc] initOperacionWith:op1 operando2:op2];
}

- (Operacion *) divide {
    NSInteger op1;
    NSInteger op2;
    NSArray *divisores;
    
    while([self esPrimo:divisores]){
        op1 = MIN_DIV + arc4random() % (MAX_DIV - MIN_DIV + 1);
        divisores = [self divisores:op1];
    }
    
    int posicion = 1 + arc4random() % ([divisores count] - 2);
    
    op2 = [[divisores objectAtIndex:posicion] integerValue];
    
    return [[OperacionDividir alloc] initOperacionWith:op1 operando2:op2];
}

-(NSArray *) divisores:(NSInteger) numero {
    NSMutableArray *divisores = [[NSMutableArray alloc] init];
    
    for(int i = 1; i <= numero; i++){
        if(numero % i == 0){
            [divisores addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    return divisores;
}

-(BOOL) esPrimo:(NSArray *) divisores {
    return [divisores count] <= 2;
}

-(BOOL) operandosValidos:(NSInteger) op1 op2:(NSInteger) op2 {
    return op1 != op2 && op1 % 10 != 0 && op2 % 10 != 0 && op2 >= MINIMO &&
    ![self mismaDecenaYUnidad:op1] && ![self mismaDecenaYUnidad:op2];
}

-(BOOL) mismaDecenaYUnidad:(NSInteger) numero {
    NSString *numeroString = [NSString stringWithFormat:@"%d", numero];
    
    if (numero > 10){
        if (numero < 100){
            return [numeroString characterAtIndex:0] == [numeroString characterAtIndex:1];
        }
        else{
            return [numeroString characterAtIndex:1] == [numeroString characterAtIndex:2];
        }
    }
    
    return NO;
}

@end