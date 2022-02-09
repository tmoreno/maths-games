#import "OperacionDividir.h"

@implementation OperacionDividir

- (NSInteger) calcular {
    return [self operando1] / [self operando2];
}

- (NSString *) tipoCalculo {
    return @"/";
}

@end
