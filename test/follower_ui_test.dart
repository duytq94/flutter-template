import 'package:flutter/material.dart';
import 'package:flutter_template/common/common_widgets/common_button.dart';
import 'package:flutter_template/ui/followers/models/follower.dart';
import 'package:flutter_template/ui/followers/widgets/bottom_loader.dart';
import 'package:flutter_template/ui/followers/widgets/follower_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets("Check FollowerItem has an avatar and username",
      (widgetTester) async {
    const user = Follower(
        name: "duytq94",
        avatarUrl: "https://avatars.githubusercontent.com/u/24253421?v=4");
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: FollowerItem(follower: user),
        ),
      );
    });

    final nameFinder = find.text(user.name);
    final avatarFinder = find.image(NetworkImage(user.avatarUrl));

    expect(nameFinder, findsOneWidget);
    expect(avatarFinder, findsOneWidget);
  });

  testWidgets("Check BottomLoader instance", (widgetTester) async {
    const bottomLoader = BottomLoader();
    await widgetTester.pumpWidget(
      const MaterialApp(
        home: bottomLoader,
      ),
    );

    expect(find.byWidget(bottomLoader), findsOneWidget);
  });

  testWidgets("Check CommonButton instance", (widgetTester) async {
    var commonButton = CommonButton(
      onPress: () {
        print("CommonButton pressed");
      },
      text: "",
    );
    await widgetTester.pumpWidget(
      MaterialApp(
        home: commonButton,
      ),
    );

    await widgetTester.tap(find.byWidget(commonButton));

    expect(find.byWidget(commonButton), findsOneWidget);
  });
}
