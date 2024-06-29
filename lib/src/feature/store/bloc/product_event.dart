sealed class ProductEvent {
  const ProductEvent();

  const factory ProductEvent.fecth() = ProductEvent$Fetch;
}

class ProductEvent$Fetch extends ProductEvent {
  const ProductEvent$Fetch();
}
