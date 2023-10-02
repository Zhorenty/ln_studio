import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/feature/record/bloc/date/timeblock/timeblock_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/date/timeblock/timeblock_state.dart';

///
class TimeblocksWrap extends StatelessWidget {
  const TimeblocksWrap({
    super.key,
    required this.dateAt,
    this.visible = false,
    this.expanded = false,
  });

  final String dateAt;

  ///
  final bool visible;

  ///
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeblockBloc, TimeblockState>(
      builder: (context, state) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 250),
          alignment: expanded ? Alignment.topCenter : Alignment.topCenter,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: visible ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.colorScheme.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF272727)),
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  ...state.timeblocks.map(
                    (timeblock) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedButton(
                        onPressed: () => context.goNamed(
                          'record',
                          extra: (timeblock, dateAt),
                        ),
                        child: Chip(
                          backgroundColor: context.colorScheme.primary,
                          side: const BorderSide(color: Color(0xFF272727)),
                          label: Text(
                            timeblock.time
                                .substring(0, timeblock.time.length - 3),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onBackground,
                              fontFamily: FontFamily.geologica,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
