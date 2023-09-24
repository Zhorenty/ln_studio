import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Category events.
@immutable
sealed class CategoryEvent extends _$CategoryEventBase {
  const CategoryEvent();

  /// Factory for fetching Category.
  const factory CategoryEvent.fetchCategoryWithServices() =
      CategoryEvent$FetchCategoryWithServices;
}

/// [CategoryEvent.fetchCategoryWithServices] event.
final class CategoryEvent$FetchCategoryWithServices extends CategoryEvent {
  const CategoryEvent$FetchCategoryWithServices() : super();
}

/// Category events base class.
abstract base class _$CategoryEventBase {
  const _$CategoryEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, CategoryEvent$FetchCategoryWithServices>
        fetchCategoryWithServices,
  }) =>
      switch (this) {
        final CategoryEvent$FetchCategoryWithServices s =>
          fetchCategoryWithServices(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, CategoryEvent$FetchCategoryWithServices>?
        fetchCategoryWithServices,
  }) =>
      map<R>(
        fetchCategoryWithServices: fetchCategoryWithServices ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, CategoryEvent$FetchCategoryWithServices>?
        fetchCategoryWithServices,
  }) =>
      map<R?>(
        fetchCategoryWithServices: fetchCategoryWithServices ?? (_) => null,
      );
}
