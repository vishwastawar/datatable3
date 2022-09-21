import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'isar/ffd.dart';

// import 'isar/ffd.dart';
import 'isar/ffd.dart';
import 'nav_helper.dart';
import 'screens/addFfddata_screen.dart';
import 'screens/paginated_data_table2.dart';


int offset = 10;
int limit = 10;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar;
  if (!kIsWeb) {
    final dir =
        await getApplicationSupportDirectory(); //get directory for desktop version. c
    isar = await Isar.open([FfdSchema],
        directory: dir.path); //including path for desktop version
  } else {
    isar = await Isar.open([FfdSchema]); //enable this statement for web version

  }
  runApp(MyApp(isar: isar));
}

// const String initialRoute = '/paginated2';
const String initialRoute = '/add';
Scaffold _getScaffold(BuildContext context, Widget body,
    [List<String>? options]) {
  var defaultOption = getCurrentRouteOption(context);
  if (defaultOption.isEmpty && options != null && options.isNotEmpty) {
    defaultOption = options[0];
  }
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.grey[200],
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
            color: Colors.grey[850],
            //screen selection
            child: DropdownButton<String>(
              icon: const Icon(Icons.arrow_forward),
              dropdownColor: Colors.grey[800],
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.white),
              //value: _getCurrentRoute(context),
              onChanged: (v) {
                Navigator.of(context).pushNamed(v!);
              },
              items: const [
                DropdownMenuItem(
                  value: '/paginated2',
                  child: Text('PaginatedDataTable2'),
                ),
              ],
            )),
        options != null && options.isNotEmpty
            ? Flexible(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 4, 0, 4),
                        child: DropdownButton<String>(
                            icon: const SizedBox(),
                            dropdownColor: Colors.grey[300],
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.black),
                            value: defaultOption,
                            onChanged: (v) {
                              // var r = _getCurrentRoute(context);
                              // Navigator.of(context).pushNamed(r, arguments: v);
                            },
                            items: options
                                .map<DropdownMenuItem<String>>(
                                    (v) => DropdownMenuItem<String>(
                                          value: v,
                                          child: Text(v),
                                        ))
                                .toList()))))
            : const SizedBox()
      ]),
    ),
    body: body,
  );
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  final Isar isar;

  const MyApp({Key? key, required this.isar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'main',
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.grey[300],
      ),
      initialRoute: initialRoute,
      routes: {
        // '/paginated2': (context) => _getScaffold(context,
        //     const PaginatedDataTable2Demo(), getOptionsForRoute('/paginated2')),
        '/add': (context) =>
             AddFfdRecords(isar:isar),
      },
    );
  }
}
