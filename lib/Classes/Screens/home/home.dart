import 'package:sensor_tree/Classes/Utils/imports/barrel_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ExpandedTileController _controller;

  bool screenLoader = true;

  var arrHomeData = [];
  @override
  void initState() {
    super.initState();
    _controller = ExpandedTileController(isExpanded: true);

    // call api
    callHomeWB(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().kAppWhiteColor,
      appBar: CustomAppbar(title: AppText().kTextHome),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BluetoothScannerScreen(),
                  ),
                );
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

        // 229 242 254
        /*Center(
          child: ExpandedTile(
            theme: const ExpandedTileThemeData(
              headerColor: Color.fromRGBO(230, 242, 254, 1),
              headerPadding: EdgeInsets.all(24.0),
              headerSplashColor: Color.fromRGBO(230, 242, 254, 1),
              contentBackgroundColor: Color.fromRGBO(230, 242, 254, 1),
              contentPadding: EdgeInsets.all(24.0),
              headerBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(230, 242, 254, 1),
                  width: 5,
                ),
                // borderRadius: BorderRadius.circular(20),
              ),
              fullExpandedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 4),
                // borderRadius: BorderRadius.circular(2),
              ),
            ),
            controller: _controller,
            title: customText("text", 16.0, context),
            content: Container(
              color: Color.fromRGBO(230, 242, 254, 1),
              child: const Center(child: Text("This is the content!")),
            ),
            // footer: Text("this is the footer"),
            onTap: () {
              debugPrint("tapped!!");
            },
            onLongTap: () {
              debugPrint("long tapped!!");
            },
          ),
        ),*/
        ExpandedTileList.builder(
          itemCount: arrHomeData.length,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SubHomeScreen(
                                  getHomeData: arrHomeData[index],
                                ),
                          ),
                        );
                      },
                      child: Container(
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
