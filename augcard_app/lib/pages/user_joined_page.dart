import 'package:flutter/material.dart';

class UserJoinedPage extends StatefulWidget {
  static const routeName = '/user-joined';
  const UserJoinedPage({Key? key}) : super(key: key);

  @override
  State<UserJoinedPage> createState() => _UserJoinedPageState();
}

class _UserJoinedPageState extends State<UserJoinedPage> {
  var _playOnTable = true;
  final _players = <String>['Player 2', 'Luigi'];
  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 16);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Successfully Joined!',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const Text(
                "You've successfully connected to the augmented card game. "
                "Enter your nickname and press on ready when you are ready for the game to start.",
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
              _buildNicknameInputField(),
              const SizedBox(height: 16),
              _buildLabel('I am playing...', context),
              const SizedBox(height: 16),
              Center(
                child: _buildToggleButtons(context),
              ),
              sizedBox,
              _buildLabel('Remove Player', context),
              sizedBox,
              _buildPlayerChips(context),
              sizedBox,
              _buildLabel("Camera", context),
              sizedBox,
              _buildWholeWidhtButton('configure'),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 3,
            offset: Offset(0, 0.75),
          ),
        ], color: Theme.of(context).scaffoldBackgroundColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: _buildWholeWidhtButton('leave', elevatedButton: false),
            ),
            const SizedBox(width: 16),
            Flexible(child: _buildWholeWidhtButton('ready')),
          ],
        ),
      ),
    );
  }

  SizedBox _buildWholeWidhtButton(String text, {bool elevatedButton = true}) {
    final child = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );

    return SizedBox(
      width: double.infinity,
      child: elevatedButton
          ? ElevatedButton(onPressed: () {}, child: child)
          : OutlinedButton(onPressed: () {}, child: child),
    );
  }

  Row _buildPlayerChips(BuildContext context) {
    return Row(
      children: _players
          .map((player) => Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Chip(
                  label: Text(player,
                      style: Theme.of(context).textTheme.headline6),
                  deleteIcon: const Icon(Icons.cancel),
                  onDeleted: () {},
                ),
              ))
          .toList(),
    );
  }

  Widget _buildNicknameInputField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Your Nickname',
        prefixIcon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.name,
      autovalidateMode: AutovalidateMode.always,
    );
  }

  ToggleButtons _buildToggleButtons(BuildContext context) {
    return ToggleButtons(
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
          child: Text('...just via App'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
          child: Text('...on the table'),
        )
      ],
      isSelected: [!_playOnTable, _playOnTable],
      splashColor: Theme.of(context).colorScheme.secondary,
      onPressed: (int index) {
        setState(() {
          _playOnTable = index == 1;
        });
      },
    );
  }

  Text _buildLabel(String text, BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
