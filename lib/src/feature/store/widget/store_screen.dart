import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/custom_app_bar.dart';
import 'package:ln_studio/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_studio/src/feature/store/bloc/product_bloc.dart';
import 'package:ln_studio/src/feature/store/bloc/product_event.dart';
import 'package:ln_studio/src/feature/store/bloc/product_state.dart';
import 'package:ln_studio/src/feature/store/model/product.dart';

/// {@template store_screen}
/// StoreScreen widget.
/// {@endtemplate}
class StoreScreen extends StatefulWidget {
  /// {@macro store_screen}
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late final ProductBLoC _productBLoC;

  @override
  void initState() {
    super.initState();
    _productBLoC = ProductBLoC(
      repository: DependenciesScope.of(context).storeRepository,
    );
    _productBLoC.add(const ProductEvent.fecth());
  }

  @override
  void dispose() {
    _productBLoC.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ProductBLoC, ProductState>(
        bloc: _productBLoC,
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              const CustomSliverAppBar(title: 'Магазин'),
              if (!state.hasData)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              if (state.hasData)
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid.builder(
                    itemCount: state.data?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.9,
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final product = state.data![index];
                      return ProductWidget(
                        product: product,
                      );
                    },
                  ),
                ),
            ],
          );
        },
      );
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.imageUrl != null)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl!,
              ),
            ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              product.name,
              style: context.textTheme.bodyLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              product.description,
              style: context.textTheme.bodyMedium?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${product.price} ₽',
              style: context.textTheme.bodyLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
