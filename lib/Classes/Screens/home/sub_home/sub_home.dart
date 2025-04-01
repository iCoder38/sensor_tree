import 'package:sensor_tree/Classes/Utils/imports/barrel_imports.dart';

class SubHomeScreen extends StatefulWidget {
  const SubHomeScreen({super.key, this.getHomeData});

  final getHomeData;

  @override
  State<SubHomeScreen> createState() => _SubHomeScreenState();
}

class _SubHomeScreenState extends State<SubHomeScreen> {
  bool screenLoader = true;
  var arrHomeData = [];

  late Map<dynamic, dynamic> storeHomeData;

  String storeCategoryName = '';

  @override
  void initState() {
    super.initState();

    storeHomeData = widget.getHomeData;
    customLog(storeHomeData);

    // store and parse
    storeAndParseValues();
  }

  void storeAndParseValues() {
    // store values
    storeCategoryName = storeHomeData["category_name"].toString();

    //refresh screen
    setState(() {
      screenLoader = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().kAppWhiteColor,
      appBar: CustomAppbar(
        title: storeCategoryName,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left, color: AppColor().kAppWhiteColor),
        ),
      ),
      body: screenLoader ? SizedBox() : _UIKit(),
    );
  }

  Widget _UIKit() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: CustomSearchBar()),
            IconButton(
              onPressed: () {
                customLog("Bell ring");
              },
              icon: Icon(Icons.notifications_none),
            ),
            IconButton(
              onPressed: () {
                customLog("Help info");
              },
              icon: Icon(Icons.help_outline_outlined),
            ),
          ],
        ),

        ExpandedTileList.builder(
          itemCount: 1,
          // maxOpened: 2,
          reverse: false,
          itemBuilder: (context, index, con) {
            return ExpandedTile(
              theme: const ExpandedTileThemeData(
                // initiallyOpenedControllersIndexes: [0,3],
                headerColor: Color.fromRGBO(230, 242, 254, 1),
                headerPadding: EdgeInsets.all(24.0),
                headerSplashColor: Color.fromRGBO(230, 242, 254, 1),
                //
                contentBackgroundColor: Color.fromRGBO(230, 242, 254, 1),
                contentPadding: EdgeInsets.all(24.0),
              ),
              controller: con,
              title: customText(
                arrHomeData[index]["category_name"],
                16.0,
                context,
                fontWeight: FontWeight.w800,
              ),
              content: Column(
                children: [
                  for (
                    int i = 0;
                    i < arrHomeData[index]["sites"].length;
                    i++
                  ) ...[
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(230, 242, 254, 1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 2,
                          color: AppColor().kAppNavigationColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: customText(
                              arrHomeData[index]["sites"][i]["site_name"]
                                  .toString(),
                              14,
                              context,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ],
              ),
              onTap: () {
                debugPrint("tapped!!");
              },
              onLongTap: () {
                debugPrint("looooooooooong tapped!!");
              },
            );
          },
        ),
      ],
    );
  }

  // ====================== API ================================================
  // ====================== HOME
  Future<void> callHomeWB(context) async {
    // get token
    String? token = await getToken();
    customLog("Token ==> $token");
    Map<String, dynamic> response = await ApiService().getRequestWithoutParams(
      ApiEndPoint().kEndPointHome,
      token: token,
    );
    customLog(response);
    if (response['status'] == true) {
      customLog("Home successfull");
      arrHomeData = response["response"];
      setState(() {
        screenLoader = false;
      });
    } else {
      customLog("Failed to call home: ${response['error']}");
      customLog("home failed");
    }
  }
}
