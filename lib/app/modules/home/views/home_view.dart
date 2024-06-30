import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Spin Wheel'),
        ),
        body: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(
                  () => FortuneWheel(
                    selected: controller.controller.stream,
                    animateFirst: false,
                    hapticImpact: HapticImpact.light,
                    indicators: const <FortuneIndicator>[
                      FortuneIndicator(
                        alignment: Alignment.topCenter,
                        child: TriangleIndicator(
                          color: Colors.lightGreen,
                          width: 32.0,
                          height: 32.0,
                          elevation: 1,
                        ),
                      ),
                    ],
                    items: List.generate(
                      controller.items.length,
                      (index) => FortuneItem(
                        style: FortuneItemStyle(
                          color: controller
                              .colors[index % controller.colors.length],
                        ),
                        child: Text(
                          controller.items[index],
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    onAnimationEnd: () {
                      // show result when anomation end
                      final result = controller.items[controller.seed];

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Result'),
                            content: Text(
                              result,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              FilledButton(
                                onPressed: () => Get.back(),
                                child: const Text('Ok'),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Items'),
                    const Gap(8.0),
                    TextFormField(
                      controller: controller.itemController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      maxLines: 20,
                      onChanged: (value) {
                        // set items
                        controller.setItems(value.trim());
                      },
                    ),
                    const Gap(8.0),
                    LayoutBuilder(builder: (context, constraints) {
                      return SizedBox(
                        width: constraints.maxWidth,
                        child: FilledButton(
                          onPressed: () {
                            // stream value
                            controller.seed =
                                math.Random().nextInt(controller.items.length);
                            // add stream value
                            controller.controller.addStream(
                              Stream.value(controller.seed),
                            );
                          },
                          child: const Text('Roll!'),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
