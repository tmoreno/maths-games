#import "Operacion.h"

@implementation Operacion

- (id) initOperacionWith:(NSInteger) operando1
               operando2:(NSInteger) operando2 {
    
    if (self = [super init]) {
        _operando1 = operando1;
        _operando2 = operando2;
    }
    
    return self;
}

@end
