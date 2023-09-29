import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/common/widget/avatar_widget.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: context.colorScheme.onBackground,
        appBar: AppBar(
          title: Text(
            'Мои записи',
            style: context.textTheme.titleLarge?.copyWith(
              fontFamily: FontFamily.geologica,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.sizeOf(context).width, 60),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16).add(
                const EdgeInsets.only(bottom: 8),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: context.colorScheme.background,
                border: Border.all(color: context.colorScheme.onBackground),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: context.colorScheme.onBackground,
                labelColor: context.colorScheme.onBackground,
                unselectedLabelColor: context.colorScheme.secondary,
                labelStyle: context.textTheme.bodyLarge?.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
                unselectedLabelStyle: context.textTheme.bodyLarge?.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
                tabAlignment: TabAlignment.fill,
                overlayColor: MaterialStatePropertyAll(
                  context.colorScheme.scrim,
                ),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: context.colorScheme.primary,
                ),
                tabs: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Tab(text: 'Предстоящие'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Tab(text: 'Прошедшие'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const SizedBox(
          height: 150,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TabBarView(
              children: [
                BookingHistoryItem(),
                BookingHistoryItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BookingHistoryItem extends StatelessWidget {
  const BookingHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF272727)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AvatarWidget(
                radius: 25,
                title: 'Г В',
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Георгий Волошин',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      color: context.colorScheme.secondary,
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  Text(
                    'Наращивание ресниц',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      color: context.colorScheme.primaryContainer,
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              AnimatedButton(
                padding: const EdgeInsets.only(bottom: 24),
                child: Icon(
                  Icons.more_vert_rounded,
                  size: 20,
                  color: context.colorScheme.secondary,
                ),
              )
            ],
          ),
          const Divider(color: Color(0xFF272727)),
          Text(
            'Дата записи:',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 13,
              color: context.colorScheme.secondary,
              fontFamily: FontFamily.geologica,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '18:30 - 19:30, 1 октября 2023 года',
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.secondary,
              fontFamily: FontFamily.geologica,
            ),
          )
        ],
      ),
    );
  }
}
