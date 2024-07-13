import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                const SliverToBoxAdapter(
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
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final product = state.data![index];
                      return ProductWidget(product: product);
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
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.imageUrl),
          Text(product.name),
          Text(product.description),
          Text(product.price.toString()),
        ],
      ),
    );
  }
}
