import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.padding,
    this.child,
  });

  final String title;

  final int price;

  final double padding;

  final Widget? child;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(widget.padding),
            decoration: BoxDecoration(
              color: context.colorScheme.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            width: 130,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: widget.child,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 110,
                height: 40,
                child: Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontFamily: FontFamily.geologica,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Text(
                '${widget.price} ₽',
                style: context.textTheme.bodySmall?.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 110,
                height: 28,
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: count != 0
                      ? context.colorScheme.primary
                      : context.colorScheme.onBackground,
                  border: Border.all(
                    color: count != 0
                        ? context.colorScheme.scrim
                        : context.colorScheme.primary,
                  ),
                ),
                child: count != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => count--),
                            child: Icon(
                              Icons.remove_rounded,
                              size: 18,
                              color: context.colorScheme.onBackground,
                            ),
                          ),
                          Text(
                            '$count шт',
                            style: context.textTheme.bodySmall?.copyWith(
                              fontFamily: FontFamily.geologica,
                              color: context.colorScheme.onBackground,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => count++),
                            child: Icon(
                              Icons.add_rounded,
                              size: 18,
                              color: context.colorScheme.onBackground,
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () => setState(() => count++),
                        child: Center(
                          child: Text(
                            'В корзину',
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodySmall?.copyWith(
                              fontFamily: FontFamily.geologica,
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
