import 'package:dice/theme/app_colors.dart';
import 'package:dice/theme/app_text_styles.dart';
import 'package:dice/ui/main_screen/main_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => MainScreenModel(),
        child: const View(),
      );
}

class View extends StatelessWidget {
  const View({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainScreenModel>();
    final dices = <DiceButton>[
      DiceButton(
        icon: Image.asset('images/d2.png'),
        roll: () => model.rollDice(2),
        diceCount: model.d2Count,
      ),
      DiceButton(
        icon: Image.asset('images/d4.png'),
        roll: () => model.rollDice(4),
        diceCount: model.d4Count,
      ),
      DiceButton(
        icon: Image.asset('images/d6.png'),
        roll: () => model.rollDice(6),
        diceCount: model.d6Count,
      ),
      DiceButton(
        icon: Image.asset('images/d8.png'),
        roll: () => model.rollDice(8),
        diceCount: model.d8Count,
      ),
      DiceButton(
        icon: Image.asset('images/d12.png'),
        roll: () => model.rollDice(12),
        diceCount: model.d12Count,
      ),
      DiceButton(
        icon: Image.asset('images/d20.png'),
        roll: () => model.rollDice(20),
        diceCount: model.d20Count,
      ),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.palette,
                color: AppColors.grey,
              ),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (model.result == 0)
              const Text(
                'БРОСАЙ КУБИКИ!',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                    fontStyle: FontStyle.italic),
              ),

            _PreviousRollsWidget(model: model),
            _ResultWidget(model: model),
            const SizedBox(height: 30),

            //   QuoteWidget(model: model),
            const SizedBox(height: 10),
            model.result != 0
                ? _ResetButton(model: model)
                : const SizedBox.shrink(),
            Container(
              height: 200,
              color: const Color.fromRGBO(192, 192, 192, 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _DiceRowWidget(
                    dices: [dices[0], dices[1], dices[2]],
                  ),
                  _DiceRowWidget(
                    dices: [dices[3], dices[4], dices[5]],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({
    super.key,
    required this.model,
  });

  final MainScreenModel model;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => model.reset(),
      icon: const Icon(Icons.restore),
    );
  }
}

class _PreviousRollsWidget extends StatelessWidget {
  const _PreviousRollsWidget({
    super.key,
    required this.model,
  });

  final MainScreenModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(8),
          physics: const BouncingScrollPhysics(),
          itemCount: model.rolls.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    child: Image.asset(
                      model.images[index],
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 25,
                    child: Text(
                      '${model.rolls[index]}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({
    super.key,
    required this.model,
  });

  final MainScreenModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        model.qoute,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}

// class _DiceIconCount extends StatelessWidget {
//   const _DiceIconCount({
//     super.key,
//     required this.model,
//   });

//   final MainScreenModel model;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Image.asset(
//           model.imagePath,
//           height: 100,
//           width: 100,
//         ),
//         Positioned(
//           bottom: 1,
//           right: 5,
//           child: Text(
//             model.diceCount != 0 ? '${model.diceCount}' : '',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//               color: Colors.orange,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class _ResultWidget extends StatelessWidget {
  const _ResultWidget({
    super.key,
    required this.model,
  });

  final MainScreenModel? model;

  @override
  Widget build(BuildContext context) {
    return model?.result != 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => model?.decrement(),
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.grey,
                ),
              ),
              Text(
                '${model?.result}',
                style: AppTextStyles.resultTextStyle,
              ),
              IconButton(
                onPressed: () => model?.increment(),
                icon: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

class _DiceRowWidget extends StatelessWidget {
  final List<DiceButton> dices;
  const _DiceRowWidget({
    super.key,
    required this.dices,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        dices[0],
        dices[1],
        dices[2],
      ],
    );
  }
}

class DiceButton extends StatelessWidget {
  final Image icon;
  final int diceCount;
  final Function() roll;
  const DiceButton({
    super.key,
    required this.icon,
    required this.roll,
    required this.diceCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          splashColor: Colors.grey,
          highlightColor: Colors.grey,
          hoverColor: Colors.grey,
          splashRadius: 40,
          onPressed: roll,
          icon: icon,
          iconSize: 60,
        ),
        diceCount != 0
            ? Positioned(
                right: 5,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.grey,
                  ),
                  child: Center(
                    child: Text(
                      '$diceCount',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
