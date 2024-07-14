import 'package:flutter/foundation.dart';
import 'package:ln_studio/src/feature/store/model/product.dart';

/// {@template product_state_placeholder}
/// Entity placeholder for ProductState
/// {@endtemplate}
typedef ProductEntity = List<Product>;

/// {@template product_state}
/// ProductState.
/// {@endtemplate}
sealed class ProductState extends _$ProductStateBase {
  /// Idling state
  /// {@macro product_state}
  const factory ProductState.idle({
    required ProductEntity? data,
    String message,
  }) = ProductState$Idle;

  /// Processing
  /// {@macro product_state}
  const factory ProductState.processing({
    required ProductEntity? data,
    String message,
  }) = ProductState$Processing;

  /// Successful
  /// {@macro product_state}
  const factory ProductState.successful({
    required ProductEntity? data,
    String message,
  }) = ProductState$Successful;

  /// An error has occurred
  /// {@macro product_state}
  const factory ProductState.error({
    required ProductEntity? data,
    String message,
  }) = ProductState$Error;

  /// {@macro product_state}
  const ProductState({required super.data, required super.message});
}

/// Idling state
/// {@nodoc}
final class ProductState$Idle extends ProductState with _$ProductState {
  /// {@nodoc}
  const ProductState$Idle({required super.data, super.message = 'Idling'});
}

/// Processing
/// {@nodoc}
final class ProductState$Processing extends ProductState with _$ProductState {
  /// {@nodoc}
  const ProductState$Processing({
    required super.data,
    super.message = 'Processing',
  });
}

/// Successful
/// {@nodoc}
final class ProductState$Successful extends ProductState with _$ProductState {
  /// {@nodoc}
  const ProductState$Successful({
    required super.data,
    super.message = 'Successful',
  });
}

/// Error
/// {@nodoc}
final class ProductState$Error extends ProductState with _$ProductState {
  /// {@nodoc}
  const ProductState$Error({
    required super.data,
    super.message = 'An error has occurred.',
  });
}

/// {@nodoc}
base mixin _$ProductState on ProductState {}

/// Pattern matching for [ProductState].
typedef ProductStateMatch<R, S extends ProductState> = R Function(S state);

/// {@nodoc}
@immutable
abstract base class _$ProductStateBase {
  /// {@nodoc}
  const _$ProductStateBase({required this.data, required this.message});

  /// Data entity payload.
  @nonVirtual
  final ProductEntity? data;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Has data?
  bool get hasData => data != null;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(
        orElse: () => false,
        processing: (_) => true,
      );

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [ProductState].
  R map<R>({
    required ProductStateMatch<R, ProductState$Idle> idle,
    required ProductStateMatch<R, ProductState$Processing> processing,
    required ProductStateMatch<R, ProductState$Successful> successful,
    required ProductStateMatch<R, ProductState$Error> error,
  }) =>
      switch (this) {
        ProductState$Idle s => idle(s),
        ProductState$Processing s => processing(s),
        ProductState$Successful s => successful(s),
        ProductState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [ProductState].
  R maybeMap<R>({
    ProductStateMatch<R, ProductState$Idle>? idle,
    ProductStateMatch<R, ProductState$Processing>? processing,
    ProductStateMatch<R, ProductState$Successful>? successful,
    ProductStateMatch<R, ProductState$Error>? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [ProductState].
  R? mapOrNull<R>({
    ProductStateMatch<R, ProductState$Idle>? idle,
    ProductStateMatch<R, ProductState$Processing>? processing,
    ProductStateMatch<R, ProductState$Successful>? successful,
    ProductStateMatch<R, ProductState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => data.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);
}
