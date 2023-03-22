import 'package:flutter/material.dart';

import '../shared/theme.dart';
import '../widgets/delete_popup.dart';

class AdsContentPage extends StatelessWidget {
  const AdsContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SliverPadding(
        padding: EdgeInsets.only(
            right: defaultMargin, left: defaultMargin, top: 24, bottom: 42),
        sliver: SliverAppBar(
          stretch: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: primaryAdminColor,
                ),
              ),
              Text(
                "Ads Content",
                style: primaryAdminColorText.copyWith(
                    fontSize: 24, fontWeight: bold),
              )
            ],
          ),
          backgroundColor: backgroundAdminColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget content() {
      return GridView(
        padding:
            const EdgeInsets.only(top: 24, bottom: 100, left: 20, right: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.4,
          crossAxisSpacing: 30,
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  "assets/ex_gallery.png",
                  height: 160,
                  width: 160,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Keripik Tempe",
                            overflow: TextOverflow.ellipsis,
                            style: primaryAdminColorText.copyWith(
                                fontSize: 16, fontWeight: medium),
                          ),
                          Text(
                            "11.00 - 17.00",
                            overflow: TextOverflow.ellipsis,
                            style: primaryAdminColorText.copyWith(fontSize: 12),
                          ),
                          Text(
                            "Below, Pop Up",
                            overflow: TextOverflow.ellipsis,
                            style: primaryAdminColorText.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: primaryAdminColor,
                      ),
                      color: const Color.fromARGB(255, 223, 223, 223),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                      elevation: 4,
                      onSelected: (value) {
                        if (value == 0) {
                          showDialog(
                              context: context,
                              builder: (context) => DeletePopUp(delete: () {}));
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                            value: 0,
                            child: Text(
                              "Delete",
                              style: primaryAdminColorText,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              header(),
            ];
          },
          body: content(),
        ),
      ),
    );
  }
}